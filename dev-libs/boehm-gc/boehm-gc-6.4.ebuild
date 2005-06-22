# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/boehm-gc/boehm-gc-6.4.ebuild,v 1.8 2005/06/22 16:42:53 gustavoz Exp $

MY_P=gc${PV/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="The Boehm-Demers-Weiser conservative garbage collector"
HOMEPAGE="http://www.hpl.hp.com/personal/Hans_Boehm/gc/"
SRC_URI="http://www.hpl.hp.com/personal/Hans_Boehm/gc/gc_source/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ~ppc-macos ppc64 sparc x86"
IUSE="c++"

RDEPEND="virtual/libc"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e '/^SUBDIRS/s/doc//' Makefile.in || die
}

src_compile() {
	econf \
		`use_enable c++ cplusplus` \
		--enable-threads=pthreads || die "Configure failed..."
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	# dist_noinst_HEADERS
	insinto /usr/include/gc
	doins include/{cord.h,ec.h,javaxfc.h}
	insinto /usr/include/gc/private
	doins include/private/*.h

	dodoc README.QUICK doc/README* doc/barrett_diagram
	dohtml doc/*.html
	newman doc/gc.man GC_malloc.1
}
