# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/sandboxshell/sandboxshell-0.1.ebuild,v 1.6 2004/04/25 20:11:35 vapier Exp $

DESCRIPTION="launch a sandboxed shell ... useful for debugging ebuilds"
HOMEPAGE="http://wh0rd.org/"
SRC_URI=""

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64"
# if portage works, this will work ;)

DEPEND=""
RDEPEND="sys-apps/portage
	app-shells/bash"

S=${WORKDIR}

src_install() {
	dobin ${FILESDIR}/sandboxshell
	doman ${FILESDIR}/sandboxshell.1
	insinto /etc
	doins ${FILESDIR}/sandboxshell.conf
}
