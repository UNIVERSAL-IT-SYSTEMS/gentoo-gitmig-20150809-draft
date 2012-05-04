# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/gtk-g-rays2/gtk-g-rays2-1.23.ebuild,v 1.2 2012/05/04 07:14:06 jdhore Exp $

EAPI=4

DESCRIPTION="GUI for accessing the Wintec WBT 201 / G-Rays 2 GPS device"
HOMEPAGE="http://www.daria.co.uk/gps"
SRC_URI="http://www.zen35309.zen.co.uk/gps/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="
	gnome-base/libglade:2.0
	x11-libs/gtk+:2
	x11-libs/cairo"
DEPEND="${DEPEND}
	virtual/pkgconfig
	sys-devel/gettext
	doc? ( dev-libs/libxslt )"

DOCS=( README AUTHORS ChangeLog docs/gtkGrays2.pdf )
