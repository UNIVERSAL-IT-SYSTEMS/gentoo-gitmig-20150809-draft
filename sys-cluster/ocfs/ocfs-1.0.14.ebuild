# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ocfs/ocfs-1.0.14.ebuild,v 1.2 2007/04/12 18:43:16 genstef Exp $

inherit linux-mod

DESCRIPTION="The Oracle Cluster Filesystem"
SRC_URI="http://oss.oracle.com/projects/ocfs/dist/files/source/${P}.tar.gz"
HOMEPAGE="http://oss.oracle.com/projects/ocfs"
LICENSE="GPL-2"

DEPEND="virtual/linux-sources"

IUSE="aio"
SLOT="0"
KEYWORDS="~x86"

pkg_setup() {
	if kernel_is 2 6; then
		die "${P} supports only 2.4 kernels"
	fi
}

src_compile() {
	local myconf
	use aio && myconf="--enable-aio=yes" || myconf="--enable-aio=no"

	econf \
		--with-kernel=${KV_DIR} \
		${myconf} \
		|| die

	emake || die
}

src_install() {
	einstall DESTDIR=${D} || die "Failed to install"

	dodir /etc/ocfs
	insinto /etc/ocfs
	doins ocfs2/ocfs.conf

	dodoc README docs/ocfs_doc.zip || die
}

pkg_postinst() {
	linux-mod_pkg_postinst

	einfo ""
	einfo "Please remember to re-emerge ${PN} when you upgrade your kernel!"
	einfo ""
	einfo "Please edit the configuration file /etc/ocfs/ocfs.conf"
	einfo ""
}
