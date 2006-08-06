# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/extutils-parsexs/extutils-parsexs-2.08.ebuild,v 1.15 2006/08/06 02:19:52 mcummings Exp $

inherit perl-module

MY_P=ExtUtils-ParseXS-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Converts Perl XS code into C code"
HOMEPAGE="http://search.cpan.org/~kwilliams/${MY_P}/"
SRC_URI="mirror://cpan/authors/id/K/KW/KWILLIAMS/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa mips ppc sparc x86 ppc64"
IUSE=""

DEPEND="dev-perl/ExtUtils-CBuilder
	dev-perl/module-build
	dev-lang/perl"
RDEPEND="${DEPEND}"

SRC_TEST="do"


