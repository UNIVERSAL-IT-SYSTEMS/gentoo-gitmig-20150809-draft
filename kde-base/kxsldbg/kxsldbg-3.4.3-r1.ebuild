# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kxsldbg/kxsldbg-3.4.3-r1.ebuild,v 1.2 2005/12/06 21:49:48 hansmi Exp $
KMNAME=kdewebdev
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta flag-o-matic

DESCRIPTION="A KDE KPart Application for xsldbg, an XSLT debugger"
KEYWORDS="~alpha ~amd64 ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-libs/libxslt
	dev-libs/libxml2"

PATCHES="${FILESDIR}/kxsldbg-3.4.3-fmt-str.patch"