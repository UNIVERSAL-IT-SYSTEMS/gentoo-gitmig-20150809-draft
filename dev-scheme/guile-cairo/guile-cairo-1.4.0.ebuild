# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/guile-cairo/guile-cairo-1.4.0.ebuild,v 1.6 2010/03/08 08:51:17 sping Exp $

EAPI=2

DESCRIPTION="Wraps the Cairo graphics library for Guile Scheme"
HOMEPAGE="http://home.gna.org/guile-cairo/"
SRC_URI="http://download.gna.org/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="test"

RDEPEND=">=dev-scheme/guile-1.8
	>=x11-libs/cairo-1.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	test? ( dev-scheme/guile-lib )"

src_configure() {
	econf --disable-Werror
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "install failed"
	dodoc ChangeLog || die "dodoc failed"
}
