# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/evince-python/evince-python-2.32.0.ebuild,v 1.3 2011/02/24 18:43:56 tomka Exp $

EAPI="3"
GCONF_DEBUG="no"
G_PY_PN="gnome-python-desktop"

inherit gnome-python-common

DESCRIPTION="Python bindings for the libwnck library"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=app-text/evince-2.32
	!<dev-python/gnome-python-desktop-2.22.0-r10"
DEPEND="${RDEPEND}"
