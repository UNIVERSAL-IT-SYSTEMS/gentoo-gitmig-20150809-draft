# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jules Gagnon <eonwe@users.sourceforge.net>

LICQV=licq-1.0.3
A=${LICQV}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="licq-console"
SRC_URI="http://download.sourceforge.net/licq/${A}
         ftp://ftp.fanfic.org/pub/licq/srcs/${A}
         ftp://licq.darkorb.net/${A}
         ftp://ftp.fr.licq.org/pub/licq/srcs/${A}
         ftp://ftp.ru.licq.org/pub/licq/srcs/${A}
         ftp://ftp.pt.licq.org/pub/mirrors/licq/srcs/${A}
         ftp://mirror.itcnet.ro/pub/licq/srcs/${A}"
HOMEPAGE="http://www.licq.org"

DEPEND="=net-im/licq-1.0.3"

src_unpack() {
  unpack ${A}
}

src_compile() {
  cd ${WORKDIR}/${LICQV}/plugins/console-${PV}
  try ./configure --host=${CHOST} --prefix=/usr --with-licq-includes=/usr/include/licq
  try make
}

src_install() {
  cd ${WORKDIR}/${LICQV}/plugins/console-${PV}
  try make prefix=${D}/usr install
  dodoc README
}

