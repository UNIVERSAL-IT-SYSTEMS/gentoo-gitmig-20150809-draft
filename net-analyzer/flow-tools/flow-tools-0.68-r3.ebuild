# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/flow-tools/flow-tools-0.68-r3.ebuild,v 1.4 2006/09/09 22:48:11 wormo Exp $

inherit eutils flag-o-matic

DESCRIPTION="Flow-tools is a package for collecting and processing NetFlow data"
HOMEPAGE="http://www.splintered.net/sw/flow-tools/"
SRC_URI="ftp://ftp.eng.oar.net/pub/flow-tools/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="mysql postgres debug ssl"

RDEPEND="sys-apps/tcp-wrappers
	sys-libs/zlib
	sys-devel/flex
	!postgres? ( mysql? ( dev-db/mysql ) )
	!mysql? ( postgres? ( dev-db/postgresql ) )
	ssl? ( dev-libs/openssl )"

DEPEND="${RDEPEND}
	sys-devel/bison"

pkg_setup() {
	if use mysql && use postgres ; then
		echo
		eerror "The mysql and postgres USE flags are mutually exclusive."
		eerror "Please choose either USE=mysql or USE=postgres, but not both."
		die
	fi

	enewgroup flows
	enewuser flows -1 -1 /var/lib/flows flows
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-fix-configure.diff
	epatch "${FILESDIR}"/${P}-fix-a-zillion-warnings-updated.diff
	use debug || epatch ${FILESDIR}/${PN}-0.67-nodebug.patch
	epatch "${FILESDIR}"/${PN}-0.67-memleak.patch

	sed -i "s|^[^#]\(^.*CFLAGS=\).*$|\1-Wall|g" \
		configure.in src/Makefile.am lib/Makefile.am || die "sed CFLAGS failed"

	# bug 122842, we have /usr/bin/python and not /usr/local/bin/python
	sed -i -e "s:/usr/local/bin/python:/usr/bin/python:g" \
		"${S}"/bin/flow-{rptfmt,rpt2rrd,log2rrd}
}

src_compile() {
	einfo "Running autoreconf"
	autoreconf -f -i || die "autoreconf failed"

	use mysql && append-flags "-L/usr/lib/mysql -I/usr/include/mysql"
	use postgres && append-flags "-L/usr/lib/postgres -I/usr/include/postgres"

	econf \
		--localstatedir=/etc/flow-tools \
		--enable-lfs \
		$(use_with ssl openssl) \
		$(use_with mysql) \
		$(use_with postgres pgsql) \
		|| die "econf failed"

	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README SECURITY TODO

	keepdir /var/lib/flows
	keepdir /var/lib/flows/bin
	exeinto /var/lib/flows/bin
	doexe "${FILESDIR}"/linkme
	keepdir /var/run/flows

	newinitd "${FILESDIR}/flowcapture.initd" flowcapture
	newconfd "${FILESDIR}/flowcapture.confd" flowcapture

}

pkg_postinst() {
	chown flows:flows /var/run/flows
	chown flows:flows /var/lib/flows
	chown flows:flows /var/lib/flows/bin
	chmod 0755 /var/run/flows
	chmod 0755 /var/lib/flows
	chmod 0755 /var/lib/flows/bin
}
