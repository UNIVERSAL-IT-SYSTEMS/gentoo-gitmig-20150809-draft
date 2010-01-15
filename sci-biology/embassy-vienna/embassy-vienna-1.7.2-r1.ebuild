# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-vienna/embassy-vienna-1.7.2-r1.ebuild,v 1.2 2010/01/15 22:47:16 fauli Exp $

EBOV="6.1.0"

inherit embassy

DESCRIPTION="EMBOSS integrated version of the Vienna RNA package - RNA folding"
SRC_URI="ftp://emboss.open-bio.org/pub/EMBOSS/EMBOSS-${EBOV}.tar.gz
	mirror://gentoo/embassy-${EBOV}-${PN:8}-${PV}.tar.gz"

KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
