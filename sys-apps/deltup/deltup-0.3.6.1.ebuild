# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License
# $Header: /var/cvsroot/gentoo-x86/sys-apps/deltup/deltup-0.3.6.1.ebuild,v 1.1 2003/06/17 07:14:30 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Patch system for Gentoo sources.  Retains MD5 codes"
HOMEPAGE="http://deltup.sourceforge.net"
SRC_URI="mirror://sourceforge/deltup/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm"

DEPEND=">=dev-util/xdelta-1.1.3
	>=sys-apps/bzip2-1.0.0"

src_install () {
	make DESTDIR=${D} install || die
	dodoc README ChangeLog
	doman deltup.1
}
