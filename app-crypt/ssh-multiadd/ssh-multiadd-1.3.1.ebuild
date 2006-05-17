# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ssh-multiadd/ssh-multiadd-1.3.1.ebuild,v 1.24 2006/05/17 00:41:15 merlin Exp $

inherit eutils

DESCRIPTION="adds multiple ssh keys to the ssh authentication agent. These may use the same passphrase. Unlike ssh-add, if any of the keys use the same passphrase, you will only need to enter each unique passphrase once, and keys that are already added will not be prompted for again."
HOMEPAGE="http://www.azstarnet.com/~donut/programs/index_s.html#ssh-multiadd"
SRC_URI="http://www.azstarnet.com/~donut/programs/ssh-multiadd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~amd64"
IUSE="X"

DEPEND=">=dev-lang/python-2.0-r3
	X? ( >=net-misc/x11-ssh-askpass-1.2.2 )"

src_unpack() {
	 unpack ${A} ; cd ${S}
	 epatch ${FILESDIR}/${P}.diff
}

src_install() {
	dobin ssh-multiadd || die
	doman ssh-multiadd.1
	dodoc ChangeLog README todo
}
