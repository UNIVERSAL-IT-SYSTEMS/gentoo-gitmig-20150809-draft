# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/moosefs/moosefs-1.6.20.ebuild,v 1.1 2011/07/05 07:45:36 ultrabug Exp $

EAPI=4

inherit eutils

MY_P="mfs-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A filesystem for highly reliable petabyte storage"
HOMEPAGE="http://www.moosefs.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cgi +fuse static-libs"

RDEPEND="
	cgi? ( dev-lang/python )
	fuse? ( >=sys-fs/fuse-2.6 )"
DEPEND="${RDEPEND}"

pkg_setup() {
	enewgroup mfs
	enewuser mfs -1 -1 -1 mfs
}

src_prepare() {
	# rename dist config files
	sed -i 's@\.cfg\.dist@\.cfg@g' mfsdata/Makefile.in || die
}

src_configure() {
	local myopts=""
	use fuse || myopts="--disable-mfsmount"
	econf \
		--sysconfdir=/etc/mfs \
		--with-default-user=mfs \
		--with-default-group=mfs \
		$(use_enable cgi mfscgi) \
		$(use_enable cgi mfscgiserv) \
		$(use_enable static-libs static) \
		${myopts}
}

src_install() {
	emake DESTDIR="${D}" install

	newinitd "${FILESDIR}/mfs.initd" mfs
	newconfd "${FILESDIR}/mfs.confd" mfs

	chown -R mfs:mfs "${D}/var/lib/mfs" || die
	chmod 750 "${D}/var/lib/mfs" || die
}
