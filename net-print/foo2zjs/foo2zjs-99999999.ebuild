# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foo2zjs/foo2zjs-99999999.ebuild,v 1.5 2011/07/23 22:37:59 phajdan.jr Exp $

EAPI="4"

inherit eutils

DESCRIPTION="Support for printing to ZjStream-based printers"
HOMEPAGE="http://foo2zjs.rkkda.com/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="test"

RESTRICT="bindist"

RDEPEND="net-print/cups
	net-print/foomatic-db-engine
	net-print/foomatic-filters
	sys-fs/udev"
DEPEND="${RDEPEND}
	app-arch/unzip
	net-misc/wget
	sys-apps/ed
	sys-devel/bc
	test? ( sys-process/time )"

S="${WORKDIR}/${PN}"

src_unpack() {
	einfo "Fetching ${PN} tarball"
	wget "http://foo2zjs.rkkda.com/${PN}.tar.gz"
	tar zxf "${WORKDIR}/${PN}.tar.gz"

	cd "${S}"

	einfo "Fetching additional files (firmware, etc)"
	emake getweb

	# Display wget output, downloading takes some time.
	sed -e '/^WGETOPTS/s/-q//g' -i getweb

	./getweb all
}

src_prepare() {
	# Prevent an access violation.
	sed -e "s~/etc~${D}/etc~g" -i Makefile
	sed -e "s~/etc~${D}/etc~g" -i hplj1000

	# Prevent an access violation, do not create symlinks on live file system
	# during installation.
	sed -e 's/ install-filter / /g' -i Makefile
}

src_install() {
	# ppd files are installed automagically. We have to create a directory
	# for them.
	mkdir -p "${D}/usr/share/ppd"

	emake DESTDIR="${D}" -j1 install install-hotplug
}
