# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/e2fsprogs-libs/e2fsprogs-libs-1.41.4.ebuild,v 1.2 2009/03/15 05:01:39 vapier Exp $

EAPI="2"

inherit flag-o-matic toolchain-funcs

DESCRIPTION="e2fsprogs libraries (common error, subsystem, uuid, block id)"
HOMEPAGE="http://e2fsprogs.sourceforge.net/"
SRC_URI="mirror://sourceforge/e2fsprogs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="nls"

RDEPEND="elibc_glibc? ( >=sys-libs/glibc-2.6 )
	!sys-libs/com_err
	!sys-libs/ss
	!<sys-fs/e2fsprogs-1.41"
DEPEND="nls? ( sys-devel/gettext )
	sys-devel/bc"

set_env() {
	export LDCONFIG=/bin/true
	export CC=$(tc-getCC)
}

src_configure() {
	set_env

	# We want to use the "bsd" libraries while building on Darwin, but while
	# building on other Gentoo/*BSD we prefer elf-naming scheme.
	local libtype
	case ${CHOST} in
		*-darwin*) libtype=bsd;;
		*)         libtype=elf;;
	esac

	econf \
		--enable-${libtype}-shlibs \
		$(use_enable !elibc_uclibc tls) \
		$(use_enable nls) \
		|| die
}

src_compile() {
	set_env
	emake STRIP=/bin/true || die
}

src_install() {
	set_env
	emake STRIP=/bin/true DESTDIR="${D}" install || die

	dodir /$(get_libdir)
	local lib slib
	for lib in "${D}"/usr/$(get_libdir)/*.a ; do
		slib=${lib##*/}
		mv "${lib%.a}"$(get_libname)* "${D}"/$(get_libdir)/ || die "moving lib ${slib}"
		gen_usr_ldscript ${slib%.a}$(get_libname)
	done
}
