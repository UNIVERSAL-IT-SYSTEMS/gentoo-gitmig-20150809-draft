# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tree/tree-1.5.0.ebuild,v 1.11 2005/03/16 02:30:24 mr_bones_ Exp $

inherit toolchain-funcs

DESCRIPTION="Lists directories recursively, and produces an indented listing of files."
HOMEPAGE="http://mama.indstate.edu/users/ice/tree/"
SRC_URI="ftp://mama.indstate.edu/linux/tree/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} -DLINUX_BIGFILE" \
		|| die "emake failed"
}

src_install() {
	dobin tree || die "dobin failed"
	doman tree.1
	dodoc CHANGES README*
}
