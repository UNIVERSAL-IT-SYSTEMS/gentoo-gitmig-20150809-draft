# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtkhtml-sharp/gtkhtml-sharp-2.26.0.ebuild,v 1.2 2011/06/21 13:44:09 phajdan.jr Exp $

EAPI=2

GTK_SHARP_REQUIRED_VERSION="2.12"

inherit versionator gtk-sharp-module

SLOT="2"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RESTRICT="test"
