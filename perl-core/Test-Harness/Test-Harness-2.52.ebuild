# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Test-Harness/Test-Harness-2.52.ebuild,v 1.3 2006/10/20 20:41:42 mcummings Exp $

inherit perl-module

DESCRIPTION="Runs perl standard test scripts with statistics"
HOMEPAGE="http://search.cpan.org/search?dist=Test-Harness"
SRC_URI="mirror://cpan/authors/id/P/PE/PETDANCE/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"
mydoc="rfc*.txt"
