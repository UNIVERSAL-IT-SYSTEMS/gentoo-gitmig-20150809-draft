# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/stratego/stratego-0.9.4.ebuild,v 1.3 2004/06/24 22:57:30 agriffis Exp $

inherit flag-o-matic

DESCRIPTION="Stratego term-rewriting language"
HOMEPAGE="http://www.stratego-language.org/"
SRC_URI="ftp://ftp.stratego-language.org/pub/stratego/StrategoXT/strategoxt-0.9.4.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha"

DEPEND=">=dev-libs/aterm-2.0
	>=dev-libs/sdf2-bundle-1.6
	>=dev-libs/cpl-stratego-0.4"
S=${WORKDIR}/strategoxt-${PV}

src_compile() {
	filter-flags -fomit-frame-pointer
	econf || die "econf failed"
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
}
