# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-LongString/Test-LongString-0.09.ebuild,v 1.4 2006/06/12 16:47:45 mcummings Exp $

inherit perl-module

DESCRIPTION="A library to test long strings."
HOMEPAGE="http://search.cpan.org/~rgarcia/${PN}/"
SRC_URI="mirror://cpan/authors/id/R/RG/RGARCIA/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc sparc ~x86"
IUSE=""
SRC_TEST="do"
