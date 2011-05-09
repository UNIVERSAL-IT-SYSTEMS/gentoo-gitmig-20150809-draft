# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcron/kcron-4.6.2.ebuild,v 1.3 2011/05/09 22:36:21 hwoarang Exp $

EAPI=3

KDE_HANDBOOK="optional"
KMNAME="kdeadmin"
inherit kde4-meta

DESCRIPTION="KDE Task Scheduler"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="!prefix? ( virtual/cron )"
