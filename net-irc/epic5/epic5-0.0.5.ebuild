# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/epic5/epic5-0.0.5.ebuild,v 1.2 2005/07/08 06:51:43 dholm Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Epic5 IRC Client"
SRC_URI="ftp://ftp.epicsol.org/pub/epic/EPIC5-ALPHA/${P}.tar.bz2"
HOMEPAGE="http://epicsol.org/"
SLOT="0"
LICENSE="as-is"
KEYWORDS="~ppc ~x86"
IUSE="ipv6 perl ssl tcltk socks5"

DEPEND=">=sys-libs/ncurses-5.2
	perl? ( >=dev-lang/perl-5.6.1 )
	ssl? ( >=dev-libs/openssl-0.9.5 )
	tcltk? ( dev-lang/tcl )
	socks5? ( net-proxy/dante )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/epic-defaultserver.patch

	sed -i \
		-e 's:/include/tcl$ver:/include:' \
		-e 's:-lsocks5:-lsocks:' \
		configure
}

src_compile() {
	econf \
		--libexecdir=/usr/lib/misc \
		$(use_with ipv6) \
		$(use_with perl) \
		$(use_with ssl) \
		$(use_with tcltk tcl) \
		$(use_with socks5) \
		|| die "econf failed"
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install () {
	einstall \
		sharedir="${D}"/usr/share \
		libexecdir="${D}"/usr/lib/misc || die "einstall failed"

	dodoc BUG_FORM COPYRIGHT README KNOWNBUGS VOTES

	cd "${S}"/doc
	docinto doc
	dodoc \
		*.txt colors EPIC* IRCII_VERSIONS local_vars missing new-load \
		nicknames outputhelp SILLINESS TS4
}
