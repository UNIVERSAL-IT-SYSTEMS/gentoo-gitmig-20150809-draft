# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rsm-mod/cl-rsm-mod-1.2.ebuild,v 1.5 2007/02/03 17:44:55 flameeyes Exp $

inherit common-lisp

DESCRIPTION="R. Scott McIntire's Common Lisp Modular Arithmetic Library"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-rsm-mod.html"
SRC_URI="mirror://gentoo/cl-rsm-mod_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp "

CLPACKAGE=rsm-mod

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc copying copyright
	dohtml *.html *.jpg
	do-debian-credits
}
