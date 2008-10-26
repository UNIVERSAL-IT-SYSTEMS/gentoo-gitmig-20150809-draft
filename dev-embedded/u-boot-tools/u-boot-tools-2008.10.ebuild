# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/u-boot-tools/u-boot-tools-2008.10.ebuild,v 1.1 2008/10/26 02:22:03 vapier Exp $

MY_P="u-boot-${PV}"

DESCRIPTION="utilities for working with Das U-Boot"
HOMEPAGE="http://www.denx.de/wiki/U-Boot/WebHome"
SRC_URI="ftp://ftp.denx.de/pub/u-boot/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${MY_P}

src_compile() {
	touch include/config.{h,mk}
	emake HOSTSTRIP=echo BIN_FILES="bmp_logo gen_eth_addr img2srec mkimage" tools || die
	emake HOSTSTRIP=echo -C tools/easylogo || die
	emake env || die
}

src_install() {
	cd tools
	dobin bmp_logo gen_eth_addr img2srec mkimage || die
	dobin easylogo/easylogo || die
	dobin env/fw_printenv || die
	dosym fw_printenv /usr/bin/fw_setenv || die
	insinto /etc
	doins env/fw_env.config || die
}
