# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xbindkeys/xbindkeys-1.7.0.ebuild,v 1.3 2004/04/11 17:30:59 pyrania Exp $

IUSE="guile tcltk"

DESCRIPTION="Tool for launching commands on keystrokes"
SRC_URI="http://hocwp.free.fr/xbindkeys/${P}.tar.gz"
HOMEPAGE="http://hocwp.free.fr/xbindkeys/"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
SLOT="0"

DEPEND=">=x11-base/xfree-4.1.0
	guile? ( dev-util/guile )
	tcltk? ( dev-lang/tk )"

src_compile() {
	local myconf
	use tcltk || myconf="${myconf} --disable-tk"
	use guile || myconf="${myconf} --disable-guile"
	econf ${myconf} || die
	emake DESTDIR=${D} || die

}

src_install() {
	emake DESTDIR=${D} \
		BINDIR=/usr/bin install || die "Installation failed"

}

