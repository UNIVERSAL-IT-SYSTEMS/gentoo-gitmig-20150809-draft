# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/dictd-jargon/dictd-jargon-4.2.3-r1.ebuild,v 1.1 2001/06/09 19:22:43 michael Exp $

#P=
A=jargon_4.2.3.tar.gz
S=${WORKDIR}
DESCRIPTION="Jargon lexicon"
SRC_URI="ftp://ftp.dict.org/pub/dict/pre/${A}"
HOMEPAGE="http://www.dict.org"

DEPEND=">=app-text/dictd-1.5.5"

src_install () {
	dodoc README
	dodir /usr/lib/dict
	insinto /usr/lib/dict
	doins jargon.dict.dz
	doins jargon.index
}

# vim: ai et sw=4 ts=4
