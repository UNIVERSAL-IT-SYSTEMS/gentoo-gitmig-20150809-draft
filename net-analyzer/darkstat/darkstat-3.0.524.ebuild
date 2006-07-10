# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/darkstat/darkstat-3.0.524.ebuild,v 1.4 2006/07/10 15:58:46 grobian Exp $

inherit eutils

DESCRIPTION="darkstat is a network traffic analyzer"
HOMEPAGE="http://dmr.ath.cx/net/darkstat/"
SRC_URI="http://dmr.ath.cx/net/darkstat/${P}.tar.bz2"

KEYWORDS="~ppc ~ppc-macos ~x86"
IUSE="nls"
LICENSE="GPL-2"
SLOT="0"

DEPEND="net-libs/libpcap
	nls? ( sys-devel/gettext )"
RDEPEND="nls? ( virtual/libintl )"

src_compile() {
	use nls && myconf="`use_with nls`"
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	dodir /var/spool/darkstat

	dodoc AUTHORS README THANKS

	newinitd "${FILESDIR}"/darkstat-init2 darkstat
	newconfd "${FILESDIR}"/darkstat-confd2 darkstat
}

