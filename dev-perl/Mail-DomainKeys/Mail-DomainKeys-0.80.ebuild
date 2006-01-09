# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-DomainKeys/Mail-DomainKeys-0.80.ebuild,v 1.2 2006/01/09 21:15:56 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="A perl implementation of DomainKeys"
HOMEPAGE="http://search.cpan.org/~anthonyu/${P}"
SRC_URI="mirror://cpan/authors/id/A/AN/ANTHONYU/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/Net-DNS
		dev-perl/MailTools
		dev-perl/Crypt-OpenSSL-RSA"

