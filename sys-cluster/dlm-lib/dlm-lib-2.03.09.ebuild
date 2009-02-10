# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/dlm-lib/dlm-lib-2.03.09.ebuild,v 1.4 2009/02/10 22:35:25 xmerlin Exp $

inherit eutils linux-mod linux-info versionator

CLUSTER_RELEASE="${PV}"
MY_P="cluster-${CLUSTER_RELEASE}"

MAJ_PV="$(get_major_version)"
MIN_PV="$(get_version_component_range 2).$(get_version_component_range 3)"

DESCRIPTION="General-purpose Distributed Lock Manager"
HOMEPAGE="http://sources.redhat.com/cluster/wiki/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=sys-kernel/linux-headers-2.6.24
	!sys-cluster/dlm-headers
	!sys-cluster/dlm-kernel
	"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}/${PN/-//}"

src_compile() {
	(cd "${WORKDIR}"/${MY_P};
		./configure \
			--cc=$(tc-getCC) \
			--cflags="-Wall" \
			--disable_kernel_check \
			--kernel_src=${KERNEL_DIR} \
			--somajor="$MAJ_PV" \
			--sominor="$MIN_PV" \
			--cmanlibdir=/usr/lib \
			--cmanincdir=/usr/include \
	) || die "configure problem"

	#emake clean || die "clean problem"
	emake -j1 || die "compile problem"
}

src_install() {
	emake DESTDIR="${D}" install || die "install problem"
}
