# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/tempest_for_eliza/tempest_for_eliza-1.0.5.ebuild,v 1.9 2009/05/11 08:31:35 ssuominen Exp $

EAPI=2
inherit toolchain-funcs

DESCRIPTION="listen to music on the radio generated by images on your screen"
HOMEPAGE="http://www.erikyyy.de/tempest/"
SRC_URI="http://www.erikyyy.de/tempest/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

RDEPEND="media-libs/libsdl"
DEPEND="${RDEPEND}"

src_configure() {
	tc-export CXX
	econf \
		--enable-debug \
		--enable-nowarnerror
}

src_compile() {
	emake CXXFLAGS="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	emake install DESTDIR=${D} || die "emake install failed"
	dodoc AUTHORS ChangeLog README

	rm songs/Makefile*
	insinto /usr/share/${PN}
	doins songs/* || die "doins failed"
}
