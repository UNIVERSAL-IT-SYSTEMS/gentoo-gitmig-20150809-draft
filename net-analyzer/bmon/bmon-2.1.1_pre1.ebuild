# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/bmon/bmon-2.1.1_pre1.ebuild,v 1.4 2011/10/27 17:22:43 jer Exp $

EAPI="1"

inherit eutils toolchain-funcs

MY_PV="${PV/_pre/-pre}"
S="${WORKDIR}/${PN}-${MY_PV}"

DESCRIPTION="interface bandwidth monitor"
HOMEPAGE="http://people.suug.ch/~tgr/bmon/"
SRC_URI="http://people.suug.ch/~tgr/bmon/files/${PN}-${MY_PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="dbi rrdtool"

DEPEND=">=sys-libs/ncurses-5.3-r2
	dev-libs/libnl:1.1
	dbi? ( >=dev-db/libdbi-0.7.2-r1 )
	rrdtool? ( >=net-analyzer/rrdtool-1.2.6-r1 )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# gcc4 fix, bug 105343
	epatch "${FILESDIR}"/${PN}-2.1.0-gcc4.diff
	# Don't strip, bug #144370
	epatch "${FILESDIR}"/${PN}-2.1.0-nostrip.patch
	# libnl crap, bug 176378
	epatch "${FILESDIR}"/${PN}-2.1.0-libnl-1.0.patch
	# newer sysfs has symlinks for net class
	epatch "${FILESDIR}"/${PN}-2.1.0-sysfs-symlink.patch
}

src_compile() {
	econf \
		$(use_enable dbi) \
		$(use_enable rrdtool rrd) || die "econf failed"
	emake CPPFLAGS="${CXXFLAGS} -I${WORKDIR}/libnl-${NLVER}/include" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog
}
