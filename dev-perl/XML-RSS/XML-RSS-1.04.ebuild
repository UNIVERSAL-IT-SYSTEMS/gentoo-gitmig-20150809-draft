# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-RSS/XML-RSS-1.04.ebuild,v 1.11 2006/08/06 01:49:20 mcummings Exp $

inherit perl-module

IUSE=""
DESCRIPTION="a basic framework for creating and maintaining RSS files"
SRC_URI="mirror://cpan/authors/id/K/KE/KELLAN/${P}.tar.gz"
HOMEPAGE="http://perl-rss.sourceforge.net/"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha ~amd64 ppc ppc64 sparc x86"

DEPEND="dev-perl/Test-Manifest
	>=dev-perl/XML-Parser-2.30
	dev-lang/perl"
RDEPEND="${DEPEND}"

