# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/tetex/tetex-1.0.7-r7.ebuild,v 1.2 2002/02/01 18:56:53 gbevin Exp $

TEXMFSRC="teTeX-texmf-gg-1.0.3.tar.bz2"

S=${WORKDIR}/teTeX-1.0
DESCRIPTION="teTeX is a complete TeX distribution"
SRC_URI="ftp://sunsite.informatik.rwth-aachen.de/pub/comp/tex/teTeX/1.0/distrib/sources/teTeX-src-1.0.7.tar.gz
	 ftp://ftp.dante.de/pub/tex/systems/unix/teTeX/1.0/contrib/ghibo/${TEXMFSRC}
	 http://www.ibiblio.org/gentoo/distfiles/ec-ready-mf-tfm.tar.gz
	 http://www.ibiblio.org/gentoo/distfiles/teTeX-french.tar.gz"
HOMEPAGE="http://tug.cs.umb.edu/tetex/"

DEPEND="virtual/glibc
	sys-apps/ed
	>=media-libs/libpng-1.0.9
	libwww? ( >=net-libs/libwww-5.3.2-r1 )
	X? ( virtual/x11 )"

RDEPEND="virtual/glibc
	>=sys-devel/perl-5.2
	>=media-libs/libpng-1.0.9
	dev-util/dialog
	X? ( virtual/x11 )"


src_unpack() {

	unpack teTeX-src-1.0.7.tar.gz
	
	mkdir ${S}/texmf
	cd ${S}/texmf
	echo ">>> Unpacking ${TEXMFSRC}"
	tar xjf ${DISTDIR}/${TEXMFSRC}
	echo ">>> Unpacking ec-ready-mf-tfm.tar.gz"
	tar xzf ${DISTDIR}/ec-ready-mf-tfm.tar.gz -C ..
	echo ">>> Unpacking teTeX-french.tar.gz"
	tar xzf ${DISTDIR}/teTeX-french.tar.gz

	cd ${WORKDIR}
	patch -p0 < ${FILESDIR}/teTeX-1.0-gentoo.diff || die

	cd ${S}
	patch -p0 < ${FILESDIR}/teTeX-1.0.dif || die

	# Fix problem where the *.fmt files are not generated due to the LaTeX
	# source being older than a year.
#        local x
#        for x in `find ${S}/texmf/ -type f -name '*.ini'`
#        do
#                cp ${x} ${x}.orig
#                sed -e '1i \\scrollmode' ${x}.orig > ${x}
#                rm -f ${x}.orig
#        done

}

src_compile() {

	local myconf
	if [ "`use X`" ]
	then
		myconf="--with-x"
	else
		myconf="--without-x"
	fi

	if [ "`use libwww`" ]
	then
		myconf="${myconf} --with-system-wwwlib"
	fi
	# Does it make sense to compile the included libwww with mysql ?

	./configure --host=${CHOST} \
		--prefix=/usr \
		--bindir=/usr/bin \
		--datadir=/usr/share \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--datadir=${S} \
		--without-texinfo \
		--without-dialog \
		--with-system-ncurses \
		--with-system-zlib \
		--with-system-pnglib \
		--disable-multiplatform \
		--with-epsfwin \
		--with-mftalkwin \
		--with-regiswin \
		--with-tektronixwin \
		--with-unitermwin \
		--with-ps=gs \
		--enable-ipc \
		--with-etex \
		${myconf} || die

	make texmf=/usr/share/texmf || die
}

src_install() {

	cd ${S}
	dodir /usr/share/
	cp -af texmf ${D}/usr/share
	sed -e 's:    \$(scriptdir)/mktexlsr:    echo:' \
		-e 's:\$(scriptdir)/texconfig init:echo:' \
		Makefile > Makefile.install
	make prefix=${D}/usr \
		bindir=${D}/usr/bin \
		datadir=${D}/usr/share \
		mandir=${D}/usr/share/man/man1 \
		infodir=${D}/usr/share/info \
		texmf=${D}/usr/share/texmf \
		-f Makefile.install \
		install || die

	dodoc PROBLEMS README
	docinto texk
	dodoc texk/ChangeLog texk/README
	docinto kpathesa
	cd ${S}/texk/kpathsea
	dodoc README* NEWS PROJECTS HIER
	docinto dviljk
	cd ${S}/texk/dviljk
	dodoc AUTHORS README NEWS
	docinto dvipsk
	cd ${S}/texk/dvipsk
	dodoc AUTHORS ChangeLog INSTALLATION README
	docinto makeindexk
	cd ${S}/texk/makeindexk
	dodoc CONTRIB COPYING NEWS NOTES PORTING README
	docinto ps2pkm
	cd ${S}/texk/ps2pkm
	dodoc ChangeLog CHANGES.type1 INSTALLATION README* 
	docinto web2c
	cd ${S}/texk/web2c
	dodoc AUTHORS ChangeLog NEWS PROJECTS README
	docinto xdvik
	cd ${S}/texk/xdvik
	dodoc BUGS FAQ README* 

	#fix for conflicting readlink binary:
	rm ${D}/bin/readlink
	#add /var/cache/fonts directory
	dodir /var/cache/fonts
}

pkg_postinst() {

	if [ $ROOT = "/" ]
	then
		echo ">>> Configuring teTeX..."
		mktexlsr >/dev/null 2>&1 
		texlinks >/dev/null 2>&1
		texconfig init >/dev/null 2>&1
		texconfig confall >/dev/null 2>&1
		texconfig font vardir /var/cache/fonts >/dev/null 2>&1
		echo "*** use 'texconfig font rw' to allow all users to generate fonts ***"
	fi
}

