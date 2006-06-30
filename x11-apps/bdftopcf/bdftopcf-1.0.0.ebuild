# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/bdftopcf/bdftopcf-1.0.0.ebuild,v 1.9 2006/06/30 05:12:46 spyderous Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org bdftopcf application"
RESTRICT="mirror"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"

RDEPEND="x11-libs/libXfont"
DEPEND="${RDEPEND}"
