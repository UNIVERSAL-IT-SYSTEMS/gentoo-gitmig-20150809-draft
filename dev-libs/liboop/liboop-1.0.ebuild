# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/liboop/liboop-1.0.ebuild,v 1.8 2005/04/24 12:44:27 hansmi Exp $

inherit flag-o-matic

DESCRIPTION="low-level event loop management library for POSIX-based operating systems"
HOMEPAGE="http://www.liboop.org/"
SRC_URI="http://download.ofb.net/liboop/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~sparc amd64 ppc"
IUSE="adns gnome tcltk readline libwww"

DEPEND="adns? ( net-libs/adns )
	gnome? ( dev-libs/glib )
	tcltk? ( dev-lang/tcl )
	readline? ( sys-libs/readline )
	libwww? ( net-libs/libwww )"

src_compile() {
	econf \
		`use_with adns` \
		`use_with gnome` \
		`use_with tcltk` \
		`use_with readline` \
		`use_with libwww` \
		|| die
	emake -j1 || die
}

src_install() {
	emake install DESTDIR=${D} || die
}
