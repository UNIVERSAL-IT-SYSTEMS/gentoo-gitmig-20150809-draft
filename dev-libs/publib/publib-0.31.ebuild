# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/publib/publib-0.31.ebuild,v 1.1 2002/02/27 02:56:13 chouser Exp $

S=${WORKDIR}/${P}
DESCRIPTION="C library of misc utility functions (parsing, data structs, etc.)"
SRC_URI="http://liw.iki.fi/liw/programs/debian/publib_${PV}.tar.gz"
HOMEPAGE="http://liw.iki.fi/liw/programs/"
DEPEND="virtual/glibc"

src_compile() {
	mkdir objs
	cd objs
	../framework/configure \
		--host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--with-modules=${S}/liw \
		--with-library=publib \
		--with-libshort=pub || die "./configure failed"
	emake || die "emake failed"
}

src_install () {
	# install extra docs
	dodoc Changes framework/README framework/COPYING framework/TODO
	dodoc framework/Blurb debian/changelog

	# main install
	cd objs
	mkdir -p ${D}/usr/share/man/mano
	mkdir -p ${D}/usr/lib
	mkdir -p ${D}/usr/include/publib
	make prefix=${D}/usr man3ext=o man3dir=${D}/usr/share/man/mano install \
		|| die "make install failed"

	# adjust man page titles to fit the "o" set above (instead of "3")
	for file in ${D}/usr/share/man/mano/*; do
		sed 's/^\(\.TH [A-Z0-9]* \)3/\1o/' $file > $file.new
		mv $file.new $file
	done
}
