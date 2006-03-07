# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/squeak/squeak-3.4.1-r1.ebuild,v 1.10 2006/03/07 11:21:17 araujo Exp $

inherit libtool flag-o-matic eutils

#Simply change these numbers for different versions
MV=3.4
NV=${MV}-1
FV=${MV}.1

DESCRIPTION="Highly-portable Smalltalk-80 implementation"
HOMEPAGE="http://www.squeak.org/"
SRC_URI="ftp://st.cs.uiuc.edu/Smalltalk/Squeak/${MV}/unix-linux/Squeak-${NV}.src.tar.gz"
LICENSE="Apple"
SLOT="0"
KEYWORDS="~x86"
IUSE="X oss mmx mozilla"
# a ffi flag would be nice

DEPEND="X? ( || ( ( x11-libs/libX11
	                x11-libs/libXext )
		 	virtual/x11 ) )"
RDEPEND="${DEPEND}
	virtual/squeak-image"

S="${WORKDIR}/Squeak-${NV}"


src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc33-string-fix.patch
}

src_compile() {
	local myconf=""

	use X || myconf="--without-x"
	use oss && myconf="${myconf} --with-audio=oss"
	use mmx && myconf="${myconf} --enable-mpg-mmx"

	strip-flags
	filter-mfpmath sse
	filter-flags "-fPIC" "-maltivec" "-mabi=altivec" "-fstack-protector" "-pipe" "-g" "-mtune" "-march" "-mcpu" "-O" "-O1" "-O2" "-Os" "-O3" "-freorder-blocks" "-fprefetch-loop-array"
	cd ${S}
	mkdir build
	cd build
	../platforms/unix/config/configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die "configure failed"
	mv Makefile Makefile.tmp.$$
	cat Makefile.tmp.$$|sed \
		's/$(prefix)\/doc\/squeak/$(prefix)\/share\/doc\/squeak-${FV}/g'\
		> Makefile
	rm -f Makefile.tmp.$$
	emake || die
	make npsqueak
	# this is a bit paranoid, but we want to be sure it gets compiled now
	cd nps
	emake || die
}

src_install() {
	cd ${S}/build

	make DESTDIR=${D} ROOT=${D} install || die

	exeinto /usr/bin
	doexe inisqueak

	### the rest is all for the plugin

	cd nps

	# plugin sample, must be served to work, file:// doesnt work.

	insinto /usr/share/doc/squeak-${FV}
	doins test/plugintest.html
	doins test/plugintest.sts

	# fix the paths

	SQ_DIR=/usr/lib/squeak
	VM_VERSION=${NV}
	NPSQUEAK_SO=${SQ_DIR}/${VM_VERSION}/npsqueak.so
	sed "s|@SQ_DIR@|${SQ_DIR}|;s|@VM_VERSION@|${VM_VERSION}|;s|@NPSQUEAK_SO@|${NPSQUEAK_SO}|" \
		npsqueakrun.in > npsqueakrun.in.2
	sed "s|@SQ_DIR@|${SQ_DIR}|;s|@VM_VERSION@|${VM_VERSION}|;s|@NPSQUEAK_SO@|${NPSQUEAK_SO}|" \
		npsqueakregister.in > npsqueakregister
	sed 's|^ensurefile|ensurefile "${HOME}/.npsqueak/SqueakPlugin.changes" "${SQ_DIR}/npsqueak.changes"\nensurefile|' npsqueakrun.in.2 > npsqueakrun

	exeinto /usr/lib/squeak
	doexe npsqueakregister
	exeinto /usr/lib/squeak/${NV}
	doexe npsqueakrun


	# install in browsers  (no opera use flags?)

	dodir /opt/netscape/plugins
	dosym /usr/lib/squeak/${NV}/npsqueak.so /opt/netscape/plugins

	if use mozilla ; then
		dodir /usr/lib/mozilla/plugins
		dosym /opt/netscape/plugins/npsqueak.so \
		/usr/lib/mozilla/plugins/npsqueak.so
	fi

	# maybe we should install the image here..

	# dosym /usr/lib/squeak/SqueakV3.sources /usr/lib/squeak/${NV}/SqueakV3.sources
	# doins npsqueak.image
	# doins npsqueak.changes
}

pkg_postinst() {
	einfo 'Run "inisqueak" to get a private copy of the VM image.'
	einfo ''
	einfo 'To setup the browser plugin, create a working set named npsqueak.* in /usr/lib/squeak/<version>/'
}
