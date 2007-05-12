# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-libs/bluez-libs-3.10.ebuild,v 1.4 2007/05/12 14:04:26 betelgeuse Exp $

inherit libtool

DESCRIPTION="Bluetooth Userspace Libraries"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc64 ~sparc ~x86"

IUSE="debug"
DEPEND="!net-wireless/bluez-sdp"
RDEPEND="${DEPEND}"

src_compile() {
	elibtoolize
	econf $(use_enable debug) || die "econf failed"
	if use debug ; then
		echo "#define SDP_DEBUG 1" >> config.h
	fi
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README || die

	# http://article.gmane.org/gmane.linux.bluez.announce/57
	# Although library major number changed, API is compatible.
	# Does not work with upgrades because ldconfig changes the symlink
	# to point back to the old version.
	#dosym libbluetooth.so.2 /usr/$(get_libdir)/libbluetooth.so.1
}

pkg_postinst() {
	elog "The ABI version of libbluetooth has changed."
	elog "Please run:"
	elog "  revdep-rebuild --library libbluetooth.so.1"
}
