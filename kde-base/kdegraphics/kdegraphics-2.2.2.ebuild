# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics/kdegraphics-2.2.2.ebuild,v 1.2 2001/12/23 21:35:15 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-dist || die

DESCRIPTION="${DESCRIPTION}Graphics"

DEPEND="$DEPEND sys-devel/perl
	media-gfx/sane-backends
	tex? ( >=app-text/tetex-1.0.7 )"


newdepend "gphoto2? ( =media-gfx/gphoto-2.0_beta1 >=media-libs/libgpio-20010607 )"


src_compile() {

	kde_src_compile myconf

	use gphoto2 && myconf="$myconf --with-gphoto2-includes=/usr/include/gphoto2 --with-gphoto2-libraries=/usr/lib/gphoto2" || myconf="$myconf --without-kamera"
	use tex && myconf="$myconf --with-system-kpathsea --with-tex-datadir=/usr/share"
	kde_src_compile configure make

}


