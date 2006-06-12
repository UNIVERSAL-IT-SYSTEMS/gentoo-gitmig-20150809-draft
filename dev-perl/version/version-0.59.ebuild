# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/version/version-0.59.ebuild,v 1.2 2006/06/12 16:56:38 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl extension for Version Objects"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/J/JP/JPEACOCK/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 sparc ~x86"
IUSE=""
SRC_TEST="do"

DEPEND=">=dev-perl/module-build-0.26.11"
RDEPEND=""

