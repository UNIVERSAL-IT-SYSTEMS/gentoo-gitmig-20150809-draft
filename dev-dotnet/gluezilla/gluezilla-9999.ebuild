# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gluezilla/gluezilla-9999.ebuild,v 1.1 2009/05/05 11:39:33 loki_val Exp $

EAPI=2

inherit go-mono mono

DESCRIPTION="A simple library to embed Gecko (xulrunner) in the Mono Winforms WebControl"
HOMEPAGE="http://mono-project.com/Gluezilla"

LICENSE="LGPL-2 MPL-1.1"
KEYWORDS="~x86 ~amd64 ~ppc"
SLOT="0"
IUSE=""

RDEPEND="net-libs/xulrunner:1.9
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}"
