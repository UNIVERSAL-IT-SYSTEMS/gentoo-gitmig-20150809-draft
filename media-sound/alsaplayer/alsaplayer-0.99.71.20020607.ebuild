# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Seemant Kulleen <seemant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsaplayer/alsaplayer-0.99.71.20020607.ebuild,v 1.1 2002/06/08 02:11:36 seemant Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Media player primarily utilising ALSA"
SRC_URI="http://www.alsaplayer.org/${P}.tar.bz2"
HOMEPAGE="http://www.alsaplayer.org/"
QTROOT="/usr/qt/3"

DEPEND="alsa? ( >=media-libs/alsa-lib-0.5.10 )
	qt? ( >=x11-libs/qt-3.0.1 )
	doc? ( app-doc/doxygen )
	esd? ( media-sound/esound )
	gtk? ( x11-libs/gtk+ )
	nas? ( media-libs/nas )
	opengl? ( virtual/opengl )
	oggvorbis? ( media-libs/libvorbis )
	>=media-libs/libmikmod-3.1.10
	>=dev-libs/glib-1.2.10"
	
RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {

	local myconf

	use oggvorbis \
		&& myconf="--enable-oggvorbis" \
		|| myconf="--disable-oggvorbis --disable-oggtest --disable-vorbistest"

	use oss \
		&& myconf="${myconf} --enable-oss" \
		|| myconf="${myconf} --disable-oss"

	use esd \
		&& myconf="${myconf} --enable-esd" \
		|| myconf="${myconf} --disable-esd --disable-esdtest"

	use nas \
		&& myconf="${myconf} --enable-nas" \
		|| myconf="${myconf} --disable-nas"

	use opengl \
		&& myconf="${myconf} --enable-opengl" \
		|| myconf="${myconf} --disable-opengl"

	use gtk \
		&& myconf="${myconf} --enable-gtk" \
		|| myconf="${myconf} --disable-gtk --disable-gtktest --disable-glibtest"

	use qt \
		&& myconf="${myconf} --enable-qt \
				--with-qt-libdir=${QTROOT}/lib \
				--with-qt-indir=${QTROOT}/include \
				--with-qt-bindir=${QTROOT}/bin"

	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"
	
	export CPPFLAGS="${CPPFLAGS} -I/usr/X11R6/include"

	./bootstrap
	
	econf \
		--disable-sgi \
		--disable-sparc \
		${myconf} || die

	emake || die
}

src_install() {
	
	einstall \
		docdir=${D}/usr/share/doc/${P} \
		|| die

	dodoc AUTHORS COPYING ChangeLog README TODO
	dodoc docs/sockmon.txt docs/wishlist.txt
}
