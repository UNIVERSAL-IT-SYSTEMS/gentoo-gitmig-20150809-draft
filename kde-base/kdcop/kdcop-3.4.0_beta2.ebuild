# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdcop/kdcop-3.4.0_beta2.ebuild,v 1.3 2005/03/02 01:03:16 cryos Exp $

KMNAME=kdebase
MAXKDEVER=3.4.0_rc1
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: graphical DCOP browser/client"
KEYWORDS="~x86 ~amd64"
IUSE=""
KMNODOCS="true"

