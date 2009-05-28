# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/dvd+rw-tools/dvd+rw-tools-7.1-r1.ebuild,v 1.7 2009/05/28 04:56:34 jer Exp $

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="A set of tools for DVD+RW/-RW drives"
HOMEPAGE="http://fy.chalmers.se/~appro/linux/DVD+RW/"
SRC_URI="http://fy.chalmers.se/~appro/linux/DVD+RW/tools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86"
IUSE=""

RDEPEND="virtual/cdrtools"
DEPEND="${RDEPEND}
	sys-devel/m4"

src_prepare() {
	# Linux compiler flags only include -O2 and are incremental
	sed -i '/FLAGS/s:-O2::' Makefile.m4

	# Fix compilation when DFORTIFY_SOURCE=2
	# https://bugs.gentoo.org/257360
	# https://bugzilla.redhat.com/show_bug.cgi?id=426068
	epatch "${FILESDIR}"/${PN}-7.0-wctomb.patch
	epatch "${FILESDIR}"/${PN}-7.0-glibc2.6.90.patch
	# Allow burning small images on dvd-dl media.
	# Patch snatched from Fedora, obviously correct.
	epatch "${FILESDIR}"/${PN}-7.0-dvddl.patch
	# Exit with non-zero status when child process does.
	# https://bugzilla.redhat.com/show_bug.cgi?id=243036
	epatch "${FILESDIR}"/${PN}-7.0-wexit.patch
}

src_compile() {
	emake SHELL=/bin/bash CC=$(tc-getCC) CXX=$(tc-getCXX) || die
}

src_install() {
	emake SHELL=/bin/bash prefix="${D}/usr" install || die
	dohtml index.html
}

pkg_postinst() {
	elog "When you run growisofs if you receive:"
	elog "unable to anonymously mmap 33554432: Resource temporarily unavailable"
	elog "error message please run 'ulimit -l unlimited'"
}
