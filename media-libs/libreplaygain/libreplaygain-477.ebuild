# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libreplaygain/libreplaygain-477.ebuild,v 1.8 2012/09/30 18:10:26 armin76 Exp $

EAPI=4
inherit cmake-utils

# svn export http://svn.musepack.net/libreplaygain libreplaygain-${PV}
# tar -cJf libreplaygain-${PV}.tar.xz libreplaygain-${PV}

DESCRIPTION="Replay Gain library from Musepack"
HOMEPAGE="http://www.musepack.net/"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

src_prepare() {
	sed -i -e '/CMAKE_C_FLAGS/d' CMakeLists.txt || die
}

src_install() {
	cmake-utils_src_install
	insinto /usr/include
	doins -r include/replaygain
}
