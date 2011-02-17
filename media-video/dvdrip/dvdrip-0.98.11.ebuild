# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvdrip/dvdrip-0.98.11.ebuild,v 1.8 2011/02/17 16:44:40 ssuominen Exp $

EAPI=2
inherit eutils flag-o-matic perl-module

DESCRIPTION="dvd::rip is a graphical frontend for transcode"
HOMEPAGE="http://www.exit1.org/dvdrip/"
SRC_URI="http://www.exit1.org/dvdrip/dist/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 sparc x86"
IUSE="ffmpeg fping mplayer ogg subtitles vcd vorbis xine xvid"

DEPEND=">=dev-perl/Event-ExecFlow-0.64
	>=dev-perl/Event-RPC-0.89
	dev-perl/gtk2-perl
	>=dev-perl/gtk2-ex-formfactory-0.65
	>=dev-perl/libintl-perl-1.16
	|| ( media-gfx/graphicsmagick[imagemagick] media-gfx/imagemagick )
	|| ( <media-video/transcode-1.1.0_pre0[dvd,jpeg,mp3,mpeg,ogg,vorbis]
		>=media-video/transcode-1.1.0_pre0[dvd,jpeg,mp3,ogg,vorbis] )"
RDEPEND="${DEPEND}
	|| ( x11-libs/gdk-pixbuf:2[jpeg] x11-libs/gtk+:2[jpeg] )
	ffmpeg? ( media-video/ffmpeg )
	fping? ( >=net-analyzer/fping-2.2 )
	mplayer? ( media-video/mplayer )
	ogg? ( media-sound/ogmtools )
	subtitles? ( media-video/subtitleripper )
	vcd? (
		media-video/transcode[mjpeg]
		>=media-video/mjpegtools-1.6.0
	)
	vorbis? ( media-sound/vorbis-tools )
	xine? ( media-video/xine-ui )
	xvid? ( media-video/xvid4conf )
	>=media-video/lsdvd-0.15"

MAKEOPTS="${MAKEOPTS} -j1"

pkg_setup() {
	filter-flags -ftracer
	export SKIP_UNPACK_REQUIRED_MODULES=1 #255269

	perl-module_pkg_setup
}

src_prepare() {
	sed -i -e 's:$(CC):$(CC) $(OTHERLDFLAGS):' src/Makefile || die
}

src_install() {
	newicon lib/Video/DVDRip/icon.xpm dvdrip.xpm
	make_desktop_entry dvdrip dvd::rip dvdrip AudioVideo
	DOCS="Changes Changes.0.46 Credits README TODO"

	perl-module_src_install
}

pkg_postinst() {
	# bug 173924
	if use fping; then
		ewarn "For dvdrip-master to work correctly with cluster mode,"
		ewarn "the fping binary must be setuid."
		ewarn ""
		ewarn "Run this command to fix it:"
		ewarn "chmod u=rwsx,g=rx,o=rx /usr/sbin/fping"
		ewarn ""
		ewarn "Note that this is a security risk when enabled."
	fi
}
