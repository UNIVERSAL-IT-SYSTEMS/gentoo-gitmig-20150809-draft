# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audiotag/audiotag-0.19.ebuild,v 1.1 2010/08/27 01:06:32 radhermit Exp $

DESCRIPTION="A command-line tool for mass tagging/renaming of audio files."
HOMEPAGE="http://github.com/Daenyth/audiotag"
SRC_URI="http://github.com/downloads/Daenyth/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="aac flac mp3 vorbis"

RDEPEND="dev-lang/perl
	flac? ( media-libs/flac )
	vorbis? ( media-sound/vorbis-tools )
	mp3? ( media-libs/id3lib )
	aac? ( media-video/atomicparsley )"
DEPEND=""

src_install() {
	dobin ${PN}
	dodoc ChangeLog README
}
