# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/kth-krb/kth-krb-1.2.2-r2.ebuild,v 1.10 2006/01/13 11:23:25 vapier Exp $

inherit eutils

DESCRIPTION="Kerberos 4 implementation from KTH"
HOMEPAGE="http://www.pdc.kth.se/kth-krb/"
SRC_URI="ftp://ftp.pdc.kth.se/pub/krb/src/krb4-${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc s390 sh sparc x86"
IUSE="ssl afs"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6b )
	afs? ( >=net-fs/openafs-1.2.2-r7 )
	sys-devel/autoconf"

S=${WORKDIR}/krb4-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/kth-gentoo.patch
	epatch "${FILESDIR}"/kth-gentoo-ssl.patch
	epatch "${FILESDIR}"/${P}-berkdb.patch
	epatch "${FILESDIR}"/${P}-fPIC.patch
	epatch "${FILESDIR}"/${P}-no_libedit.patch
	epatch "${FILESDIR}"/${P}-gcc.patch

	libtoolize --copy --force || die
	autoreconf || die
}

src_compile() {
	use ssl && myconf="${myconf} --with-openssl=/usr"
	use afs || myconf="${myconf} --without-afs-support"

	econf \
		--prefix=/usr/athena \
		${myconf} || die

	make || die
}

src_install() {
	make DESTDIR="${D}" sysconfdir=${D}/etc install || die

	# Doesn't get install otherwise (for some reason, look into this).
	if use ssl ; then
		cd ${S}/lib/des

		make DESTDIR=${D}/usr/athena \
	 		install || die

		cd ${S}
	fi

	doenvd "${FILESDIR}"/02kth-krb

	dodoc ChangeLog README NEWS PROBLEMS TODO

	# rphillips: cludge to fix the paths
	einfo "Fixing /usr/athena/lib library paths"
	cd ${D}/usr/athena/lib
	sed -i 's:${D}/::g' *.la
}
