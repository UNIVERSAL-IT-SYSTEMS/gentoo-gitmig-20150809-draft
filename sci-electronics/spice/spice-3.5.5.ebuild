# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/spice/spice-3.5.5.ebuild,v 1.5 2007/03/12 18:21:20 calchan Exp $

inherit eutils flag-o-matic

IUSE=""

MY_P="spice3f5sfix"
DESCRIPTION="general-purpose circuit simulation program"
HOMEPAGE="http://bwrc.eecs.berkeley.edu/Classes/IcBook/SPICE/"
SRC_URI="http://www.ibiblio.org/pub/Linux/apps/circuits/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"

DEPEND="sys-libs/ncurses
	|| ( ( x11-libs/libXaw
		x11-proto/xproto
		)
		virtual/x11 )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	# spice accepts -O1 at most
	replace-flags -O* -O1

	unpack ${A}
	cd ${S}
	# Avoid re-creating WORKDIR due to stupid mtime
	touch ..

	[ -z $EDITOR ] || EDITOR="vim"
	sed -i -e "s:termcap:ncurses:g" \
		-e "s:joe:${EDITOR}:g" \
		-e "s:-O2 -s:${CFLAGS}:g" \
		-e "s:SPICE_DIR)/lib:SPICE_DIR)/lib/spice:g" \
		-e "s:/usr/local/spice:/usr:g" \
		conf/linux
	sed -i -e "s:head -1:head -n 1:" util/build
	epatch ${FILESDIR}/${P}-gcc-4.1.patch
}

src_compile() {
	./util/build linux || die
	obj/bin/makeidx lib/helpdir/spice.txt || die
}

src_install() {
	cd ${S}
	# install binaries
	dobin obj/bin/{spice3,nutmeg,sconvert,multidec,proc2mod} || die
	newbin obj/bin/help spice.help
	dosym /usr/bin/spice3 /usr/bin/spice
	# install runtime stuff
	rm -f lib/make*
	dodir /usr/lib/spice
	cp -R lib/* ${D}/usr/lib/spice/
	# install docs
	doman man/man1/*.1
	dodoc readme readme.Linux notes/spice2
}
