# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmrproject/libmrproject-0.6.ebuild,v 1.4 2002/10/05 05:39:11 drobbins Exp $

IUSE="doc nls"


S=${WORKDIR}/${P}
DESCRIPTION="Project manager for Gnome2"
SRC_URI="ftp://ftp.codefactory.se/pub/software/mrproject/source/${P}.tar.gz"
HOMEPAGE="http://mrproject.codefactory.se/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
# sparc sparc64"

RDEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-libs/glib-2.0.3
	>=dev-libs/libxml2-2.4.19"

DEPEND="nls? ( sys-devel/gettext )
	doc? ( >=dev-util/gtk-doc-0.9-r2 )"

src_compile() {
	local myconf
	use doc \
		&& myconf="--enable-gtk-doc" \
		|| myconf="--disable-gtk-doc"

	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"

	econf \
		--disable-maintainer-mode \
		${myconf} || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeL* INSTALL NEWS  README* 
}
