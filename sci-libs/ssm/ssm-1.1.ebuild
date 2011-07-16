# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/ssm/ssm-1.1.ebuild,v 1.1 2011/07/16 11:57:28 jlec Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="A macromolecular coordinate superposition library"
HOMEPAGE="https://launchpad.net/ssm"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

DEPEND=">=sci-libs/mmdb-1.23"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-mmdb.patch \
		"${FILESDIR}"/${P}-pc.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}
