# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/c2hs/c2hs-0.16.3-r1.ebuild,v 1.2 2012/08/03 12:55:54 hwoarang Exp $

EAPI="3"

CABAL_FEATURES="bin"
inherit base haskell-cabal

DESCRIPTION="C->Haskell FFI tool that gives some cross-language type safety"
HOMEPAGE="http://www.cse.unsw.edu.au/~chak/haskell/c2hs/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.6
		>=dev-haskell/language-c-0.3.1.1 <dev-haskell/language-c-0.5
		doc? (  ~app-text/docbook-xml-dtd-4.2
				app-text/docbook-xsl-stylesheets
				>=dev-libs/libxslt-1.1.2 )"
RDEPEND="dev-libs/gmp"

PATCHES=("${FILESDIR}/${PN}"-0.16.3-language-c-0.4.patch)

src_compile() {
	cabal_src_compile

	if use doc; then
		emake -C doc
	fi
}

src_install() {
	cabal_src_install

	doman "${S}/doc/man1/c2hs.1"

	if use doc; then
		dohtml "${S}/doc/users_guide/"*
	fi
}
