# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/showconsole/showconsole-1.08.ebuild,v 1.3 2006/02/19 19:50:35 kumba Exp $

# This tarball is extracted from SuSe's sysvinit-2.86-#.src.rpm
# You can find said src rpm via opensuse.org:
# http://mirrors.kernel.org/opensuse/distribution/SL-OSS-*/inst-source/suse/src/

inherit eutils toolchain-funcs

DESCRIPTION="small daemon for logging console output during boot"
HOMEPAGE="http://www.novell.com/linux/suse/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${P}.tar.bz2
	cd "${S}"
	epatch "${FILESDIR}"/1.07-no-TIOCGDEV.patch
	epatch "${FILESDIR}"/${P}-quiet.patch
}

src_compile() {
	emake COPTS="${CFLAGS}" CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "install failed"
	insinto /$(get_libdir)/rcscripts/addons
	doins "${FILESDIR}"/bootlogger.sh || die "rcscript addon"
	rmdir "${D}"/usr/lib/lsb || die
	dodoc showconsole-*.lsm README
}
