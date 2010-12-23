# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-void/xf86-input-void-1.3.1.ebuild,v 1.3 2010/12/23 12:40:22 ssuominen Exp $

EAPI=3
inherit xorg-2

DESCRIPTION="null input driver"

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-base/xorg-server"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	x11-proto/randrproto
	x11-proto/xproto"
