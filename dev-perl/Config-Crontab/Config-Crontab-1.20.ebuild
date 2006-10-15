# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Config-Crontab/Config-Crontab-1.20.ebuild,v 1.5 2006/10/15 09:56:12 kloeri Exp $

inherit perl-module

DESCRIPTION="Read/Write Vixie compatible crontab(5) files"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/S/SC/SCOTTW/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 ~x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-lang/perl"
