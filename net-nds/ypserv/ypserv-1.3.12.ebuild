# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/ypserv/ypserv-1.3.12.ebuild,v 1.15 2004/04/28 20:53:03 vapier Exp $

IUSE="tcpd"

S=${WORKDIR}/${P}
DESCRIPTION="NIS SERVER"
SRC_URI="mirror://kernel/linux/utils/net/NIS/${P}.tar.gz"
HOMEPAGE="http://www.linux-nis.org/nis/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

DEPEND=">=sys-libs/gdbm-1.8.0
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp ${FILESDIR}/defs.sed ypmake
	patch < ${FILESDIR}/${PV}/volatile-fix-gcc-3.2.diff || die
}

src_compile() {
	local myconf
	use tcpd && myconf="${myconf} --enable-tcp-wrapper"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--mandir=/usr/share/man \
		--enable-yppasswd \
		${myconf} || die

	make || die

	cd ${S}/ypmake
	sed -f defs.sed Makefile.in > Makefile
	make || die
}

src_install() {
	make \
		ROOT=${D} \
		installdirs install_progs || die

	exeinto /usr/sbin
	cd ${S}/contrib ; doexe ypslave
	cd ${S}/ypmake ; doexe ypmake

	insinto /usr/lib/yp/ypmake
	for i in aliases arrays automount config ethers group gshadow hosts \
		netgroup netid networks passwd protocols publickey \
		rpc services shadow ypservers
	do
		doins $i
	done

	insinto /var/yp
	doins ypmake.conf.sample

	newman ypmake.man ypmake.8
	newman ypmake.conf.man ypmake.conf.5

	cd ${S}
	dodoc BUGS ChangeLog HOWTO.SuSE NEWS TODO

	insinto /etc ; doins etc/ypserv.conf

	exeinto /etc/init.d
	newexe ${FILESDIR}/ypserv-initd ypserv
}
