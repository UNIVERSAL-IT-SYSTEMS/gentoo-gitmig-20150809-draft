# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kavi2svcd/kavi2svcd-0.8.2.ebuild,v 1.6 2004/06/25 00:42:03 agriffis Exp $

inherit kde
need-kde 3

DESCRIPTION="GUI for generating VCD-compliant MPEG files from an AVI or MPEG file"
HOMEPAGE="http://kavi2svcd.sourceforge.net/"
SRC_URI="mirror://sourceforge/kavi2svcd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND=">=media-video/transcode-0.6.6
	>=media-video/mjpegtools-1.6.0-r7
	kde-base/kdelibs
	cdr? ( >=media-video/vcdimager-0.7.19
		>=app-cdr/cdrdao-1.1.7-r1 )"

src_unpack() {
	kde_src_unpack
	sed -i 's:;;$:;:' ${S}/kavi2svcd/{prefclass,vcdclass}.h
}
