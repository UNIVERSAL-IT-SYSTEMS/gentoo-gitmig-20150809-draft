# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/rss-glx/rss-glx-0.8.0.ebuild,v 1.2 2005/04/25 11:47:10 liquidx Exp $

inherit flag-o-matic eutils

MY_P=${PN}_${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Really Slick Screensavers using OpenGL for XScreenSaver"
HOMEPAGE="http://rss-glx.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="kde sse 3dnow openal xscreensaver"

DEPEND="virtual/x11
	virtual/opengl
	>=media-gfx/imagemagick-5.5.7
	kde? ( || ( kde-base/kscreensaver kde-base/kdeartwork ) )
	!kde? ( x11-misc/xscreensaver )
	openal? ( media-libs/openal )"

pkg_setup() {
	if use kde && use xscreensaver ; then
		if ! built_with_use kde-base/kdeartwork-kscreensaver xscreensaver && \
		   ! built_with_use kde-base/kdeartwork xscreensaver ; then
			eerror "rss-glx wont work nicely with kde unless you"
			eerror "emerge kscreensaver with USE=xscreensaver"
			eerror "See http://bugs.gentoo.org/show_bug.cgi?id=88212"
			die "Please re-emerge your KDE with USE=xscreensaver"
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-0.8.0-kdedesktop.patch
	epatch ${FILESDIR}/${PN}-0.8.0-assert.patch
	cp ${FILESDIR}/jwz-vroot.h ${S}/include/vroot.h
}

src_compile() {
	filter-flags -fPIC

	local myconf

	myconf="${myconf} --bindir=/usr/lib/xscreensaver" \
	myconf="${myconf} --with-configdir=/usr/share/control-center/screensavers/" \

	if use kde; then
		find . -name '*.desktop' -exec \
			sed -i \
				-e 's:Exec=kxsrun \(.*\):Exec=kxsrun \1:g' \
				-e 's:Exec=kxsconfig \(.*\):Exec=kxsconfig \1:g' \
				'{}' \
			\; \
			|| die "couldnt sed desktop files"
		myconf="${myconf} --with-kdessconfigdir=/usr/share/applnk/System/ScreenSavers"
	fi

	econf \
		`use_enable sse` \
		`use_enable 3dnow` \
		`use_enable openal sound` \
		${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc COPYING INSTALL README README.xscreensaver

	# symlink to satisfy kde's kxs*
	use kde && dosym /usr/share/control-center/screensavers /usr/lib/xscreensaver/config
}

pkg_postinst() {
	local XSCREENSAVER_CONF="${ROOT}/usr/X11R6/lib/X11/app-defaults/XScreenSaver"

	if [ -f ${XSCREENSAVER_CONF} -a -z "`grep 'Euphoria' ${XSCREENSAVER_CONF}`" ]; then
		einfo "Adding Really Slick Screensavers to XScreenSaver"
		sed -e '/*programs:/a\
	GL:       \"Cyclone\"  cyclone --root     \\n\\\
	GL:      \"Euphoria\"  euphoria --root    \\n\\\
	GL:    \"Fieldlines\"  fieldlines --root  \\n\\\
	GL:        \"Flocks\"  flocks --root      \\n\\\
	GL:          \"Flux\"  flux --root        \\n\\\
	GL:        \"Helios\"  helios --root      \\n\\\
	GL:       \"Lattice\"  lattice --root     \\n\\\
	GL:        \"Plasma\"  plasma --root      \\n\\\
	GL:     \"Skyrocket\"  skyrocket --root   \\n\\\
	GL:    \"Solarwinds\"  solarwinds --root  \\n\\\
	GL:     \"Colorfire\"  colorfire --root   \\n\\\
	GL:   \"Hufos Smoke\"  hufo_smoke --root  \\n\\\
	GL:  \"Hufos Tunnel\"  hufo_tunnel --root \\n\\\
	GL:    \"Sundancer2\"  sundancer2 --root  \\n\\\
	GL:          \"BioF\"  biof --root        \\n\\\
	GL:    \"MatrixView\"  matrixview --root  \\n\\\
	GL:   \"Spirographx\"  spirographx --root \\n\\\
	GL:   \"BusySpheres\"  busyspheres --root \\n\\' \
		-i ${XSCREENSAVER_CONF}

	else
		einfo "Unable to add these to XScreenSaver configuration"
		einfo "Read /usr/share/doc/${PF}/README.xscreensaver.gz for"
		einfo "entries to add to your ~/.xscreensaver file to enable these hacks"
	fi
}

pkg_postrm() {
	local XSCREENSAVER_CONF="${ROOT}/usr/X11R6/lib/X11/app-defaults/XScreenSaver"

	has_version rss-glx && return 0
	if [ -f ${XSCREENSAVER_CONF} ]; then
		einfo "Removing Really Slick Screensavers from XScreenSaver configuration."
		sed \
			-e '/\"Cyclone\"  cyclone/d' \
			-e '/\"Euphoria\"  euphoria/d' \
			-e '/\"Fieldlines\"  fieldlines/d' \
			-e '/\"Flocks\"  flocks/d' \
			-e '/\"Flux\"  flux/d' \
			-e '/\"Helios\"  helios/d' \
			-e '/\"Lattice\"  lattice/d' \
			-e '/\"Plasma\"  plasma/d' \
			-e '/\"Skyrocket\"  skyrocket/d' \
			-e '/\"Solarwinds\"  solarwinds/d' \
			-e '/\"Colorfire\"  colorfire/d' \
			-e '/\"Hufos Smoke\"  hufo_smoke/d' \
			-e '/\"Hufos Tunnel\"  hufo_tunnel/d' \
			-e '/\"Sundancer2\"  sundancer2/d' \
			-e '/\"BioF\"  biof/d' \
			-e '/\"MatrixView\"  matrixview/d' \
			-e '/\"Spirographx\"  spirographx/d' \
			-e '/\"BusySpheres\"  busyspheres/d' \
			-i ${XSCREENSAVER_CONF}
	fi
}
