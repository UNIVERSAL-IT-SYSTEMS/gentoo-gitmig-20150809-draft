# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sysadm-Install/Sysadm-Install-0.370.0.ebuild,v 1.1 2011/07/06 13:06:32 tove Exp $

EAPI=4

MODULE_AUTHOR=MSCHILLI
MODULE_VERSION=0.37
inherit perl-module

DESCRIPTION="Typical installation tasks for system administrators"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="hammer"

RDEPEND="dev-perl/TermReadKey
	dev-perl/libwww-perl
	>=dev-perl/Log-Log4perl-1.28
	hammer? ( dev-perl/Expect )"
DEPEND="${RDEPEND}"

SRC_TEST="do"
