# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/hamster-applet/hamster-applet-2.24.3.ebuild,v 1.4 2009/03/21 12:35:23 eva Exp $

EAPI="2"
GCONF_DEBUG="no"
SCROLLKEEPER_UPDATE="no"

inherit eutils gnome2 python

DESCRIPTION="Time tracking for the masses, in a GNOME applet"
HOMEPAGE="http://projecthamster.wordpress.com/"

# license on homepage is out-of-date, was changed to GPL-2 on 2008-04-16
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="eds"

RDEPEND="
	|| ( >=dev-lang/python-2.5[sqlite]
		 ( dev-lang/python:2.4
		   dev-python/pysqlite:2 ) )
	dev-python/gconf-python
	dev-python/libgnome-python
	dev-python/gnome-applets-python
	dev-python/dbus-python
	eds? ( dev-python/evolution-python )
	>=dev-python/pygobject-2.14
	>=dev-python/pygtk-2.12
	>=x11-libs/gtk+-2.12
	x11-libs/libXScrnSaver"

DEPEND="${RDEPEND}
	x11-proto/scrnsaverproto
	>=dev-util/intltool-0.37.1
	dev-util/pkgconfig
	sys-devel/gettext"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	# disable pyc compiling
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile
}

pkg_postinst() {
	gnome2_pkg_postinst

	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/hamster
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup /usr/$(get_libdir)/python*/site-packages/hamster
}
