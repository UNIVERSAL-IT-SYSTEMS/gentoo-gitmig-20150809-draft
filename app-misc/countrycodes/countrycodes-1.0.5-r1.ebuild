# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/countrycodes/countrycodes-1.0.5-r1.ebuild,v 1.5 2010/12/05 18:07:50 armin76 Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="An ISO 3166 country code finder"
HOMEPAGE="http://www.grigna.com/diego/linux/countrycodes/"
SRC_URI="http://www.grigna.com/diego/linux/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~ia64 ~mips ppc ~ppc64 sparc x86"
IUSE=""

S="${WORKDIR}"/${P}/src

src_prepare() {
	epatch "${FILESDIR}"/${PV}-Makefile.patch
	tc-export CC
}

#src_compile() {
#	emake -C src CCOPTS="${CFLAGS}" || die "emake failed"
#}

src_install() {
	emake \
		prefix="${D}/usr" \
		mandir="${D}/usr/share/man/man1" install || die "make install failed"
	dosym iso3166 /usr/bin/countrycodes || die
	dosym iso3166.1 /usr/share/man/man1/countrycodes || die
	dodoc ../doc/{Changelog,README} || die
	prepman
}
