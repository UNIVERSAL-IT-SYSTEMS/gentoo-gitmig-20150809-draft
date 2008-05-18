# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/atlantikdesigner/atlantikdesigner-3.5.9.ebuild,v 1.7 2008/05/18 21:23:21 maekke Exp $
KMNAME=kdeaddons
EAPI="1"
inherit kde-meta

DESCRIPTION="Atlantik gameboard designer"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=kde-base/atlantik-${PV}:${SLOT}"
