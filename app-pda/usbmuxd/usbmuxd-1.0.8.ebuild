# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/usbmuxd/usbmuxd-1.0.8.ebuild,v 1.3 2012/05/05 17:29:25 ssuominen Exp $

EAPI=4
inherit cmake-utils user

DESCRIPTION="USB multiplex daemon for use with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://www.libimobiledevice.org/"
SRC_URI="http://www.libimobiledevice.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2 GPL-3 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

RDEPEND=">=app-pda/libplist-1.8-r1
	virtual/libusb:1"
DEPEND="${RDEPEND}
	virtual/os-headers"

pkg_setup() {
	enewgroup plugdev
	enewuser usbmux -1 -1 -1 "usb,plugdev"
}

DOCS="AUTHORS README README.devel"

src_configure() {
	# Modules/FindUSB.cmake is broken wrt #414601
	local mycmakeargs=(
		-DUSB_INCLUDE_DIR=/usr/include/libusb-1.0
		)
	
	cmake-utils_src_configure
}
