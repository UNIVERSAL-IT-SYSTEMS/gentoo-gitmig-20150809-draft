# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vmpsd/vmpsd-1.4.ebuild,v 1.1 2012/02/21 09:18:00 robbat2 Exp $

EAPI=4
inherit eutils flag-o-matic autotools

DESCRIPTION="An open-source VLAN management system"
HOMEPAGE="http://vmps.sourceforge.net"
SRC_URI="mirror://sourceforge/vmps/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="net-analyzer/net-snmp
	dev-libs/openssl"
S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.4-snmp-support.patch
	epatch "${FILESDIR}"/${PN}-1.3-64bit.patch
	# Merged upstream
	#EPATCH_OPTS="-d${S}" \
	#epatch "${FILESDIR}"/${PN}-1.3-format-sec.patch
	eautoreconf
}

src_configure() {
	econf \
		--sysconfdir=/etc/vmpsd \
		--enable-snmp \
		LIBS="-lssl" \
		|| die "econf failed"
}

src_install() {
	emake DESTDIR="${ED}" install || die
	dodoc README INSTALL AUTHORS doc/*txt
	newdoc external/README README.external
	newdoc tools/README README.tools
	dodoc external/simple tools/vqpcli.pl
}
