# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/DirectFB/DirectFB-0.9.11-r1.ebuild,v 1.2 2002/07/11 06:30:20 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="DirectFB is a thin library on top of the Linux framebuffer devices"
SRC_URI="http://www.directfb.org/download/DirectFB/${P}.tar.gz"
HOMEPAGE="http://www.directfb.org"

DEPEND="sys-devel/perl
	gif? ( media-libs/giflib )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	mpeg? ( media-libs/libmpeg3 )
	flash? ( >=media-libs/libflash-0.4.10 )
	truetype? ( >=media-libs/freetype-2.0.1 )
	quicktime? ( media-libs/quicktime4linux )"
#	avi? ( >=media-video/avifile-0.7.4.20020426-r2 )"


src_unpack() {
	unpack ${A}
	cd ${S}
	cp configure configure.orig
	sed -e 's:ac_safe=`echo "libmpeg3.h:ac_safe=`echo "libmpeg3/libmpeg3.h:' \
		-e 's:#include <libmpeg3.h>:#include <libmpeg3/libmpeg3.h>:' \
		configure.orig > configure
}

src_compile() {
	
	local myconf=""
	
	# Bug in the ./configure script that breaks if you
	# have --enable-mmx
	use mmx \
		&& myconf="${myconf} --enable-mmx" \
		|| myconf="${myconf} --disable-mmx"

# Still do not work currently
#	use avi	\
#		&& myconf="${myconf} --enable-avifile" \
#		|| myconf="${myconf} --disable-avifile"
	myconf="${myconf} --disable-avifile"
	
	use mpeg \
		&& myconf="${myconf} --enable-libmpeg3" \
		|| myconf="${myconf} --disable-libmpeg3"
	

	use jpeg \
		&& myconf="${myconf} --enable-jpeg" \
		|| myconf="${myconf} --disable-jpeg"

	use png \
		&& myconf="${myconf} --enable-png" \
		|| myconf="${myconf} --disable-png"

	use gif \
		&& myconf="${myconf} --enable-gif" \
		|| myconf="${myconf} --disable-gif"

	use truetype \
		&& myconf="${myconf} --enable-freetype" \
		|| myconf="${myconf} --disable-freetype"
	
	econf ${myconf} || die

	use mpeg && ( \
		cd ${S}/interfaces/IDirectFBVideoProvider
		cp idirectfbvideoprovider_libmpeg3.c \
			idirectfbvideoprovider_libmpeg3.c.orig
	
		sed s':#include <libmpeg3.h>:#include <libmpeg3/libmpeg3.h>:' \
			idirectfbvideoprovider_libmpeg3.c.orig > \
				idirectfbvideoprovider_libmpeg3.c
		cd ${S}
	)
	make || die

}

src_install () {
	
	insinto /etc
	doins fb.modes

	make 	\
		DESTDIR=${D}	\
		install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README* TODO
	dohtml -r docs/html
}

