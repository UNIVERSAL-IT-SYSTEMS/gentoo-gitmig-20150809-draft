# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/dictd-wn/dictd-wn-1.5-r1.ebuild,v 1.1 2001/06/09 19:22:43 michael Exp $

#P=
A=dict-wn-1.5-pre.tar.gz
S=${WORKDIR}
DESCRIPTION=""
SRC_URI="ftp://ftp.dict.org/pub/dict/pre/${A}"
HOMEPAGE="http://www.dict.org"

DEPEND=">=app-text/dictd-1.5.5"

src_install () {
	dodir /usr/lib/dict
	insinto /usr/lib/dict
	doins wn.dict.dz
	doins wn.index
}

# vim: ai et sw=4 ts=4
