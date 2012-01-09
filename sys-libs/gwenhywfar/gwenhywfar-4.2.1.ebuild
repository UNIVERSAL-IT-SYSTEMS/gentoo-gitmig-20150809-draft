# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gwenhywfar/gwenhywfar-4.2.1.ebuild,v 1.3 2012/01/09 21:41:27 ago Exp $

EAPI=2

DESCRIPTION="A multi-platform helper library for other libraries"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="http://www.aquamaniac.de/sites/download/download.php?package=01&release=63&file=01&dummy=${P}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc ~ppc64 ~sparc ~x86"
IUSE="debug doc fox gtk qt4"

RDEPEND="dev-libs/libgpg-error
	>=dev-libs/libgcrypt-1.2.0
	>=dev-libs/openssl-1.0.0
	>=net-libs/gnutls-2.0.1
	virtual/libiconv
	virtual/libintl
	fox? ( x11-libs/fox:1.6 )
	gtk? ( >=x11-libs/gtk+-2.17.5:2 )
	qt4? ( x11-libs/qt-gui:4 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	doc? ( app-doc/doxygen )"

# broken upstream, reported but got no reply
RESTRICT="test"

src_configure() {
	local guis
	use fox && guis="${guis} fox16"
	use gtk && guis="${guis} gtk2"
	use qt4 && guis="${guis} qt4"

	econf \
		--disable-dependency-tracking \
		--enable-ssl \
		--enable-visibility \
		$(use_enable debug) \
		$(use_enable doc full-doc) \
		--with-guis="${guis}" \
		--with-docpath=/usr/share/doc/${PF}/apidoc
}

src_compile() {
	emake || die

	if use doc; then
		emake srcdoc || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO

	if use doc; then
		emake DESTDIR="${D}" install-srcdoc || die
	fi

	find "${D}" -name '*.la' -exec rm -f '{}' +
}
