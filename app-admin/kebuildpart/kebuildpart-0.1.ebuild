# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Maintainer: Yannick Koehler <ykoehler@hotmail.com>
# $Header: /var/cvsroot/gentoo-x86/app-admin/kebuildpart/kebuildpart-0.1.ebuild,v 1.1 2002/04/10 11:53:44 verwilst Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kde 3
SLOT="0"
DESCRIPTION="Graphical KDE emerge kpart"
SRC_URI="http://prdownloads.sourceforge.net/kemerge/${P}.tar.gz"
HOMEPAGE="http://${PN}.sourceforge.net/"
