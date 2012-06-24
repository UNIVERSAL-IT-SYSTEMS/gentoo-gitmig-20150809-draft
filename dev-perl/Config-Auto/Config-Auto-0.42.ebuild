# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Config-Auto/Config-Auto-0.42.ebuild,v 1.2 2012/06/24 00:19:22 cardoe Exp $

EAPI=4

MODULE_AUTHOR="BINGOS"

inherit perl-module

DESCRIPTION="Magical config file parser"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Config-IniFiles
	dev-perl/IO-String
	dev-perl/Text-ParseWords
	virtual/perl-File-Spec
	dev-lang/perl"
DEPEND="${RDEPEND}"

SRC_TEST="do"
