# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/viewres/viewres-1.0.3.ebuild,v 1.6 2010/12/31 20:51:34 jer Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="graphical class browser for Xt"

KEYWORDS="amd64 arm hppa ~mips ~ppc ppc64 ~s390 ~sh ~sparc x86"
IUSE=""

RDEPEND="x11-libs/libXaw
	x11-libs/libXt
	x11-libs/libXmu"
DEPEND="${RDEPEND}"
