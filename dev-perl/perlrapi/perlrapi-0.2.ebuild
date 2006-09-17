# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perlrapi/perlrapi-0.2.ebuild,v 1.12 2006/09/17 01:47:24 mcummings Exp $

inherit perl-module

IUSE=""

S=${WORKDIR}/perlrapi

DESCRIPTION="Synchronize Windows CE devices with computers running GNU/Linux, like MS ActiveSync. - PERL bindings"
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 x86"

DEPEND="virtual/libc
	app-pda/synce-librapi2
	dev-lang/perl"
RDEPEND="${DEPEND}"

