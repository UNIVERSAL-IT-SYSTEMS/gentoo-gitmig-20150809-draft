# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmclockmon/wmclockmon-0.7.2.ebuild,v 1.5 2004/06/24 12:51:17 s4t4n Exp $

IUSE=""

DESCRIPTION="digital clock dockapp with seven different styles with a LCD or LED display. Also has a Internet Time feature."
SRC_URI="http://tnemeth.free.fr/projets/programmes/${P}.tar.gz"
HOMEPAGE="http://tnemeth.free.fr/projets/dockapps.html"

SLOT="0"
KEYWORDS="x86 ~sparc amd64 ppc"
LICENSE="GPL-2"

DEPEND="virtual/x11
	=x11-libs/gtk+-1.2*"

src_install () {
	einstall || die "make install failed"

	dodoc AUTHORS BUGS ChangeLog THANKS TODO doc/sample.wmclockmonrc
}
