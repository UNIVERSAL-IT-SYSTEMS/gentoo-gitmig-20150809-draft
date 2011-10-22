# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-kbdleds-plugin/xfce4-kbdleds-plugin-0.0.6.ebuild,v 1.1 2011/10/22 14:58:43 ssuominen Exp $

EAPI=4
inherit xfconf

DESCRIPTION="A panel plug-in to show state of Caps, Num and Scroll Lock keys"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-kbdleds-plugin"
SRC_URI="http://compas.com.ua/oco/file/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=xfce-base/libxfce4ui-4.8
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/xfce4-panel-4.8
	>=x11-libs/gtk+-2.20:2"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	XFCONF=( $(xfconf_use_debug) )
	DOCS=( AUTHORS README THANKS ) # ChangeLog NEWS TODO
}
