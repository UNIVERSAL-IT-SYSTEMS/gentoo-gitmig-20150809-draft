# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.13.90.0.18-r1.ebuild,v 1.8 2003/09/06 08:09:19 msterret Exp $

IUSE="nls bootstrap build"

# NOTE to Maintainer:  ChangeLog states that it no longer use perl to build
#                      the manpages, but seems this is incorrect ....

inherit eutils libtool flag-o-matic

# Generate borked binaries.  Bug #6730
filter-flags "-fomit-frame-pointer -fssa"

S="${WORKDIR}/${P}"
DESCRIPTION="Tools necessary to build programs"
SRC_URI="mirror://kernel/linux/devel/binutils/${P}.tar.bz2
	mirror://kernel/linux/devel/binutils/test/${P}.tar.bz2
	mirror://gentoo/${PN}-2.13.90.0.18-20030206.patch.bz2"
HOMEPAGE="http://sources.redhat.com/binutils/"

SLOT="0"
LICENSE="GPL-2 | LGPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~mips ~hppa ~arm"

DEPEND="virtual/glibc
	>=sys-apps/portage-2.0.21
	nls? ( sys-devel/gettext )
	|| ( dev-lang/perl
	     ( !build?     ( dev-lang/perl ) )
	     ( !bootstrap? ( dev-lang/perl ) )
	    )"
# This is a hairy one.  Basically depend on dev-lang/perl
# if "build" or "bootstrap" not in USE.


# filter CFLAGS=".. -O2 .." on arm
if [ "${ARCH}" = "arm" ]; then
	CFLAGS="$(echo "${CFLAGS}" | sed -e 's,-O[2-9] ,-O1 ,')"
fi

src_unpack() {

	unpack ${A}

	cd ${S}
	# Various patches from Redhat/Mandrake...
	epatch ${DISTDIR}/${PN}-2.13.90.0.18-20030206.patch.bz2
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.10-glibc21.patch
	# Compilation fails on sparc because of this patch.
	# epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.18-sparc-nonpic.patch
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.10-ia64-brl.patch
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.18-eh-frame-ro.patch
	use x86 &> /dev/null \
		&& epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.16-array-sects-compat.patch
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.18-ltconfig-multilib.patch
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.18-searchdir.patch
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.18-libpath-suffix.patch
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.18-alpha-relax.patch
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.18-s390-noreladyn.patch
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.18-eh-frame-hdr.patch
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.18-compatsym.patch
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.18-ppc64-tls1.patch
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.18-ppc64-tls2.patch
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.18-s390-file-loc.patch
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.18-sub-same.patch
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.10-x86_64-gotpcrel.patch

	# Add patches for mips
	if [ "${ARCH}" = "mips" ]
	then
		cd ${S}
		chmod +x mips/README
		./mips/README
	fi
}

src_compile() {
	local myconf=""

	use nls && \
		myconf="${myconf} --without-included-gettext" || \
		myconf="${myconf} --disable-nls"

	# Fix /usr/lib/libbfd.la
	elibtoolize --portage

	./configure --enable-shared \
		--enable-64-bit-bfd \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--host=${CHOST} \
		${myconf} || die

	make configure-bfd || die
	make headers -C bfd || die
	emake tooldir="${ROOT}/usr/bin" \
		all || die

	if [ -z "`use build`" ]
	then
		if [ -z "`use bootstrap`" ]
		then
			# Nuke the manpages to recreate them (only use this if we have perl)
			find . -name '*.1' -exec rm -f {} \; || :
		fi
		# Make the info pages (makeinfo included with gcc is used)
		make info || die
	fi
}

src_install() {

	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	insinto /usr/include
	doins include/libiberty.h

	# c++filt is included with gcc -- what are these GNU people thinking?
	# but not the manpage, so leave that!
# We install it now, as gcc-3.3 do not have it any longer ...
#	rm -f ${D}/usr/bin/c++filt #${D}/usr/share/man/man1/c++filt*

	# By default strip has a symlink going from /usr/${CHOST}/bin/strip to
	# /usr/bin/strip we should reverse it:

	rm ${D}/usr/${CHOST}/bin/strip; mv ${D}/usr/bin/strip ${D}/usr/${CHOST}/bin/strip
	# The strip symlink gets created in the loop below

	# By default ar, as, ld, nm, ranlib and strip are in two places; create
	# symlinks.  This will reduce the size of the tbz2 significantly.  We also
	# move all the stuff in /usr/bin to /usr/${CHOST}/bin and create the
	# appropriate symlinks.  Things are cleaner that way.
	cd ${D}/usr/bin
	local x=""
	for x in * strip
	do
	if [ ! -e ../${CHOST}/bin/${x} ]
		then
			mv ${x} ../${CHOST}/bin/${x}
		else
			rm -f ${x}
		fi
		ln -s ../${CHOST}/bin/${x} ${x}
	done

	cd ${S}
	if [ -z "`use build`" ]
	then
		make prefix=${D}/usr \
			mandir=${D}/usr/share/man \
			infodir=${D}/usr/share/info \
			install-info || die

		dodoc COPYING* README
		docinto bfd
		dodoc bfd/ChangeLog* bfd/COPYING bfd/README bfd/PORTING bfd/TODO
		docinto binutils
		dodoc binutils/ChangeLog binutils/NEWS binutils/README
		docinto gas
		dodoc gas/ChangeLog* gas/CONTRIBUTORS gas/COPYING gas/NEWS gas/README*
		docinto gprof
		dodoc gprof/ChangeLog* gprof/TEST gprof/TODO
		docinto ld
		dodoc ld/ChangeLog* ld/README ld/NEWS ld/TODO
		docinto libiberty
		dodoc libiberty/ChangeLog* libiberty/COPYING.LIB libiberty/README
		docinto opcodes
		dodoc opcodes/ChangeLog*
		# Install pre-generated manpages .. currently we do not ...
	else
		rm -rf ${D}/usr/share/man
	fi
}

