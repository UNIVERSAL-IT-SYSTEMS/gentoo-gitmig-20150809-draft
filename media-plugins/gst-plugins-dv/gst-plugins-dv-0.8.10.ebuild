# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dv/gst-plugins-dv-0.8.10.ebuild,v 1.1 2005/07/01 17:59:27 zaheerm Exp $

inherit gst-plugins

KEYWORDS="~x86 ~ppc ~amd64"

GST_PLUGINS_BUILD="libdv"
DESCRIPTION="GStreamer plugin to decode DV"

IUSE=""
RDEPEND=">=media-libs/libdv-0.100"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
