# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/rarian/rarian-0.8.1.ebuild,v 1.7 2008/11/12 21:49:49 ranger Exp $

inherit eutils gnome2

DESCRIPTION="A documentation metadata library"
HOMEPAGE="http://www.freedesktop.org"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ppc ppc64 sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-libs/libxslt"
DEPEND="${RDEPEND}
	!<app-text/scrollkeeper-9999"

DOCS="ChangeLog NEWS README"

GCONF=""

src_unpack() {
	# You cannot run src_unpack from gnome2; it will break the install by
	# calling gnome2_omf_fix
	unpack ${A}
	cd "${S}"

	# remove unneeded line, bug #240564
	sed "s/ (foreign dist-bzip2 dist-gzip)//" -i configure || die "sed failed"

	elibtoolize ${ELTCONF}
}

src_compile() {
	gnome2_src_compile --localstatedir=/var
}
