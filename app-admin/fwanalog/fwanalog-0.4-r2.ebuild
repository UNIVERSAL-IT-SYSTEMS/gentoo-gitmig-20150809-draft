# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/fwanalog/fwanalog-0.4-r2.ebuild,v 1.16 2004/05/31 19:21:32 vapier Exp $

DESCRIPTION="Script to parse firewall logs and analyze them with Analog"
HOMEPAGE="http://tud.at/programm/fwanalog/"
SRC_URI="http://tud.at/programm/fwanalog/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND="" # this is just a bash script
RDEPEND="app-shells/bash
	sys-apps/grep
	sys-apps/gawk
	sys-apps/sed
	app-arch/gzip
	sys-apps/diffutils
	dev-lang/perl
	>=app-admin/analog-5.03"

src_install() {
	insinto /etc/fwanalog

	insopts -m0700 ; doins fwanalog.sh

	insopts -m0600
	doins fwanalog-dom.tab fwanalog.lng services.conf
	doins fwanalog.analog.conf fwanalog.analog.conf.local
	newins fwanalog.opts.linux24 fwanalog.opts

	dosed "s/\"zegrep\"/\"egrep\"/" /etc/fwanalog/fwanalog.opts

	dodoc CONTRIBUTORS ChangeLog README
	docinto support ; dodoc support/*
	docinto langfiles ; dodoc langfiles/*
}
