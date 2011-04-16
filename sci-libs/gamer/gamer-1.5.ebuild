# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/gamer/gamer-1.5.ebuild,v 1.1 2011/04/16 07:35:35 jlec Exp $

EAPI="3"

inherit autotools eutils multilib

DESCRIPTION="Geometry-preserving Adaptive MeshER"
HOMEPAGE="http://fetk.org/codes/gamer/index.html"
SRC_URI="http://www.fetk.org/codes/download/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="GPL-2"
IUSE="doc"

RDEPEND=">=dev-libs/maloc-1.4"
DEPEND="
	${RDEPEND}
	doc? (
		media-gfx/graphviz
		app-doc/doxygen )"

S="${WORKDIR}"/${PN}

src_prepare() {
	epatch \
		"${FILESDIR}"/1.4-multilib.patch \
		"${FILESDIR}"/1.4-doc.patch
	eautoreconf
}

src_configure() {
	local fetk_include
	local fetk_lib
	local myconf

	use doc || myconf="${myconf} --with-doxygen= --with-dot="

	fetk_include="${EPREFIX}"/usr/include
	fetk_lib="${EPREFIX}"/usr/$(get_libdir)
	export FETK_INCLUDE="${fetk_include}"
	export FETK_LIBRARY="${fetk_lib}"

	econf \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		--disable-triplet \
		--enable-shared \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die
}
