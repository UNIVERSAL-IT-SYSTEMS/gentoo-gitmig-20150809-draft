# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/parted/parted-1.6.6.ebuild,v 1.1 2003/07/28 04:40:05 lostlogic Exp $

IUSE="nls static readline"

S=${WORKDIR}/${P}
DESCRIPTION="Create, destroy, resize, check, copy partitions and file systems"
HOMEPAGE="http://www.gnu.org/software/parted"
SRC_URI="ftp://ftp.gnu.org/gnu/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc ~hppa"

inherit eutils

DEPEND=">=sys-apps/e2fsprogs-1.27
	>=sys-libs/ncurses-5.2
	nls? ( sys-devel/gettext )
	readline? ( >=sys-libs/readline-4.1-r4 )"

RDEPEND="${DEPEND}
	=dev-libs/progsreiserfs-0.3.0*"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/parted-${PV}-hfs-8.patch
	epatch ${FILESDIR}/parted-${PV}-gcc-3.3.patch
}

src_compile() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"
	use readline || myconf="${myconf} --without-readline"
	[ -z "${DEBUGBUILD}" ] && myconf="${myconf} --disable-debug"
	use static && myconf="${myconf} --enable-all-static"
	econf --target=${CHOST} ${myconf} || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	einstall || die "Install failed"
	dodoc ABOUT-NLS AUTHORS BUGS COPYING ChangeLog \
		INSTALL NEWS README THANKS TODO
	docinto doc; cd doc
	dodoc API COPYING.DOC FAQ FAT USER USER.jp
}
