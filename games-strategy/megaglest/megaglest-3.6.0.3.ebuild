# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/megaglest/megaglest-3.6.0.3.ebuild,v 1.3 2012/09/06 20:57:28 hasufell Exp $

EAPI=4
inherit eutils flag-o-matic cmake-utils wxwidgets gnome2-utils games

DESCRIPTION="Cross-platform 3D realtime strategy game"
HOMEPAGE="http://www.megaglest.org/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-source-${PV}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +editor freetype +ftgl sse sse2 sse3 static +streflop +tools +unicode wxuniversal +model-viewer"

RDEPEND="
	>=dev-lang/lua-5.1
	dev-libs/icu
	dev-libs/libxml2
	media-libs/fontconfig
	media-libs/libsdl[X,audio,joystick,opengl,video]
	media-libs/libvorbis
	media-libs/openal
	net-libs/gnutls
	sys-libs/zlib
	virtual/opengl
	virtual/glu
	x11-libs/libX11
	x11-libs/libXext
	editor? ( x11-libs/wxGTK:2.8[X] )
	freetype? ( media-libs/freetype )
	model-viewer? ( x11-libs/wxGTK:2.8[X] )
	!static? (
		dev-libs/xerces-c
		media-libs/glew
		media-libs/libogg
		media-libs/libpng:0
		net-libs/miniupnpc
		net-misc/curl
		virtual/jpeg
		ftgl? ( media-libs/ftgl )
	)"
DEPEND="${RDEPEND}
	net-libs/libircclient
	sys-apps/help2man
	virtual/pkgconfig
	static? (
		dev-libs/xerces-c[static-libs]
		media-libs/glew[static-libs]
		media-libs/libogg[static-libs]
		media-libs/libpng:0[static-libs]
		net-libs/miniupnpc[static-libs]
		net-misc/curl[static-libs]
		virtual/jpeg[static-libs]
		ftgl? ( media-libs/ftgl[static-libs] )
	)"
PDEPEND="~games-strategy/${PN}-data-${PV}"

src_prepare() {
	if use editor || use model-viewer ; then
		WX_GTK_VER="2.8"
		need-wxwidgets unicode
	fi

	epatch "${FILESDIR}"/${P}-{static-build,build,as-needed}.patch
}

src_configure() {
	if use sse3; then
		SSE=3
	elif use sse2; then
		SSE=2
	elif use sse; then
		SSE=1
	else
		SSE=0
	fi

	local mycmakeargs=(
		# configurator is deprecated and not included on purpose
		-DBUILD_MEGAGLEST_CONFIGURATOR=OFF
		$(cmake-utils_use_build editor MEGAGLEST_MAP_EDITOR)
		$(cmake-utils_use_build tools MEGAGLEST_MODEL_IMPORT_EXPORT_TOOLS)
		$(cmake-utils_use_build model-viewer MEGAGLEST_MODEL_VIEWER)
		-DMAX_SSE_LEVEL_DESIRED="${SSE}"
		-DMEGAGLEST_BIN_INSTALL_PATH="${GAMES_BINDIR}"
		-DMEGAGLEST_DATA_INSTALL_PATH="${GAMES_DATADIR}/${PN}"
		# icons are used at runtime, wrong default location share/pixmaps
		-DMEGAGLEST_ICON_INSTALL_PATH="${GAMES_DATADIR}/${PN}"
		$(cmake-utils_use_use freetype FREETYPEGL)
		$(cmake-utils_use_use ftgl FTGL)
		$(cmake-utils_use_want static STATIC_LIBS)
		$(cmake-utils_use_want streflop STREFLOP)
		-DWANT_SVN_STAMP=off
		$(cmake-utils_use static wxWidgets_USE_STATIC)
		$(cmake-utils_use unicode wxWidgets_USE_UNICODE)
		$(cmake-utils_use wxuniversal wxWidgets_USE_UNIVERSAL)

		$(usex debug "-DBUILD_MEGAGLEST_UPNP_DEBUG=ON -DwxWidgets_USE_DEBUG=ON" "")
	)

	# support CMAKE_BUILD_TYPE=Gentoo
	append-cppflags '-DCUSTOM_DATA_INSTALL_PATH=\\\"'${GAMES_DATADIR}/${PN}/'\\\"'

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	# rebuilds some targets randomly without fast option
	emake -C "${CMAKE_BUILD_DIR}" DESTDIR="${D}" "$@" install/fast

	dodoc {AUTHORS.source_code,CHANGELOG,README}.txt
	doicon -s 48 ${PN}.png

	use editor &&
		make_desktop_entry ${PN}_editor "MegaGlest Map Editor"
	use model-viewer &&
		make_desktop_entry ${PN}_g3dviewer "MegaGlest Model Viewer"

	# provided by megaglest-data
	rm "${D}${GAMES_DATADIR}"/${PN}/${PN}.bmp || die

	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	einfo
	elog 'Note about Configuration:'
	elog 'DO NOT directly edit glest.ini and glestkeys.ini but rather glestuser.ini'
	elog 'and glestuserkeys.ini in ~/.megaglest/ and create your user over-ride'
	elog 'values in these files.'
	elog
	elog 'If you have an older graphics card which only supports OpenGL 1.2, and the'
	elog 'game crashes when you try to play, try starting with "megaglest --disable-vbo"'
	elog 'Some graphics cards may require setting Max Lights to 1.'
	einfo

	games_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
