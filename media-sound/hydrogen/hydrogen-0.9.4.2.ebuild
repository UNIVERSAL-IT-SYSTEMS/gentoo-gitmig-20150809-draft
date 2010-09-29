# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/hydrogen/hydrogen-0.9.4.2.ebuild,v 1.1 2010/09/29 01:44:39 ssuominen Exp $

EAPI=2
inherit eutils multilib

DESCRIPTION="Advanced drum machine"
HOMEPAGE="http://www.hydrogen-music.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="alsa +archive flac jack ladspa lash oss portaudio"

RDEPEND="x11-libs/qt-gui:4
	archive? ( app-arch/libarchive )
	!archive? ( >=dev-libs/libtar-1.2.11-r3 )
	media-libs/libsndfile
	alsa? ( media-libs/alsa-lib )
	flac? ( media-libs/flac[cxx] )
	jack? ( media-sound/jack-audio-connection-kit )
	ladspa? ( media-libs/liblrdf )
	lash? ( media-sound/lash )
	portaudio? ( >=media-libs/portaudio-19_pre )"
DEPEND="${RDEPEND}
	dev-util/scons"

src_prepare() {
	sed -i -e '/cppflags +=/d' Sconstruct || die
	epatch patches/portaudio.patch
}

src_compile() {
	export QTDIR="/usr/$(get_libdir)"
	local myconf='portmidi=0' #90614

	use alsa || myconf+=' alsa=0'
	use archive && myconf+=' libarchive=1'
	use flac || myconf+=' flac=0'
	use jack || myconf+=' jack=0'
	use ladspa || myconf+=' lrdf=0'
	use lash && myconf+=' lash=1'
	use oss || myconf+=' oss=0'
	use portaudio && myconf+=' portaudio=1'

	scons \
		prefix=/usr \
		DESTDIR="${D}" \
		optflags="${CXXFLAGS}" \
		${myconf} || die
}

src_install() {
	dobin hydrogen || die
	insinto /usr/share/hydrogen
	doins -r data || die
	doicon data/img/gray/h2-icon.svg
	domenu hydrogen.desktop
	dosym /usr/share/hydrogen/data/doc /usr/share/doc/${PF}/html
	dodoc AUTHORS ChangeLog README.txt
}
