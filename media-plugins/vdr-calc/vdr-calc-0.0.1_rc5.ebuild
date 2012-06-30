# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-calc/vdr-calc-0.0.1_rc5.ebuild,v 1.6 2012/06/30 18:54:54 hd_brummy Exp $

EAPI="4"

inherit vdr-plugin-2

DESCRIPTION="Video Disk Recorder - Calculator PlugIn"
HOMEPAGE="http://www.vdrcalc.bmschneider.de/index2.html"
SRC_URI="http://www.vdrcalc.bmschneider.de/dateien/${PN}-0[1].0.1-rc5.tgz"

KEYWORDS="x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.3.7"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${VDRPLUGIN}-0.0.1-rc5

PATCHES=( "${FILESDIR}/${P}-gcc4.diff" )
