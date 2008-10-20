# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libpciaccess/libpciaccess-0.10.4.ebuild,v 1.1 2008/10/20 20:51:23 dberkholz Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Library providing generic access to the PCI bus and devices"
LICENSE="MIT"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="minimal"

CONFIGURE_OPTIONS="--with-pciids-path=/usr/share/misc"

src_install() {
	x-modular_src_install
	if ! use minimal; then
		dobin src/.libs/scanpci || die
	fi
}
