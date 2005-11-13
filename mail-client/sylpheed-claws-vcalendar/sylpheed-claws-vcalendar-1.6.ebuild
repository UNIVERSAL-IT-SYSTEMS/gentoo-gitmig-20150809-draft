# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-vcalendar/sylpheed-claws-vcalendar-1.6.ebuild,v 1.3 2005/11/13 11:45:23 genone Exp $

MY_P="${P##sylpheed-claws-}"
MY_PN="${PN##sylpheed-claws-}"
SC_BASE="1.9.13"

DESCRIPTION="Plugin for sylpheed-claws to support the vCalendar meeting format"
HOMEPAGE="http://claws.sylpheed.org"
SRC_URI="mirror://sourceforge/sylpheed-claws/sylpheed-claws-plugins-${SC_BASE}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="|| ( ~mail-client/sylpheed-claws-${SC_BASE} =mail-client/sylpheed-claws-1.9.15 )"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README
}
