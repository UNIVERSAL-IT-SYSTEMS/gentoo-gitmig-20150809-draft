# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kdenlive/kdenlive-0.2.4.ebuild,v 1.5 2004/06/25 00:42:13 agriffis Exp $

IUSE=""

inherit kde

need-kde 3

DESCRIPTION="Kdenlive! (pronounced Kay-den-live) is a Non Linear Video Editing Suite for KDE."
HOMEPAGE="http://www.uchian.pwp.blueyonder.co.uk/kdenlive.html"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

IUSE="debug"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc"

DEPEND=">=media-video/piave-0.2.4
	>=kde-base/kdesdk-3.2"

