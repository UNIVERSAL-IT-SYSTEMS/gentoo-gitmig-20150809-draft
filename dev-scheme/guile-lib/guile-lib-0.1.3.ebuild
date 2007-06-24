# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/guile-lib/guile-lib-0.1.3.ebuild,v 1.4 2007/06/24 22:40:24 angelos Exp $

inherit eutils

DESCRIPTION="An accumulation place for pure-scheme Guile modules"
HOMEPAGE="home.gna.org/guile-lib/"
SRC_URI="http://download.gna.org/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE=""
RDEPEND="dev-scheme/guile"
DEPEND="${RDEPEND}"

pkg_setup() {
	local g=$(guile --version|line)
	[[ ${g#* } = 1.6* ]] || {
		built_with_use dev-scheme/guile regex deprecated || die "guile must be built with USE='regex deprecated'"
	}
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "install failed"
}
