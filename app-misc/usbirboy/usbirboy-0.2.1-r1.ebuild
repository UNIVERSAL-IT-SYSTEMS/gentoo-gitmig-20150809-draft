# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/usbirboy/usbirboy-0.2.1-r1.ebuild,v 1.10 2006/12/14 11:11:26 zzam Exp $

inherit linux-mod eutils

DESCRIPTION="Use home made infrared receiver connected via USB"
HOMEPAGE="http://usbirboy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${P}/usbirboykmod"

pkg_setup() {
	linux-mod_pkg_setup

	if ! kernel_is 2 6; then
		die "This package works only with 2.6 kernel!"
	fi

	if ! linux_chkconfig_present USB; then
		die "You need a kernel with enabled USB support!"
	fi

	MODULE_NAMES="usbirboy(misc:${S})"
	BUILD_PARAMS="INCLUDE=${KV_DIR}"
	BUILD_TARGETS="default"
}

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-kernel-2.6.16.diff
	epatch ${FILESDIR}/${P}-module_param.diff
	epatch ${FILESDIR}/${P}-nice-kernel-msgs.diff
}

src_install() {
	linux-mod_src_install

	dodoc README
	newdoc ../usbirboymcu/README README.mcu

	insinto /usr/share/${PN}
	doins ../mcubin/usbirboy.s19

	# Add configuration for udev
	dodir /etc/udev/rules.d
	echo 'KERNEL=="usbirboy", NAME="%k", SYMLINK="lirc"' \
		> "${D}etc/udev/rules.d/55-${PN}.rules"
}

pkg_postinst() {
	linux-mod_pkg_postinst
	einfo
	einfo "Firmware file has been installed to /usr/share/${PN}"
	einfo
}

