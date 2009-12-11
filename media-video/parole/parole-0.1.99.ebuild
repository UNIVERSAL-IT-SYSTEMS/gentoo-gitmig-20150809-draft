# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/parole/parole-0.1.99.ebuild,v 1.1 2009/12/11 08:56:52 angelos Exp $

EAPI=2
inherit xfconf

DESCRIPTION="a simple media player based on the GStreamer framework for the Xfce4 desktop"
HOMEPAGE="http://goodies.xfce.org/projects/applications/parole/"
SRC_URI="mirror://xfce/src/apps/${PN}/0.1/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug libnotify nsplugin taglib"

RDEPEND=">=x11-libs/gtk+-2.16:2
	>=dev-libs/glib-2.16:2
	>=xfce-base/libxfce4util-4.6
	>=xfce-base/libxfcegui4-4.6
	>=dev-libs/dbus-glib-0.70
	>=media-libs/gstreamer-0.10.11
	>=media-libs/gst-plugins-base-0.10.11
	media-plugins/gst-plugins-meta
	libnotify? ( >=x11-libs/libnotify-0.4.1 )
	nsplugin? ( net-libs/xulrunner:1.9 )
	taglib? ( >=media-libs/taglib-1.4 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	x11-proto/xproto"

pkg_setup() {
	XFCONF="--disable-dependency-tracking
		$(use_enable libnotify)
		$(use_enable taglib)
		$(use_enable nsplugin browser-plugin)
		$(use_enable debug)"
	DOCS="AUTHORS ChangeLog README THANKS TODO"
}
