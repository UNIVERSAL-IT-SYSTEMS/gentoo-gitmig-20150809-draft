# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice-libs/koffice-libs-2.3.3.ebuild,v 1.3 2011/05/09 08:32:50 tomka Exp $

EAPI=3

KMNAME="koffice"
KMMODULE="libs"
OPENGL_REQUIRED="optional"
CPPUNIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="Shared KOffice libraries."
KEYWORDS="~amd64 x86"
IUSE="crypt openexr reports"

RDEPEND="
	>=app-office/koffice-data-${PV}:${SLOT}
	dev-libs/libxml2
	dev-libs/libxslt
	dev-libs/soprano
	>=kde-base/kdepimlibs-${KDE_MINIMAL}
	media-libs/lcms:0
	crypt? ( app-crypt/qca:2 )
	openexr? ( media-libs/openexr )
	opengl? ( media-libs/mesa )
	!app-office/kchart
"
DEPEND="${RDEPEND}"
#	doc? ( app-doc/doxygen )"

KMEXTRA="
	doc/koffice/
	doc/thesaurus/
	filters/generic_wrapper/
	filters/libkowmf/
	filters/libmsooxml/
	filters/xsltfilter/
	filters/kchart/
	filters/kformula/
	interfaces/
	kchart/
	kformula/
	kounavail/
	plugins/
	tools/
"

KMEXTRACTONLY="
	KoConfig.h.cmake
	doc/koffice.desktop
	filters/
"

KMSAVELIBS="true"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with crypt QCA2)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with openexr OpenEXR)
		-DWITH_Spnav=OFF
		-DBUILD_kchart=ON
		-DBUILD_kformula=ON
		$(cmake-utils_use_build reports koreport)
	)
	use crypt && \
		mycmakeargs+=(-DQCA2_LIBRARIES=/usr/$(get_libdir)/qca2/libqca.so.2)

	kde4-meta_src_configure
}

src_install() {
	newdoc kounavail/README README.kounavail || die

	kde4-meta_src_install

	# this is already installed by koffice-data
	rm -f "${D}/usr/include/config-opengl.h"
	rm -f "${D}/usr/include/KoConfig.h"
}
