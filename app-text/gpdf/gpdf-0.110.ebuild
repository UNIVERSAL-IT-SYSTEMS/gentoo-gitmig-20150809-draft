# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gpdf/gpdf-0.110.ebuild,v 1.9 2004/06/24 22:37:31 agriffis Exp $

inherit gnome2

DESCRIPTION="your favourite pdf previewer"
HOMEPAGE="http://www.gnome.org/"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc alpha sparc amd64"

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/libbonobo-2.2.1
	>=gnome-base/libbonoboui-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2
	>=gnome-base/libglade-2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS ChangeLog COPYING* MAINTAINERS TODO NEWS README"
