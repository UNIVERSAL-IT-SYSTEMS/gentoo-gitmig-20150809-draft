# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/ktexmaker2/ktexmaker2-1.7.ebuild,v 1.8 2002/08/14 18:36:02 murphy Exp $

inherit kde-base || die

need-kde 2.2

DESCRIPTION="A Latex Editor and TeX shell for kde2"
SRC_URI="http://xm1.net.free.fr/linux/${P}.tar.gz"
HOMEPAGE="http://xm1.net.free.fr/linux/index.html"

DEPEND="$DEPEND sys-devel/perl"
RDEPEND="${RDEPEND} app-text/tetex"


LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"
