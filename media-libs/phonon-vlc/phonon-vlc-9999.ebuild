# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/phonon-vlc/phonon-vlc-9999.ebuild,v 1.3 2011/07/14 10:57:02 dilfridge Exp $

EAPI=4

MY_PN="phonon-backend-vlc"
MY_P="${MY_PN}-${PV}"
EGIT_REPO_URI="git://anongit.kde.org/${PN}"
[[ ${PV} == 9999 ]] && git_eclass=git-2
inherit cmake-utils ${git_eclass}
unset git_eclass

DESCRIPTION="Phonon VLC backend"
HOMEPAGE="https://projects.kde.org/projects/kdesupport/phonon/phonon-vlc"
[[ ${PV} == 9999 ]] || SRC_URI="mirror://kde/stable/phonon/${MY_PN}/${PV}/src/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
[[ ${PV} == 9999 ]] || KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug v4l2"

RDEPEND="
	>=media-libs/phonon-4.5.0
	>=media-video/vlc-1.1.1[dbus,ogg,vorbis]
	>=x11-libs/qt-dbus-4.6.0:4
	>=x11-libs/qt-gui-4.6.0:4
	v4l2? ( media-libs/libv4l )
"
DEPEND="${RDEPEND}
	>=dev-util/automoc-0.9.87
	dev-util/pkgconfig
"

S=${WORKDIR}/${MY_P}

DOCS=( AUTHORS )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with v4l2)
	)
	cmake-utils_src_configure
}

pkg_postinst() {
	elog "For more verbose debug information, export the following variables:"
	use v4l2 && elog "PHONON_VLC_DEBUG=3"
	elog "PHONON_DEBUG=1"
	elog ""
	elog "To make KDE detect the new backend without reboot, run:"
	elog "kbuildsycoca4 --noincremental"
}
