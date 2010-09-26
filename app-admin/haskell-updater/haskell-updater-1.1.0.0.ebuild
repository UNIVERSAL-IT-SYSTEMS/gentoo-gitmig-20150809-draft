# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/haskell-updater/haskell-updater-1.1.0.0.ebuild,v 1.8 2010/09/26 19:41:52 hwoarang Exp $

CABAL_FEATURES="bin nocabaldep"
inherit haskell-cabal

DESCRIPTION="Rebuild Haskell dependencies in Gentoo"
HOMEPAGE="http://haskell.org/haskellwiki/Gentoo#haskell-updater"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd" # Add keywords as those archs have a binpkg
IUSE=""

DEPEND="=dev-lang/ghc-6.12*"

# Need a lower version for portage to get --keep-going
RDEPEND="|| ( >=sys-apps/portage-2.1.6
			  sys-apps/pkgcore
			  sys-apps/paludis )"

src_compile() {
	CABAL_CONFIGURE_FLAGS="--bindir=/usr/sbin"

	cabal_src_compile
}

src_install() {
	cabal_src_install

	dodoc TODO
}
