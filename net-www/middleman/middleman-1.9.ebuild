# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/middleman/middleman-1.9.ebuild,v 1.2 2003/10/25 05:20:52 solar Exp $

inherit eutils

DESCRIPTION="Advanced HTTP/1.1 proxy server with features designed to increase privacy and remove unwanted content"
SRC_URI="mirror://sourceforge/middle-man/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/middle-man"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="${IUSE} pam zlib"

S=${WORKDIR}/${PN}

DEPEND="virtual/glibc
	dev-libs/libpcre
	 pam? (	sys-libs/pam )
	zlib? (	sys-libs/zlib )
"

src_unpack() {
	unpack ${A}
	[ -f ${FILESDIR}/${P}-gentoo.diff ] && epatch ${FILESDIR}/${P}-gentoo.diff
	cd ${S}
	if [ "$PV" = "1.9" ]; then
		einfo "Patching Makefile.in to avoid sanbox problems"
		sed -e s:"INSTALL) -d /var":"INSTALL) -d \$(DESTDIR)/var":g < Makefile.in > Makefile.out && mv Makefile.{out,in}
	fi
}

src_compile() {
	local myconf=""
	MAKEOPTS="-j1"

	cd ${S}
	for opt in ${IUSE}; do
		use ${opt} &&
			myconf="${myconf} --enable-${opt}" ||
			myconf="$myconf --disable-${opt}"
	done

	econf --sysconfdir=/etc/mman ${myconf} || die "econf failed: ${myconf}"
	emake || die "emake failed"
}

src_install() {
	cd ${S}
	# mkdir -p ${D}/usr/share/man/man8/
	make DESTDIR="${D}" install || die "einstall failed"

	dodoc CHANGELOG COPYING
	dohtml README.html

	insinto /etc/conf.d
	newins ${FILESDIR}/conf.d/mman mman
	exeinto /etc/init.d
	newexe ${FILESDIR}/init.d/mman mman
}

#pkg_preinst() {
#	enewgroup mman 8080
#	enewuser mman 8080
#}

pkg_postinst() {
	#einfo "A mman user has been added to your system if one did not already exist"
	einfo "-"
	einfo "Note: init/conf scripts and a sample config has been provided for you."
	einfo "They can be found at or in /etc/conf.d/mman /etc/init.d/mman /etc/mman/"
}
