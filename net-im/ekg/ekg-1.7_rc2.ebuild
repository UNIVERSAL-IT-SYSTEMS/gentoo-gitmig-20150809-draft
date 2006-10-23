# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ekg/ekg-1.7_rc2.ebuild,v 1.1 2006/10/23 18:59:25 spock Exp $

inherit eutils autotools

IUSE="ssl ncurses readline zlib python spell threads gif jpeg"

DESCRIPTION="EKG (Eksperymentalny Klient Gadu-Gadu) - a text client for Polish instant messaging system Gadu-Gadu"
HOMEPAGE="http://ekg.chmurka.net/"
SRC_URI="http://ekg.chmurka.net/${P/_/}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"

S="${WORKDIR}/${P/_/}"

RDEPEND="net-libs/libgadu
	ssl? ( >=dev-libs/openssl-0.9.6 )
	ncurses? ( sys-libs/ncurses )
	readline? ( sys-libs/readline )
	zlib? ( sys-libs/zlib )
	python? ( dev-lang/python )
	spell? ( >=app-text/aspell-0.50.3 )
	gif? ( media-libs/giflib )
	jpeg? ( media-libs/jpeg )"

DEPEND=">=sys-devel/automake-1.7
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.6_rc3-libgadu.patch
	epatch ${FILESDIR}/${PN}-1.7_rc2-giflib.patch
	eautoreconf
}

src_compile() {
	local myconf="--enable-ioctld --disable-static --enable-dynamic"
	if use ncurses; then
		myconf="$myconf --enable-force-ncurses"
	else
		myconf="$myconf --disable-ui-ncurses"
	fi
	use readline	&& myconf="$myconf --enable-ui-readline"

	econf ${myconf} \
		`use_with python` \
		`use_with threads pthread` \
		`use_with jpeg libjpeg` \
		`use_with gif libgif` \
		`use_enable zlib` \
		`use_enable spell aspell` \
		`use_enable ssl openssl` \
	|| die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc docs/* docs/api/*
}
