# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/gedit/gedit-0.9.6-r1.ebuild,v 1.3 2002/08/02 05:05:01 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gnome Text Editor"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://gedit.sourceforge.net/"
SLOT="O"
LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND="( >=gnome-base/libglade-0.17-r1
	 <gnome-base/libglade-2.0.0 )
	 >=gnome-base/gnome-print-0.30
	 >=gnome-base/gnome-vfs-1.0.2-r1"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"


src_compile() {
	local myconf

	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	CFLAGS="${CFLAGS} `gnome-config --cflags libglade vfs`"

	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    ${myconf} || die
	
	emake || die
}

src_install() {
		make prefix=${D}/usr install || die

	dodoc AUTHORS BUGS COPYING ChangeLog FAQ NEWS README* THANKS TODO
}
