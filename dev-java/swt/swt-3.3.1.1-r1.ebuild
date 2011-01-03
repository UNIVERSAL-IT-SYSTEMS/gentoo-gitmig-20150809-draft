# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/swt/swt-3.3.1.1-r1.ebuild,v 1.13 2011/01/03 20:39:22 caster Exp $

EAPI="1"

inherit eutils java-pkg-2 java-ant-2 toolchain-funcs java-osgi

MY_PV="${PV}"
MY_DMF="download.eclipse.org/eclipse/downloads/drops/R-${MY_PV}-200710231652"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="GTK based SWT Library"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="x86? (
			http://${MY_DMF}/${MY_P}-gtk-linux-x86.zip
		)
		x86-fbsd? (
			http://${MY_DMF}/${MY_P}-gtk-linux-x86.zip
		)
		amd64? (
			http://${MY_DMF}/${MY_P}-gtk-linux-x86_64.zip
		)
		ppc? (
			http://${MY_DMF}/${MY_P}-gtk-linux-ppc.zip
		)"

SLOT="3"
LICENSE="CPL-1.0 LGPL-2.1 MPL-1.1"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"

IUSE="cairo firefox gnome opengl xulrunner"
COMMON=">=dev-libs/glib-2.6
		>=x11-libs/gtk+-2.6.8
		>=dev-libs/atk-1.10.2
		cairo? ( >=x11-libs/cairo-1.0.2 )
		gnome?	(
					=gnome-base/libgnome-2*
					=gnome-base/gnome-vfs-2*
					=gnome-base/libgnomeui-2*
				)
		opengl?	(
			virtual/opengl
			virtual/glu
		)
		x11-libs/libXtst"

# Masked in base/package.use.mask
#
# firefox? ( !xulrunner? (
# 	=www-client/mozilla-firefox-2*
# 	>=dev-libs/nspr-4.6.2
# ) )
# xulrunner? (
# 	net-libs/xulrunner:1.8
# 	>=dev-libs/nspr-4.6.2
# )

# libXtst/xextproto is done like this due to the XTest.h move - bug #292244
DEPEND=">=virtual/jdk-1.4
		app-arch/unzip
		x11-libs/libX11
		x11-libs/libXrender
		x11-libs/libXt
		|| ( >=x11-libs/libXtst-1.1.0 <x11-proto/xextproto-7.1 )
		dev-util/pkgconfig
		${COMMON}"

RDEPEND=">=virtual/jre-1.4
		${COMMON}"

S="${WORKDIR}"

# JNI libraries don't need SONAME, bug #253756
QA_SONAME="usr/$(get_libdir)/libswt-.*.so"

src_unpack() {
	local DISTFILE=${A}
	unzip -jq "${DISTDIR}"/${DISTFILE} "*src.zip" || die "unable to extract distfile"
	unpack ./src.zip

	# Cleanup the redirtied directory structure
	rm -rf about_files/ || die

	# Replace the build.xml to allow compilation without Eclipse tasks
	cp "${FILESDIR}/build.xml" "${S}/build.xml" || die "Unable to update build.xml"
	mkdir "${S}/src" && mv "${S}/org" "${S}/src" || die "Unable to restructure SWT sources"

	# Fix Makefiles to respect flags and work with --as-needed
	epatch "${FILESDIR}"/as-needed-and-flag-fixes.patch

	# kill some strict-aliasing warnings
	epatch "${FILESDIR}/${PN}-3.3-callback-pointer-dereferencing.patch"
}

get_gecko() {
	local gecko

	# order here match the logic in DEPEND and USE flag descriptions
	use firefox && gecko="firefox"
	use xulrunner && gecko="xulrunner"

	echo ${gecko}
}

src_compile() {
	# Drop jikes support as it seems to be unfriendly with SWT
	java-pkg_filter-compiler jikes

	local AWT_ARCH
	local JAWTSO="libjawt.so"
	if [[ $(tc-arch) == 'x86' ]] ; then
		AWT_ARCH="i386"
	elif [[ $(tc-arch) == 'ppc' ]] ; then
		AWT_ARCH="ppc"
	else
		AWT_ARCH="amd64"
	fi
	if [[ -f "${JAVA_HOME}/jre/lib/${AWT_ARCH}/${JAWTSO}" ]]; then
		export AWT_LIB_PATH="${JAVA_HOME}/jre/lib/${AWT_ARCH}"
	elif [[ -f "${JAVA_HOME}/jre/bin/${JAWTSO}" ]]; then
		export AWT_LIB_PATH="${JAVA_HOME}/jre/bin"
	elif [[ -f "${JAVA_HOME}/$(get_libdir)/${JAWTSO}" ]] ; then
		export AWT_LIB_PATH="${JAVA_HOME}/$(get_libdir)"
	else
		eerror "${JAWTSO} not found in the JDK being used for compilation!"
		die "cannot build AWT library"
	fi

	# Fix the pointer size for AMD64
	[[ ${ARCH} == 'amd64' ]] && export SWT_PTR_CFLAGS=-DSWT_PTR_SIZE_64

	local platform="linux"

	use elibc_FreeBSD && platform="freebsd"

	local make="emake -f make_${platform}.mak NO_STRIP=y"

	einfo "Building AWT library"
	${make} make_awt || die "Failed to build AWT support"

	einfo "Building SWT library"
	${make} make_swt || die "Failed to build SWT support"

	einfo "Building JAVA-AT-SPI bridge"
	${make} make_atk || die "Failed to build ATK support"

	if use gnome ; then
		einfo "Building GNOME VFS support"
		${make} make_gnome || die "Failed to build GNOME VFS support"
	fi

	local gecko="$(get_gecko)"
	if [[ ${gecko} ]]; then
		einfo "Building the Mozilla component against ${gecko}"
		#local idir="$(pkg-config ${gecko}-xpcom --variable=includedir)"
		local inc="$(pkg-config ${gecko}-xpcom --cflags)"
		local libs="$(pkg-config ${gecko}-xpcom --libs)"
		MOZILLA_INCLUDES="${inc}" \
		MOZILLA_LIBS="${libs}" \
			${make} make_mozilla || die "Failed to build ${gecko} support"
		if [[ "${gecko}" = "xulrunner" ]]; then
			XULRUNNER_INCLUDES="${inc}" \
			XULRUNNER_LIBS="${libs}" \
				${make} make_xulrunner || die "Failed to build ${gecko} support"
		fi
	fi

	if use cairo ; then
		einfo "Building CAIRO support"
		${make} make_cairo || die "Unable to build CAIRO support"
	fi

	if use opengl ; then
		einfo "Building OpenGL component"
		${make} make_glx || die "Unable to build OpenGL component"
	fi

	einfo "Building JNI libraries"
	eant compile

	einfo "Copying missing files"
	cp -i "${S}/version.txt" "${S}/build/version.txt"
	cp -i "${S}/src/org/eclipse/swt/internal/SWTMessages.properties" \
		"${S}/build/org/eclipse/swt/internal/"

	einfo "Packing JNI libraries"
	eant jar
}

src_install() {
	swtArch=${ARCH}
	use amd64 && swtArch=x86_64
	use x86-fbsd && swtArch=x86

	sed "s/SWT_ARCH/${swtArch}/" "${FILESDIR}/${PN}-3.3-manifest" > MANIFEST_TMP.MF
	java-osgi_newjar-fromfile "swt.jar" "MANIFEST_TMP.MF" "Standard Widget Toolkit for GTK 2.0"

	java-pkg_sointo /usr/$(get_libdir)
	java-pkg_doso *.so

	local gecko="$(get_gecko)"
	if [[ -n "${gecko}" ]]; then
		local gecko_dir="$(pkg-config ${gecko}-xpcom --variable=libdir)"
		java-pkg_register-environment-variable MOZILLA_FIVE_HOME "${gecko_dir}"
	fi

	dohtml about.html || die
}

pkg_postinst() {
	local gecko="$(get_gecko)"
	if [[ -n "${gecko}" ]]; then
		local gecko_dir="$(pkg-config ${gecko}-xpcom --variable=libdir)"
		elog "You built swt with ${gecko} support. For your custom applications please set"
		elog "MOZILLA_FIVE_HOME environment variable to ${gecko_dir}"
	fi
}
