# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-flashrider/fortune-mod-flashrider-0.80.ebuild,v 1.3 2010/12/11 16:07:04 grobian Exp $

EAPI=3

MY_PN="${PN/-mod/s}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Quotes from Prolinux articles and comments"
HOMEPAGE="http://www.nanolx.org/random/fortunesflashrider/"
SRC_URI="http://www.nanolx.org/downloads/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="games-misc/fortune-mod"

S=${WORKDIR}/${MY_PN}

src_prepare()
{
	sed -e 's#INSTALLDIR = .*#INSTALLDIR = /share/fortune#' -i Makefile
}

src_install() {
	emake install PREFIX="${EPREFIX}"/usr DESTDIR="${D}"
	dodoc AUTHORS ChangeLog README
}
