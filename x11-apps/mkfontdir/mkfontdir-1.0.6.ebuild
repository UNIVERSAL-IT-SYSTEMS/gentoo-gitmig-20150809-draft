# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/mkfontdir/mkfontdir-1.0.6.ebuild,v 1.6 2010/12/31 20:53:55 jer Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="create an index of X font files in a directory"

KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ~ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="x11-apps/mkfontscale"
DEPEND="${RDEPEND}"
