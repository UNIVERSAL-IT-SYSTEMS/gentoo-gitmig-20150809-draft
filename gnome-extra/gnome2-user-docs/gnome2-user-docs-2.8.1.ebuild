# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome2-user-docs/gnome2-user-docs-2.8.1.ebuild,v 1.7 2005/01/22 06:44:11 vapier Exp $

inherit gnome2

DESCRIPTION="end user documentation"
HOMEPAGE="http://www.gnome.org"

LICENSE="FDL-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 ~mips"
IUSE=""

DEPEND=">=app-text/scrollkeeper-0.3.11"

DOCS="AUTHORS ChangeLog NEWS README"
