# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/aespipe/aespipe-2.2a.ebuild,v 1.9 2006/12/20 00:20:14 kugelfang Exp $

inherit flag-o-matic

DESCRIPTION="Encrypts data from stdin to stdout."
HOMEPAGE="http://loop-aes.sourceforge.net"
SRC_URI="http://loop-aes.sourceforge.net/aespipe/${PN}-v${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="static"
DEPEND=""
S="${WORKDIR}/${PN}-v${PV}"

src_compile() {
	use static && append-ldflags "-static -s"

	econf || die

	if [ "${ARCH}" == "x86" ]; then
		emake i586 || die
	else
		emake || die
	fi
}
src_install() {
	dobin aespipe
	dobin bz2aespipe
	dodoc README
	doman aespipe.1
}
