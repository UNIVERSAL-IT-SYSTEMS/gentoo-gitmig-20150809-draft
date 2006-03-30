# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/cdk-perl/cdk-perl-20031210.ebuild,v 1.3 2006/03/30 23:46:51 agriffis Exp $

inherit perl-module

IUSE=""

DESCRIPTION="Perl extension for Cdk."
SRC_URI="ftp://invisible-island.net/cdk/${P}.tgz"
HOMEPAGE="http://dickey.his.com/cdk/cdk.html"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~s390 ~sparc ~x86"

DEPEND="${DEPEND}
	>=dev-libs/cdk-4.9.10.20031210"

mydoc="CHANGES COPYING MANIFEST"

src_unpack()
{
	unpack ${P}.tgz
	cd ${S}
	sed -i -e "s:/usr/local:/usr:g" Makefile.PL
}

