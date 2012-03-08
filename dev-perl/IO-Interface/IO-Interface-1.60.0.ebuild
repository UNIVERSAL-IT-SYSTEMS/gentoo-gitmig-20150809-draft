# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Interface/IO-Interface-1.60.0.ebuild,v 1.4 2012/03/08 15:30:28 phajdan.jr Exp $

EAPI=4

MODULE_AUTHOR=LDS
MODULE_VERSION=1.06
inherit perl-module

DESCRIPTION="Perl extension for access to network card configuration information"

SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ppc ~ppc64 ~sparc x86"
IUSE=""

SRC_TEST="do"
