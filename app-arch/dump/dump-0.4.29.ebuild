# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/dump/dump-0.4.29.ebuild,v 1.8 2002/11/30 02:09:46 vapier Exp $

MY_P=${P/4./4b}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Dump/restore ext2fs backup utilities"
SRC_URI="mirror://sourceforge/dump/${MY_P}.tar.gz"
HOMEPAGE="http://dump.sourceforge.net/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 sparc sparc64"
IUSE="readline static"

DEPEND=">=sys-apps/e2fsprogs-1.27
	>=sys-apps/bzip2-1.0.2
	>=sys-libs/zlib-1.1.4
	sys-kernel/linux-headers
	readline? ( sys-libs/readline )"
RDEPEND="sys-apps/star"

src_unpack() {
	unpack ${A}
	cd ${S}
	if [ `use readline` ] ; then
		for i in configure configure.in
		do
			cp ${i} ${i}.orig
			sed "s:-ltermcap:-lncurses:g" \
				${i}.orig > ${i}
		done
	fi
}

src_compile() {
	local myconf

	use readline \
		&& myconf="--enable-readline" \
		|| myconf="--disable-readline"

	use static \
		&& myconf="${myconf} --snable-static" \
		|| myconf="${myconf} --enable-shared"

	econf \
		--with-dumpdatespath=/etc/dumpdates \
		--with-binowner=root \
		--with-bingroup=root \
		--enable-largefile \
		${myconf}

	emake || die
}
src_install() {
	einstall MANDIR=${D}/usr/share/man/man8

	dodoc CHANGES COPYRIGHT INSTALL KNOWNBUGS MAINTAINERS README \
		REPORTING-BUGS THANKS TODO
	dodoc -r examples/dump_on_cd
}
