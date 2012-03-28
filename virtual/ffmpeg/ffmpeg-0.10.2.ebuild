# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/ffmpeg/ffmpeg-0.10.2.ebuild,v 1.1 2012/03/28 07:32:51 scarabeus Exp $

EAPI=4

DESCRIPTION="Virtual package for FFmpeg implementation"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="X +encode jpeg2k mp3 sdl theora threads vaapi vdpau x264"

RDEPEND="
	|| (
		>=media-video/ffmpeg-0.10.2[X=,encode=,jpeg2k=,mp3=,sdl=,theora=,threads=,vaapi=,vdpau=,x264=]
		>=media-video/libav-0.8.1[X=,encode=,jpeg2k=,mp3=,sdl=,theora=,threads=,vaapi=,vdpau=,x264=]
	)
"
DEPEND=""
