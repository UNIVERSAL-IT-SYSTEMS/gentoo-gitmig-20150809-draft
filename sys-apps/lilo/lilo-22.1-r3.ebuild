# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lilo/lilo-22.1-r3.ebuild,v 1.8 2002/10/04 06:26:40 vapier Exp $

inherit mount-boot

S=${WORKDIR}/${P}
DESCRIPTION="Standard Linux boot loader"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/boot/lilo/${P}.tar.gz"
HOMEPAGE="http://brun.dyndns.org/pub/linux/lilo/"
KEYWORDS="x86 -ppc -sparc -sparc64"
SLOT="0"
LICENSE="BSD"
DEPEND="virtual/glibc >=sys-devel/bin86-0.15.5"

RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp Makefile Makefile.orig
	sed -e "s:-g:${CFLAGS}:" Makefile.orig > Makefile
}

src_compile() {
	emake || die
}

src_install() {
	into /
	dosbin lilo
	into /usr
	dosbin keytab-lilo.pl
	dodir /boot
	insinto /boot
	doins boot-text.b boot-menu.b boot-bmp.b chain.b os2_d.b
	insinto /etc
	newins ${FILESDIR}/lilo.conf lilo.conf.example
	doman manPages/*.[5-8]
	dodoc CHANGES COPYING INCOMPAT QuickInst README*
}

pkg_preinst() {
	if [ ! -L $ROOT/boot/boot.b -a -f $ROOT/boot/boot.b ]
	then
		echo "Saving old boot.b..."
		mv $ROOT/boot/boot.b $ROOT/boot/boot.old; 
	fi

	if [ ! -L $ROOT/boot/chain.b -a -f $ROOT/boot/chain.b ]
	then
		echo "Saving old chain.b..."
		mv $ROOT/boot/chain.b $ROOT/boot/chain.old;
	fi

	if [ ! -L $ROOT/boot/os2_d.b -a -f $ROOT/boot/os2_d.b ]
	then
		echo "Saving old os2_d.b..."
		mv $ROOT/boot/os2_d.b $ROOT/boot/os2_d.old;
	fi
}

pkg_postinst() {

	. ${ROOT}/etc/init.d/functions.sh

	einfo "Activating boot-menu..."
	ln -sf boot-menu.b $ROOT/boot/boot.b;
}


