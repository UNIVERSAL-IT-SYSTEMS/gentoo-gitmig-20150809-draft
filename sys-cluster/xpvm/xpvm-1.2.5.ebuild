# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/xpvm/xpvm-1.2.5.ebuild,v 1.4 2004/04/29 12:13:43 port001 Exp $

S=${WORKDIR}/${P}
DESCRIPTION="XPVM: A graphical console and monitor for PVM"
SRC_URI="http://www.netlib.org/pvm3/xpvm/XPVM.src.1.2.5.tgz"
HOMEPAGE="http://www.csm.ornl.gov/pvm/pvm_home.html"
IUSE=""

DEPEND=">=sys-cluster/pvm-3.4.1
	dev-lang/tcl
	dev-lang/tk"
RDEPEND=""

SLOT="0"
KEYWORDS="~x86"
LICENSE="LGPL-2"

src_unpack() {
	unpack ${A}
	patch -p0 <${FILESDIR}/xpvm-1.2.5-gentoo.diff || die
}

src_compile() {
	cd ${WORKDIR}/xpvm

	export PVM_ROOT="/opt/pvm3"
	export PVM_ARCH="LINUX"
	export XPVM_ROOT=${WORKDIR}"/xpvm"

	emake xpvm || die
}

src_install() {
	cd ${WORKDIR}/xpvm
	dodir ${PVM_ROOT}"/xpvm"
	dodir ${PVM_ROOT}"/bin/"${PVM_ARCH}
	dodir "/usr/bin"

	export XPVM_ROOT=${PVM_ROOT}"/xpvm"

	#create symlinks to xpvm binary
	dosym ${XPVM_ROOT}"/src/"${PVM_ARCH}"/xpvm" ${PVM_ROOT}"/bin/"${PVM_ARCH}"/xpvm"
	dosym ${XPVM_ROOT}"/src/"${PVM_ARCH}"/xpvm" "/usr/bin/xpvm"

	#install headers and libs and binary
	export PVM_ROOT=${D}"/opt/pvm3"
	cp ${WORKDIR}/xpvm ${PVM_ROOT} -r

	#environment variables:
	touch 97xpvm
	echo XPVM_ROOT=/opt/pvm3/xpvm/src >>97xpvm
	insinto /etc/env.d
	doins 97xpvm

	dodoc README
}

pkg_postinst() {
	ewarn "Environment Variables have changed. Do not forget to reboot or perform"
	ewarn "source /etc/profile before using xpvm !"
}

