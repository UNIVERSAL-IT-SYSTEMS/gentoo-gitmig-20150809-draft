# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gpm/gpm-1.20.1-r1.ebuild,v 1.1 2005/01/30 11:43:39 vapier Exp $

inherit eutils toolchain-funcs

PATCH_VER="1.1"
DESCRIPTION="Console-based mouse driver"
HOMEPAGE="ftp://arcana.linux.it/pub/gpm/"
SRC_URI="ftp://arcana.linux.it/pub/gpm/${P}.tar.bz2
	mirror://gentoo/${P}-patches-${PATCH_VER}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="selinux"

DEPEND=">=sys-libs/ncurses-5.2"
RDEPEND="selinux? ( sec-policy/selinux-gpm )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/patch
}

src_compile() {
	econf --sysconfdir=/etc/gpm || die "econf failed"
	emake \
		CC=$(tc-getCC) \
		AR=$(tc-getAR) \
		RANLIB=$(tc-getRANLIB) \
		|| die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	insinto /etc/gpm
	doins conf/gpm-*.conf

	dodoc BUGS ChangeLog Changes README TODO
	dodoc doc/Announce doc/FAQ doc/README*

	newinitd "${FILESDIR}"/gpm.rc6 gpm
	newconfd "${FILESDIR}"/gpm.conf.d gpm
}
