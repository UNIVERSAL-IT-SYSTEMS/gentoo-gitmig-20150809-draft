# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-2.4.25-r6.ebuild,v 1.2 2004/07/15 03:49:23 agriffis Exp $

ETYPE="sources"
inherit kernel-2
detect_version

KEYWORDS="x86 -ppc"
IUSE=""
UNIPATCH_LIST="
	${FILESDIR}/${PN}-2.4.CAN-2004-0109.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0133.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0177.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0178.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0181.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0394.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0427.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0495.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0497.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0535.patch
	${FILESDIR}/${PN}-2.4.FPULockup-53804.patch
	${DISTDIR}/${P}.patch.bz2"

DESCRIPTION="Full sources including the gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} http://dev.gentoo.org/~livewire/${P}.patch.bz2"
