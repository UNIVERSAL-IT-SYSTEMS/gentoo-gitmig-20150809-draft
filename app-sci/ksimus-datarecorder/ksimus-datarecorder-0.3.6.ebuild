# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/ksimus-datarecorder/ksimus-datarecorder-0.3.6.ebuild,v 1.4 2004/06/24 22:06:20 agriffis Exp $

inherit kde-base

DESCRIPTION="The package Data Recorder contains some components which records data for KSimus."
HOMEPAGE="http://ksimus.berlios.de/"
KEYWORDS="x86"
SRC_URI="http://ksimus.berlios.de/download/ksimus-datarecorder-3-${PV}.tar.gz"

LICENSE="GPL-2"
IUSE=""
SLOT="0"

DEPEND="app-sci/ksimus"

need-kde 3
