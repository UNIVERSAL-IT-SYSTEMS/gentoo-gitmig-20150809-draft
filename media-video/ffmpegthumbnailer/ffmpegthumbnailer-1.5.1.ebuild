# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ffmpegthumbnailer/ffmpegthumbnailer-1.5.1.ebuild,v 1.3 2009/05/21 12:45:38 ssuominen Exp $

EAPI=2

DESCRIPTION="Lightweight video thumbnailer that can be used by file managers"
HOMEPAGE="http://code.google.com/p/ffmpegthumbnailer"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="altivec jpeg png"

RDEPEND=">=media-video/ffmpeg-0.5[altivec?]
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable png) \
		$(use_enable jpeg)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
}

pkg_postinst() {
	if use altivec; then
		ewarn "Altivec support is known to be broken wrt bug #252641."
	fi
}
