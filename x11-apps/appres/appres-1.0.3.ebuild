# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/appres/appres-1.0.3.ebuild,v 1.8 2011/02/12 17:32:58 armin76 Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="list X application resource database"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ~ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x64-solaris ~x86-solaris ~x86-winnt"
IUSE=""
RDEPEND="x11-libs/libX11
	x11-libs/libXt"
DEPEND="${RDEPEND}"
