# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PatchReader/PatchReader-0.9.4.ebuild,v 1.2 2004/07/16 20:50:48 stuart Exp $

inherit perl-module

# this is a dependency for bugzilla

S=${WORKDIR}/${P}
DESCRIPTION="Module for reading diff-compatible patch files"
SRC_URI="http://www.cpan.org/modules/by-authors/id/J/JK/JKEISER/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/J/JK/JKEISER/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

DEPEND="dev-perl/File-Temp"
