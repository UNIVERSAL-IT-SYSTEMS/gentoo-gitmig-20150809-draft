# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xset/xset-1.0.2.ebuild,v 1.11 2007/05/02 08:26:34 dberkholz Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xset application"

KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86 ~x86-fbsd"

RDEPEND="x11-libs/libXmu
	x11-libs/libXfontcache"
DEPEND="${RDEPEND}"
