# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice-data/koffice-data-2.1.2.ebuild,v 1.4 2011/01/28 09:38:16 tampakrap Exp $

EAPI="3"

KMNAME="koffice"
KMNOMODULE="true"
inherit kde4-meta

DESCRIPTION="Shared KOffice data files."

KEYWORDS="~ppc ~ppc64"
IUSE=""

DEPEND=">=media-libs/lcms-1.18:0"
RDEPEND="${DEPEND}"

KMEXTRA="pics/
	servicetypes/
	templates/"
KMEXTRACTONLY="
	doc/CMakeLists.txt
	doc/koffice.desktop"
