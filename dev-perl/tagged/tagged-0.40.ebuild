# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/tagged/tagged-0.40.ebuild,v 1.3 2004/10/14 19:53:58 dholm Exp $

inherit perl-module

DESCRIPTION="Modules for reading tags of MP3 audio files"
HOMEPAGE="http://www.cpan.org/~thogee/${P}/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/T/TH/THOGEE/${P}.tar.gz"
LICENSE="Artistic"
KEYWORDS="~x86 ~ppc"
SLOT="0"
IUSE=""

DEPEND="dev-perl/Compress-Zlib"
