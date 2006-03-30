# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Format/HTML-Format-2.04.ebuild,v 1.8 2006/03/30 22:46:41 agriffis Exp $

# this is an RT dependency
inherit perl-module

DESCRIPTION="HTML Formatter"
SRC_URI="mirror://cpan/authors/id/S/SB/SBURKE/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/S/SB/SBURKE/${P}.readme"

SRC_TEST="do"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~ia64 ~ppc sparc x86"

DEPEND="dev-perl/Font-AFM
	dev-perl/HTML-Tree"
IUSE=""
