# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dog/dog-1.7-r4.ebuild,v 1.1 2010/09/18 16:55:29 jlec Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="Dog is better than cat"
# the best HOMEPAGE we have.
HOMEPAGE="http://packages.gentoo.org/package/sys-apps/dog"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~sparc64-solaris"
IUSE=""

src_prepare() {
	epatch ${FILESDIR}/${P}-check-ctime.diff
	epatch ${FILESDIR}/${PV}-manpage-touchup.patch
	epatch ${FILESDIR}/${P}-64bit-goodness.patch
	epatch ${FILESDIR}/${P}-strfry.patch

	if [[ "${CHOST}" == *-solaris* ]]
	then
		sed -i '/gcc.*-o dog/s/$/ -lsocket/' \
			Makefile || die "sed Makefile failed"
	fi

	sed -i \
		-e 's,^CFLAGS,#CFLAGS,' \
		-e "s,gcc,$(tc-getCC)," \
		-e 's:-o dog:$(LDFLAGS) -o dog:g' \
		Makefile || die "sed Makefile failed"
}

src_install() {
	dobin dog || die
	doman dog.1 || die
	dodoc README AUTHORS || die
}
