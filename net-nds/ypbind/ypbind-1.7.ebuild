# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-nds/ypbind/ypbind-1.7.ebuild,v 1.2 2000/12/19 00:46:33 achim Exp $

A=ypbind-mt-${PV}.tar.gz
S=${WORKDIR}/ypbind-mt-${PV}
DESCRIPTION="Multithreaded NIS bind service"
SRC_URI="ftp://ftp.de.kernel.org/pub/linux/utils/net/NIS/"${A}
HOMEPAGE="http://www.suse.de/~kukuk/nis/ypbind-mt/index.html"

DEPEND=">=sys-libs/glibc-2.1.3"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr --sysconfdir=/etc/yp
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr sysconfdir=${D}/etc/yp install
  insinto /etc/rc.d/init.d
  doins ${O}/files/ypbind
  dodoc AUTHORS ChangeLog COPYING README THANKS TODO
  insinto /etc/yp
  doins etc/yp.conf
  prepman
}




