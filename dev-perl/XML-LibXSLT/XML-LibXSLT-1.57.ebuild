# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-LibXSLT/XML-LibXSLT-1.57.ebuild,v 1.4 2005/01/04 14:16:49 mcummings Exp $

inherit perl-module

DESCRIPTION="A Perl module to parse XSL Transformational sheets using gnome's libXSLT"
SRC_URI="mirror://cpan/authors/id/M/MS/MSERGEANT/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~msergeant/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~alpha ~ppc ~sparc"
IUSE=""

SRC_TEST="do"

DEPEND="${DEPEND}
	>=dev-libs/libxslt-1.1.2
	>=dev-perl/XML-LibXML-1.58"
