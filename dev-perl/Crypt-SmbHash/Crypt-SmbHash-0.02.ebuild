# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-SmbHash/Crypt-SmbHash-0.02.ebuild,v 1.11 2004/09/06 16:55:33 pvdabeel Exp $

inherit perl-module

AUTHOR="BJKUIT"
BASE_URI="http://www.cpan.org/modules/by-authors/id/${AUTHOR:0:1}/${AUTHOR:0:2}/${AUTHOR}"
DESCRIPTION="LM/NT hashing, for Samba's smbpasswd entries"
SRC_URI="${BASE_URI}/${P}.tar.gz"
HOMEPAGE="${BASE_URI}/${P}.readme"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc mips arm ~alpha amd64 ppc"
IUSE=""

DEPEND="dev-perl/Digest-MD4"
