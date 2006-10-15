# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/gnbd/gnbd-1.03.00.ebuild,v 1.3 2006/10/15 14:03:27 xmerlin Exp $

MY_P="cluster-${PV}"

DESCRIPTION="GFS Network Block Devices"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=sys-cluster/magma-1.03.00
	>=sys-cluster/gnbd-headers-1.03.00
	<sys-fs/sysfsutils-2.0.0"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}/${PN}"

src_compile() {
	./configure || die "configure problem"
	emake || die "compile problem"
}

src_install() {
	emake DESTDIR=${D} install || die "install problem"

	newinitd ${FILESDIR}/${PN}-client.rc ${PN}-client || die
	newinitd ${FILESDIR}/${PN}-srv.rc ${PN}-srv || die

	doconfd ${FILESDIR}/${PN}-client.conf || die
	doconfd ${FILESDIR}/${PN}-srv.conf || die

	insinto /etc
	doins ${FILESDIR}/gnbdtab

	if $(has_version sys-fs/devfsd ) ; then
		insinto /etc/devfs.d/
		newins ${FILESDIR}/gnbd.devfs gnbd
	fi
}
