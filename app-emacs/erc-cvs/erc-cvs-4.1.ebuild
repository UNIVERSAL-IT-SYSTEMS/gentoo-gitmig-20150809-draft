# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/erc-cvs/erc-cvs-4.1.ebuild,v 1.1 2003/12/05 14:44:23 jbms Exp $

ECVS_SERVER="cvs.erc.sourceforge.net:/cvsroot/erc"
ECVS_MODULE="erc"
ECVS_USER="anonymous"
ECVS_CVS_OPTIONS="-dP"

inherit elisp cvs

S=${WORKDIR}/${ECVS_MODULE}
DESCRIPTION="ERC - The Emacs IRC Client - CVS"
HOMEPAGE="http://emacswiki.org/cgi-bin/wiki.pl?EmacsIRCClient"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

# Never use the sandbox, it causes Emacs to segfault on startup
SANDBOX_DISABLED="1"
RESTRICT="$RESTRICT nostrip"

DEPEND="virtual/emacs"

SITEFILE="50${PN}-gentoo.el"

src_compile() {
	make || die
}

src_install() {
	elisp_src_install
	dodoc AUTHORS CREDITS HISTORY ChangeLog servers.pl README
}
