# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vorbis-tools/vorbis-tools-1.1.1-r1.ebuild,v 1.1 2005/10/07 22:47:16 matsuu Exp $

IUSE="nls flac speex"

inherit toolchain-funcs flag-o-matic

DESCRIPTION="tools for using the Ogg Vorbis sound file format"
HOMEPAGE="http://www.vorbis.com/"
SRC_URI="http://downloads.xiph.org/releases/vorbis/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"

RDEPEND=">=media-libs/libvorbis-1.0.1
	>=media-libs/libao-0.8.2
	>=net-misc/curl-7.9
	speex? ( media-libs/speex )
	flac? ( media-libs/flac )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	use hppa && [ "`gcc-fullversion`" == "3.3.2" ] && replace-flags -march=2.0 -march=1.0
	local myconf

	# --with-flac is not supported.  See bug #49763
	use flac || myconf="${myconf} --without-flac"
	# --with-speex is not supported. See bug #97316
	use speex || myconf="${myconf} --without-speex"
	use nls || myconf="${myconf} --disable-nls"

	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	rm -rf ${D}/usr/share/doc
	dodoc AUTHORS README
	docinto ogg123
	dodoc ogg123/ogg123rc-example
}
