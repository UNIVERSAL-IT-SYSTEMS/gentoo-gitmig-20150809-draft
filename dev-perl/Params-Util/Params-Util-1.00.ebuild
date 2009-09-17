# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Params-Util/Params-Util-1.00.ebuild,v 1.3 2009/09/17 16:23:11 jer Exp $

EAPI=2

MODULE_AUTHOR=ADAMK
inherit perl-module

DESCRIPTION="Utility functions to aid in parameter checking"

SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ia64 ~mips ~ppc ~sparc x86"
IUSE=""

DEPEND=">=virtual/perl-Scalar-List-Utils-1.18"
RDEPEND="${DEPEND}"

SRC_TEST="do"
