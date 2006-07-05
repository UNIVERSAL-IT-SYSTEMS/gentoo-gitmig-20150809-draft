# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk2-ex-formfactory/gtk2-ex-formfactory-0.62.ebuild,v 1.2 2006/07/05 17:31:36 ian Exp $

inherit perl-module

MY_P=Gtk2-Ex-FormFactory-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Gtk2 FormFactory"
HOMEPAGE="http://www.exit1.org/Gtk2-Ex-FormFactory/"
SRC_URI="mirror://cpan/modules/by-module/Gtk2/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-perl/gtk2-perl"
RDEPEND="${DEPEND}"
SRC_TEST="do"