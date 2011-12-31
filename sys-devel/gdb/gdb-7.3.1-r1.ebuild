# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gdb/gdb-7.3.1-r1.ebuild,v 1.1 2011/12/31 09:43:19 vapier Exp $

EAPI="3"

inherit flag-o-matic eutils

export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} == ${CHOST} ]] ; then
	if [[ ${CATEGORY/cross-} != ${CATEGORY} ]] ; then
		export CTARGET=${CATEGORY/cross-}
	fi
fi
is_cross() { [[ ${CHOST} != ${CTARGET} ]] ; }

RPM=
MY_PV=${PV}
case ${PV} in
*.*.*.*.*.*)
	# fedora version: gdb-6.8.50.20090302-8.fc11.src.rpm
	inherit versionator rpm
	gvcr() { get_version_component_range "$@"; }
	MY_PV=$(gvcr 1-4)
	RPM="${PN}-${MY_PV}-$(gvcr 5).fc$(gvcr 6).src.rpm"
	SRC_URI="mirror://fedora/development/source/SRPMS/${RPM}"
	;;
*.*.50.*)
	# weekly snapshots
	SRC_URI="ftp://sources.redhat.com/pub/gdb/snapshots/current/gdb-weekly-${PV}.tar.bz2"
	;;
9999*)
	# live git tree
	EGIT_REPO_URI="git://sourceware.org/git/gdb.git"
	inherit git-2
	SRC_URI=""
	;;
*)
	# Normal upstream release
	SRC_URI="http://ftp.gnu.org/gnu/gdb/${P}.tar.bz2
		ftp://sources.redhat.com/pub/gdb/releases/${P}.tar.bz2"
	;;
esac

PATCH_VER="2"
DESCRIPTION="GNU debugger"
HOMEPAGE="http://sourceware.org/gdb/"
SRC_URI="${SRC_URI} ${PATCH_VER:+mirror://gentoo/${P}-patches-${PATCH_VER}.tar.xz}"

LICENSE="GPL-2 LGPL-2"
is_cross \
	&& SLOT="${CTARGET}" \
	|| SLOT="0"
if [[ ${PV} != 9999* ]] ; then
	KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~ppc-aix ~x86-fbsd ~amd64-linux ~x86-linux ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
fi
IUSE="+client expat multitarget nls +python +server test vanilla"

RDEPEND="!dev-util/gdbserver
	>=sys-libs/ncurses-5.2-r2
	sys-libs/readline
	expat? ( dev-libs/expat )
	python? ( =dev-lang/python-2* )"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	virtual/yacc
	test? ( dev-util/dejagnu )
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${PN}-${MY_PV}

src_prepare() {
	[[ -n ${RPM} ]] && rpm_spec_epatch "${WORKDIR}"/gdb.spec
	use vanilla || [[ -n ${PATCH_VER} ]] && EPATCH_SUFFIX="patch" epatch "${WORKDIR}"/patch
	strip-linguas -u bfd/po opcodes/po
}

gdb_branding() {
	printf "Gentoo ${PV} "
	if [[ -n ${PATCH_VER} ]] ; then
		printf "p${PATCH_VER}"
	else
		printf "vanilla"
	fi
}

src_configure() {
	strip-unsupported-flags

	local myconf=(
		--with-pkgversion="$(gdb_branding)"
		--with-bugurl='http://bugs.gentoo.org/'
		--disable-werror
		$(is_cross && echo --with-sysroot="${EPREFIX}"/usr/${CTARGET})
	)

	if use server ; then
		use client || cd gdb/gdbserver
		myconf+=( --program-transform-name='' )
	fi

	if use client ; then
		myconf+=(
			--enable-64-bit-bfd
			--disable-install-libbfd
			--disable-install-libiberty
			--with-system-readline
			--with-separate-debug-dir="${EPREFIX}"/usr/lib/debug
			$(use_with expat)
			$(use_enable nls)
			$(use multitarget && echo --enable-targets=all)
			$(use_with python python "${EPREFIX}/usr/bin/python2")
			$(use_enable server gdbserver)
		)
	fi

	econf "${myconf[@]}"
}

src_test() {
	emake check || ewarn "tests failed"
}

src_install() {
	use server && ! use client && cd gdb/gdbserver
	emake DESTDIR="${D}" install || die
	use client && { rm "${D}"/usr/lib*/libiberty.a || die ; }
	cd "${S}"

	# Don't install docs when building a cross-gdb
	if [[ ${CTARGET} != ${CHOST} ]] ; then
		rm -r "${ED}"/usr/share
		return 0
	fi
	# http://sourceware.org/ml/gdb-patches/2011-12/msg00915.html
	use server && { dobin gdb/gdbserver/gdbreplay || die ; }

	dodoc README
	if use client ; then
		docinto gdb
		dodoc gdb/CONTRIBUTE gdb/README gdb/MAINTAINERS \
			gdb/NEWS gdb/ChangeLog gdb/PROBLEMS
	fi
	docinto sim
	dodoc sim/{ChangeLog,MAINTAINERS,README-HACKING}
	if use server ; then
		docinto gdbserver
		dodoc gdb/gdbserver/{ChangeLog,README}
	fi

	if [[ -n ${PATCH_VER} ]] ; then
		dodoc "${WORKDIR}"/extra/gdbinit.sample
	fi

	# Remove shared info pages
	rm -f "${ED}"/usr/share/info/{annotate,bfd,configure,standards}.info*
}

pkg_postinst() {
	# portage sucks and doesnt unmerge files in /etc
	rm -vf "${ROOT}"/etc/skel/.gdbinit

	if use prefix && [[ ${CHOST} == *-darwin* ]] ; then
		ewarn "gdb is unable to get a mach task port when installed by Prefix"
		ewarn "Portage, unprivileged.  To make gdb fully functional you'll"
		ewarn "have to perform the following steps:"
		ewarn "  % sudo chgrp procmod ${EPREFIX}/usr/bin/gdb"
		ewarn "  % sudo chmod g+s ${EPREFIX}/usr/bin/gdb"
	fi
}
