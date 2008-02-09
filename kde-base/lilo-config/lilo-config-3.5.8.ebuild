# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/lilo-config/lilo-config-3.5.8.ebuild,v 1.6 2008/02/09 12:27:24 armin76 Exp $
KMNAME=kdeadmin
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE LiLo kcontrol module"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 x86"
IUSE="kdehiddenvisibility"
DEPEND=""

PATCHES="$FILESDIR/never-disable.diff"
