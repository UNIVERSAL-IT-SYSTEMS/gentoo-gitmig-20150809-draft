# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Joe Bormolini
# $Header: /var/cvsroot/gentoo-x86/media-sound/grip-id3v2/grip-id3v2-2.96-r1.ebuild,v 1.1 2002/03/27 14:17:06 seemant Exp $

P=grip-${PV}
S=${WORKDIR}/${P}
DESCRIPTION="GTK+ based Audio CD Ripper"
SRC_URI="http://www.nostatic.org/grip/${P}.tgz http://www.slackorama.net/oss/qtagger/grip-2.95-id3v2.tar.gz"
HOMEPAGE="http://www.nostatic.org/grip"

DEPEND="media-libs/id3lib
	media-sound/cdparanoia
	virtual/x11"

src_unpack() {

	unpack ${A}
	cd grip-2.95
	cp -a id3.c README.id3v2 ${S}
	cd ${S}
	
	#required to build without needing the cdparanoia source tarball
	mkdir cdparanoia
	mkdir cdparanoia/interface
	mkdir cdparanoia/paranoia
        ln -s /usr/lib/libcdda* cdparanoia/interface/
	ln -s /usr/lib/libcdda* cdparanoia/paranoia/
	ln -s /usr/include/*cdda* cdparanoia/interface/
	ln -s /usr/include/*cdda* cdparanoia/paranoia/
	ln -s /usr/include/utils.h cdparanoia/utils.h
}

src_compile() {

	# apply CFLAGS
	mv Makefile Makefile.old
	sed -e "s:^LIBS+=:LIBS+= -lid3 -lz:" -e "s:-Wall:-Wall ${CFLAGS}:" Makefile.old > Makefile
	emake || die

}

src_install () {
	cd ${S}

	exeinto /usr/bin
	doexe grip gcd 
	doman grip.1

	dodoc README LICENSE TODO CREDITS CHANGES README.id3v2

}
