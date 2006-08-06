# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Sablot/XML-Sablot-0.98.ebuild,v 1.15 2006/08/06 01:54:43 mcummings Exp $

inherit perl-module

MY_P=${PN}ron-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Perl Module for Sablotron"
SRC_URI="mirror://cpan/authors/id/P/PA/PAVELH/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~pavelh/${MY_P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha ~amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="app-text/sablotron
	dev-lang/perl"
RDEPEND="${DEPEND}"

myconf="SABLOTLIBPATH=/usr/lib SABLOTINCPATH=/usr/include"


