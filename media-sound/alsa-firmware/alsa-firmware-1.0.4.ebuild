# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-firmware/alsa-firmware-1.0.4.ebuild,v 1.2 2004/04/16 11:21:30 lv Exp $

MY_P=${P/_rc/rc}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Advanced Linux Sound Architecture firmware"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/firmware/${P}.tar.bz2"
RESTRICT="nomirror"

SLOT="0"
KEYWORDS="~x86 ~amd64"
LICENSE="GPL-2"
IUSE=""
DEPEND=""

src_install () {
	make DESTDIR=${D} install || die
	dodoc README
}
