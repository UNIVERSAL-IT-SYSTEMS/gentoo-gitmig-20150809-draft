# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/libdbx/libdbx-1.0.3.ebuild,v 1.1 2004/03/05 07:19:37 phosphan Exp $

DESCRIPTION="Tools and library for reading Outlook Express mailboxes (.dbx format)"
HOMEPAGE="http://sourceforge.net/projects/ol2mbox"
MY_PN="libdbx"
MYFILE="${MY_PN}_${PV}.tgz"
SRC_URI="mirror://sourceforge/ol2mbox/${MYFILE}"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND=">=sys-apps/sed-4"

S="${WORKDIR}/${MY_PN}_${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's/-g/$(CFLAGS)/' Makefile
}

src_compile() {
	emake || die
}

src_install() {
	exeinto /usr/bin
	doexe readoe readdbx
	dodoc README* AUTHORS FILE-FORMAT
	insinto /usr/include
	doins libdbx.h libdbx++.h
	insinto /usr/lib
	doins libdbx.o
}
