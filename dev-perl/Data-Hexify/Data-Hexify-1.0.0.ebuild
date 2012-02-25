# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Hexify/Data-Hexify-1.0.0.ebuild,v 1.2 2012/02/25 16:39:54 ago Exp $

EAPI=3

MODULE_AUTHOR="JV"
MODULE_VERSION="1.00"

inherit perl-module

DESCRIPTION="Perl extension for hexdumping arbitrary data"

SLOT="0"
KEYWORDS="amd64 ~x86 ~amd64-linux"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

SRC_TEST="do"
