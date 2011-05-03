# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/fig2sxd/fig2sxd-0.21.ebuild,v 1.1 2011/05/03 15:12:59 bicatali Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="A utility to convert files in xfig format to OpenOffice.org Draw format"
LICENSE="GPL-2"
PVD=2

HOMEPAGE="http://sourceforge.net/projects/fig2sxd"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.orig.tar.gz
	 mirror://sourceforge/${PN}/${PN}_${PV}-${PVD}.diff.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-linux ~ppc-macos"
IUSE=""

DEPEND=""
RDEPENd=""

src_prepare() {
	epatch "${WORKDIR}"/${PN}_${PV}-${PVD}.diff
	epatch "${FILESDIR}"/${PN}-0.20-ldflags.patch
	epatch "${FILESDIR}"/${PN}-0.20-phony-check.patch
}

src_compile() {
	emake CXXFLAGS="${CXXFLAGS}" CXX="$(tc-getCXX)"
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc changelog
}
