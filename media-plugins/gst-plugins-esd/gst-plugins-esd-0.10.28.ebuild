# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-esd/gst-plugins-esd-0.10.28.ebuild,v 1.5 2011/06/05 13:41:33 armin76 Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin to output sound to esound"
KEYWORDS="alpha amd64 arm ~hppa ia64 ~ppc ~ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

RDEPEND=">=media-sound/esound-0.2.12
	>=media-libs/gst-plugins-base-0.10.32"
DEPEND="${RDEPEND}"
