# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/gnustep-gui/gnustep-gui-0.20.0.ebuild,v 1.2 2011/08/10 09:08:01 grobian Exp $

EAPI="3"

inherit gnustep-base multilib

DESCRIPTION="Library of GUI classes written in Obj-C"
HOMEPAGE="http://www.gnustep.org/"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/${P}.tar.gz"

KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-solaris"
SLOT="0"
LICENSE="LGPL-2.1"

IUSE="jpeg gif png cups"

DEPEND="${GNUSTEP_CORE_DEPEND}
	>=gnustep-base/gnustep-base-1.22.0
	x11-libs/libXt
	>=media-libs/tiff-3
	jpeg? ( virtual/jpeg )
	gif? ( >=media-libs/giflib-4.1 )
	png? ( >=media-libs/libpng-1.2 )
	cups? ( >=net-print/cups-1.1 )
	media-libs/audiofile
	app-text/aspell"
RDEPEND="${DEPEND}"

src_prepare() {
	gnustep-base_src_prepare
	# remove hardcoded -g -Werror, bug #378179
	sed -i -e 's/-g -Werror//' \
		Tools/say/GNUmakefile \
		Tools/speech/GNUmakefile \
		|| die
}

src_configure() {
	egnustep_env

	local myconf=
	use gif && myconf="--disable-ungif --enable-libgif"

	econf \
		--with-tiff-include="${EPREFIX}"/usr/include \
		--with-tiff-library="${EPREFIX}"/usr/$(get_libdir) \
		$(use_enable jpeg) \
		$(use_enable png) \
		$(use_enable cups) \
		${myconf} || die "configure failed"
}

pkg_postinst() {
	ewarn "The shared library version has changed in this release."
	ewarn "You will need to recompile all Applications/Tools/etc in order"
	ewarn "to use this library. Please run revdep-rebuild to do so"
}
