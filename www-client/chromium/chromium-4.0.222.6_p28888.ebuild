# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/chromium/chromium-4.0.222.6_p28888.ebuild,v 1.2 2009/10/29 08:41:42 voyageur Exp $

EAPI="2"
inherit eutils multilib toolchain-funcs

DESCRIPTION="Open-source version of Google Chrome web browser"
HOMEPAGE="http://chromium.org/"
#SRC_URI="http://build.chromium.org/buildbot/archives/${P}.tar.bz2"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-arch/bzip2
	dev-libs/libxml2
	dev-libs/libxslt
	>=dev-libs/nss-3.12.2
	>=gnome-base/gconf-2.24.0
	media-fonts/corefonts
	>=media-libs/alsa-lib-1.0.19
	media-libs/jpeg
	media-libs/libpng
	>=media-video/ffmpeg-0.5_p19787
	>=x11-libs/gtk+-2.14.7"
#	sys-libs/zlib
#	>=dev-libs/libevent-1.4.13
#	dev-db/sqlite:3
DEPEND="${RDEPEND}
	>=dev-util/gperf-3.0.3
	>=dev-util/pkgconfig-0.23"

export CHROMIUM_HOME=/usr/$(get_libdir)/chromium-browser

src_prepare() {
	# Changing this in ~/include.gypi does not work
	sed -i "s/'-Werror'/''/" build/common.gypi || die "Werror sed failed"
	# Prevent automatic -march=pentium4 -msse2 enabling on x86, http://crbug.com/9007
	epatch "${FILESDIR}"/${PN}-drop_sse2.patch
	# Add configuration flag to use system libevent
	epatch "${FILESDIR}"/${PN}-use_system_libevent.patch

	# Display correct svn revision in about box (if not a release)
	if [[ "${PV}" =~ "_p" ]]; then
		echo "${PV/[0-9.]*\_p}" > build/LASTCHANGE.in || die "setting revision failed"
	fi
}

src_configure() {
	# CFLAGS/LDFLAGS
	mkdir -p "${S}"/.gyp
	cat << EOF > "${S}"/.gyp/include.gypi
{
	'target_defaults': {
		'cflags': [ '${CFLAGS// /','}' ],
		'ldflags': [ '${LDFLAGS// /','}' ],
	},
}
EOF
	export HOME="${S}"

	# Configuration options (system libraries)
	local myconf="-Duse_system_bzip2=1 -Duse_system_libjpeg=1 -Duse_system_libpng=1 -Duse_system_libxml=1 -Duse_system_libxslt=1 -Duse_system_ffmpeg=1"
	# -Duse_system_zlib=1: needs mozzconf.h and some MOZ_Z_* functions
	# -Duse_system_libevent=1: http://crbug.com/22140
	# -Duse_system_sqlite=1 : http://crbug.com/22208
	# Others still bundled: icu (not possible?), hunspell (changes required for sandbox support)

	# Sandbox paths
	myconf="${myconf} -Dlinux_sandbox_path=${CHROMIUM_HOME}/chrome_sandbox -Dlinux_sandbox_chrome_path=${CHROMIUM_HOME}/chrome"

	if use amd64; then
		myconf="${myconf} -Dtarget_arch=x64"
	fi
	if [[ "$(gcc-major-version)$(gcc-minor-version)" == "44" ]]; then
		myconf="${myconf} -Dno_strict_aliasing=1 -Dgcc_version=44"
	fi

	build/gyp_chromium -f make build/all.gyp ${myconf} --depth=. || die "gyp failed"
}

src_compile() {
	emake -r V=1 chrome chrome_sandbox BUILDTYPE=Release \
		rootdir="${S}" \
		CC=$(tc-getCC) \
		CXX=$(tc-getCXX) \
		AR=$(tc-getAR) \
		RANLIB=$(tc-getRANLIB) \
		|| die "compilation failed"
}

src_install() {
	# Chromium does not have "install" target in the build system.

	dodir ${CHROMIUM_HOME}

	exeinto ${CHROMIUM_HOME}
	doexe out/Release/chrome
	doexe out/Release/chrome_sandbox
	fperms 4755 ${CHROMIUM_HOME}/chrome_sandbox
	doexe out/Release/xdg-settings
	doexe "${FILESDIR}"/chromium-launcher.sh

	insinto ${CHROMIUM_HOME}
	doins out/Release/chrome.pak

	doins -r out/Release/locales
	doins -r out/Release/resources
	doins -r out/Release/themes

	newman out/Release/chromium-browser.1 chrome.1

	# Chromium looks for these in its folder
	# See media_posix.cc and base_paths_linux.cc
	dosym /usr/$(get_libdir)/libavcodec.so.52 ${CHROMIUM_HOME}
	dosym /usr/$(get_libdir)/libavformat.so.52 ${CHROMIUM_HOME}
	dosym /usr/$(get_libdir)/libavutil.so.50 ${CHROMIUM_HOME}

	# Plugins symlink
	dosym /usr/$(get_libdir)/nsbrowser/plugins ${CHROMIUM_HOME}/plugins

	newicon out/Release/product_logo_48.png ${PN}-browser.png
	dosym ${CHROMIUM_HOME}/chromium-launcher.sh /usr/bin/chromium
	make_desktop_entry chromium "Chromium" ${PN}-browser "Network;WebBrowser"
	sed -e "/^Exec/s/$/ %U/" -i "${D}"/usr/share/applications/*.desktop \
		|| die "desktop file sed failed"
}
