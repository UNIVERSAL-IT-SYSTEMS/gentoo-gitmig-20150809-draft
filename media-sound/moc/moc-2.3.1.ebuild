# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/moc/moc-2.3.1.ebuild,v 1.1.1.1 2005/11/30 09:38:29 chriswhite Exp $

inherit eutils autotools

DESCRIPTION="Music On Console - ncurses interface for playing audio files"
HOMEPAGE="http://moc.daper.net/"
SRC_URI="ftp://ftp.daper.net/pub/soft/${PN}/stable/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="flac jack muse mad oss vorbis debug alsa speex libsamplerate curl sndfile muse"

# libvorbis is pulled in so the USE flag is vorbis
# since upstream apparently assumes ogg is an audio
# codec
DEPEND="media-libs/libao
	sys-libs/ncurses
	alsa? ( >=media-libs/alsa-lib-0.9 )
	sndfile? ( >=media-libs/libsndfile-1.0.0 )
	flac? ( media-libs/flac )
	mad? ( media-libs/libmad sys-libs/zlib media-libs/libid3tag )
	muse? ( media-libs/libmpcdec >=media-libs/taglib-1.3 )
	vorbis? ( >=media-libs/libvorbis-1.0 )
	jack? ( >=media-sound/jack-audio-connection-kit-0.4 )
	speex? ( >=media-libs/speex-1.0.0 )
	libsamplerate? ( >=media-libs/libsamplerate-0.1.0 )
	curl? ( >=net-misc/curl-7.12.0 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	# big configure fixes
	epatch ${FILESDIR}/${P}-configure.patch
	AT_M4DIR="m4"
	eautoreconf
}

src_compile() {
	econf \
	$(use_with flac) \
	$(use_with mad mp3) \
	$(use_with vorbis ogg) \
	$(use_with oss) \
	$(use_with alsa) \
	$(use_with jack) \
	$(use_with muse musepack) \
	$(use_enable debug) \
	$(use_with sndfile) \
	$(use_with libsamplerate samplerate) \
	|| die "./configure failed"
	emake || die "make failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	einfo "The binary was renamed due to conflicts with moc"
	einfo "from the QT project. Its new name is mocp."
}
