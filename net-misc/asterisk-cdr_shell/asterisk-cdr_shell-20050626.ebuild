# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-cdr_shell/asterisk-cdr_shell-20050626.ebuild,v 1.2 2005/07/02 09:34:23 dholm Exp $

inherit eutils

MY_PN="cdr_shell"

DESCRIPTION="Asterisk plugin to use an external shell script for cdr handling"
HOMEPAGE="http://www.pbxfreeware.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"

DEPEND=">=net-misc/asterisk-1.0.7-r1"

S=${WORKDIR}/${MY_PN}

src_unpack() {
	unpack ${A}

	cd ${S}
	# use asterisk-config...
	epatch ${FILESDIR}/${MY_PN}-${PV}-astcfg.diff

	# patch for asterisk stable
	epatch ${FILESDIR}/${MY_PN}-${PV}-stable.diff
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die

	insinto /etc/asterisk
	doins   ${FILESDIR}/cdr.conf

	# fix permissions
	chown -R root:asterisk ${D}etc/asterisk
	chmod -R u=rwX,g=rX,o= ${D}etc/asterisk
}
