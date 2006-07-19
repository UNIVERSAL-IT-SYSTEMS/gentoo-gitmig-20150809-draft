# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/encodings/encodings-1.0.0.ebuild,v 1.13 2006/07/19 14:05:32 gmsoft Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org font encodings"
RESTRICT="mirror"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 ~s390 sh sparc x86 ~x86-fbsd"
RDEPEND=""
DEPEND="${RDEPEND}
	x11-apps/mkfontscale"

CONFIGURE_OPTIONS="--with-encodingsdir=/usr/share/fonts/encodings"
