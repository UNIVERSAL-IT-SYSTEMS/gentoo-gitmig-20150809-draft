# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/lesstif/lesstif-0.94.0-r5.ebuild,v 1.3 2005/03/10 14:26:52 lanius Exp $

inherit libtool flag-o-matic multilib

DESCRIPTION="An OSF/Motif(R) clone"
HOMEPAGE="http://www.lesstif.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="2.1"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~ppc-macos ~sparc ~x86 ~ia64"
IUSE="static"

DEPEND="virtual/libc
	virtual/x11
	>=x11-libs/motif-config-0.4"

PROVIDE="virtual/motif"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/CAN-2005-0605.patch
}

src_compile() {
	use ppc-macos || elibtoolize

	if use ppc-macos; then
		append-ldflags -L/usr/X11R6/lib -lX11 -lXt
	fi

	econf \
	  $(use_enable static) \
	  --enable-production \
	  --enable-verbose=no \
	  --with-x || die "./configure failed"

	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} install || die "make install"


	einfo "Fixing binaries"
	dodir /usr/$(get_libdir)/lesstif-2.1
	for file in `ls ${D}/usr/bin`
	do
		mv ${D}/usr/bin/${file} ${D}/usr/$(get_libdir)/lesstif-2.1/${file}
	done

	einfo "Fixing libraries"
	mv ${D}/usr/lib/* ${D}/usr/$(get_libdir)/lesstif-2.1/

	einfo "Fixing includes"
	dodir /usr/include/lesstif-2.1/
	mv ${D}/usr/include/* ${D}/usr/include/lesstif-2.1

	einfo "Fixing man pages"
	mans="1 3 5"
	for man in $mans; do
		dodir /usr/share/man/man${man}
		for file in `ls ${D}/usr/share/man/man${man}`
		do
			file=${file/.${man}/}
			mv ${D}/usr/share/man/man$man/${file}.${man} ${D}/usr/share/man/man${man}/${file}-lesstif-2.1.${man}
		done
	done


	einfo "Fixing docs"
	dodir /usr/share/doc/
	mv ${D}/usr/LessTif ${D}/usr/share/doc/${P}
	rm -fR ${D}/usr/$(get_libdir)/LessTif

	# cleanup
	rm -f ${D}/usr/$(get_libdir)/lesstif-2.1/mxmkmf
	rm -fR ${D}/usr/share/aclocal/
	rm -fR ${D}/usr/$(get_libdir)/lesstif-2.1/LessTif/
	rm -fR ${D}/usr/$(get_libdir)/lesstif-2.1/X11/
	rm -fR ${D}/usr/$(get_libdir)/X11/

}

# Profile stuff
pkg_postinst() {
	motif-config --install lesstif-2.1
}

is_upgrade() {
	vdb_path=`portageq vdb_path`
	if [ "`grep -r SLOT $vdb_path/${CATEGORY}/${PN}* | grep $SLOT`" ]; then
		return 0
	else
		return 1
	fi
}

pkg_postrm() {
	is_upgrade || motif-config --uninstall lesstif-2.1
}
