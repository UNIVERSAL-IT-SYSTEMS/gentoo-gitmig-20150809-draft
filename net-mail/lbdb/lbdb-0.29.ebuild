# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/lbdb/lbdb-0.29.ebuild,v 1.4 2005/04/20 21:33:48 hansmi Exp $

IUSE="pda ldap"

MY_P=${P/-/_}
DESCRIPTION="Little Brother database"
SRC_URI="http://www.spinnaker.de/debian/${MY_P}.tar.gz"
HOMEPAGE="http://www.spinnaker.de/lbdb/"
DEPEND=">=mail-client/mutt-1.2.5"
SLOT="0"
KEYWORDS="x86 ppc sparc"
LICENSE="GPL-2"
DEPEND="dev-lang/perl"
RDEPEND="pda? ( dev-perl/p5-Palm )
	ldap? ( dev-perl/perl-ldap )"

src_compile() {
	econf --libdir=/usr/lib/lbdb || die
	emake || die
}

src_install () {
	make install_prefix=${D} install || die
	dodoc README INSTALL COPYING NEWS TODO
}
