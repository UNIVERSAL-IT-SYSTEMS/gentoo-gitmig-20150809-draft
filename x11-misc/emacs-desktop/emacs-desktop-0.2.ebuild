# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/emacs-desktop/emacs-desktop-0.2.ebuild,v 1.6 2007/04/19 13:43:20 kloeri Exp $

inherit eutils fdo-mime

DESCRIPTION="Desktop entry and icon for Emacs"
HOMEPAGE="http://bugs.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~sparc ~x86"
IUSE=""

src_install() {
	domenu emacs.desktop emacsclient.desktop
	doicon emacs.png
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
