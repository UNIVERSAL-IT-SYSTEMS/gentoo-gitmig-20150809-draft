# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Math-BigRat/Math-BigRat-0.25.ebuild,v 1.1 2010/09/15 09:09:33 tove Exp $

EAPI=2

MODULE_AUTHOR=FLORA
inherit perl-module

DESCRIPTION="Arbitrary big rational numbers"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=">=perl-core/Math-BigInt-1.88"
RDEPEND="${DEPEND}"

SRC_TEST="do"
