# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="A sed/awk/grep apps "
SRC_URI="http://download.sourceforge.net/kfilereplace/${A}"
HOMEPAGE="http://kfilereplace.sourceforge.net"

DEPEND=">=kde-base/kdebase-2.1.1 sys-devel/perl"
RDEPEND=">=kde-base/kdebase-2.1.1"


src_compile() {
    local myconf
    if [ "`use qtmt`" ]
    then
      myconf="--enable-mt"
    fi
    if [ "`use mitshm`" ]
    then
      myconf="$myconf --enable-mitshm"
    fi
    try ./configure --prefix=${KDEDIR} --host=${CHOST} $myconf
    try make

}

src_install () {

    try make DESTDIR=${D} kde_locale=${D}${KDEDIR}/share/locale install
    dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}

