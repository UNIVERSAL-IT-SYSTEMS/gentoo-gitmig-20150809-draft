# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/microcode_ctl/microcode_ctl-1.06.ebuild,v 1.5 2002/10/04 06:27:29 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Intel IA32 microcode update utility"
HOMEPAGE="http://www.urbanmyth.org/microcode"
KEYWORDS="x86 -ppc -sparc -sparc64"
SLOT="0"
LICENSE="GPL-2"
SRC_URI="http://www.urbanmyth.org/microcode/${P}.tar.gz"
DEPEND="virtual/linux-sources"

src_compile() {
	make all || die "compile problem"
}

src_install() {
	into /usr/
	dosbin microcode_ctl
	doman microcode_ctl.8
	dodoc Changelog README
	insinto /etc/
	doins ${FILESDIR}/${PVR}/microcode.dat
	exeinto /etc/init.d/
	doexe ${FILESDIR}/${PVR}/microcode_ctl
}

pkg_postinst() {
	einfo
	einfo '################################################################'
	einfo '# For the microcode update to work, you need to have a kernel  #'
	einfo '# compiled with both devfs and microcode update support.       #'
	einfo '#                                                              #'
	einfo '#   To update the microcode now, simply type:                  #'
	einfo '#        "microcode_ctl -u"                                    #'
	einfo '#                                                              #'
	einfo '#   The update will not survive a reboot, for that type:       #'
	einfo '#        "rc-update add microcode_ctl default"                 #'
	einfo '################################################################'
	einfo
}
