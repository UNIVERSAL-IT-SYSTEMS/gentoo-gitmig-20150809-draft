# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libksba/libksba-1.0.3.ebuild,v 1.1 2008/02/12 19:04:55 alonbl Exp $

inherit eutils

DESCRIPTION="makes X.509 certificates and CMS easily accessible to applications"
HOMEPAGE="http://www.gnupg.org/related_software/libksba"
SRC_URI="mirror://gnupg/libksba/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-libs/libgpg-error-1.2
	dev-libs/libgcrypt"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO VERSION
}
