# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

COMPRESSTYPE=".lzma"
K_PREPATCHED="yes"
UNIPATCH_STRICTORDER="yes"
K_SECURITY_UNSUPPORTED="1"

RESTRICT="binchecks strip primaryuri mirror"

ETYPE="sources"
inherit kernel-2
detect_version
K_NOSETEXTRAVERSION="don't_set_it"

DESCRIPTION="The Zen Kernel v${KV_MAJOR}.${KV_MINOR}-${PR}"
HOMEPAGE="http://zen-kernel.org"
ZEN_URI="http://downloads.zen-kernel.org/$(get_version_component_range 1-3)/${KV_FULL}.patch${COMPRESSTYPE}"
SRC_URI="${KERNEL_URI} ${ZEN_URI}"

KEYWORDS="-* ~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

pkg_setup(){
	ewarn
	ewarn "${PN} is *not* supported by the Gentoo Kernel Project in any way."
	ewarn "If you need support, please contact the Zen developers directly."
	ewarn "Do *not* open bugs in Gentoo's bugzilla unless you have issues with"
	ewarn "the ebuilds. Thank you."
	ewarn
	ebeep 8
	kernel-2_pkg_setup
}

src_unpack(){
	kernel-2_src_unpack
	cd "${S}"
	epatch "${DISTDIR}"/${KV_FULL}.patch${COMPRESSTYPE}
}

K_EXTRAEINFO="For more info on zen-sources and details on how to report problems, see: \
${HOMEPAGE}. You may also visit #zen-sources on irc.rizon.net"
