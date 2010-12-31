# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MIME-EncWords/MIME-EncWords-1.012.ebuild,v 1.2 2010/12/31 14:59:35 fauli Exp $

EAPI=3

MODULE_AUTHOR=NEZUMI
inherit perl-module

DESCRIPTION="Deal with RFC 2047 encoded words (improved)"

SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="virtual/perl-MIME-Base64
	virtual/perl-Encode
	dev-perl/MIME-Charset"
RDEPEND="${DEPEND}"

SRC_TEST="do"
