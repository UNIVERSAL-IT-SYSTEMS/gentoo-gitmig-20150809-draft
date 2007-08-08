# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kuiviewer/kuiviewer-3.5.7.ebuild,v 1.3 2007/08/08 10:56:29 josejx Exp $

KMNAME=kdesdk
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KUIViewer - Displays Designer's UI files"
KEYWORDS="~alpha ~amd64 ~ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"
