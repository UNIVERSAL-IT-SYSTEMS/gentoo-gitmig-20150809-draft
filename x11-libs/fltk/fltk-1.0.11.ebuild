# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fltk/fltk-1.0.11.ebuild,v 1.4 2002/07/11 06:30:56 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="C++ user interface toolkit for X and OpenGL."
SRC_URI="ftp://ftp.fltk.org/pub/fltk/${PV}/${P}-source.tar.bz2"
HOMEPAGE="http://www.fltk.org"
DEPEND="virtual/glibc virtual/x11 opengl? ( virtual/opengl virtual/glu )"
RDEPEND="virtual/glibc virtual/x11 opengl? ( virtual/opengl virtual/glu )"
LICENSE="FLTK | GPL-2"
SLOT="0"
KEYWORDS="x86"

src_compile() {

    try ./configure --prefix=/usr/X11R6 --host=${CHOST} --enable-shared
    if [ -z "`use opengl`" ]
    then
      cp config.h config.orig
      sed -e "s:#define HAVE_GL.*:#define HAVE_GL 0:" \
	config.orig > config.h
    fi   
    try make

}

src_install () {

    try make prefix=${D}/usr/X11R6 install
    dodoc CHANGES COPYING README*
    mv ${D}/usr/X11R6/share/doc/fltk ${D}/usr/share/doc/${PF}/html

}

