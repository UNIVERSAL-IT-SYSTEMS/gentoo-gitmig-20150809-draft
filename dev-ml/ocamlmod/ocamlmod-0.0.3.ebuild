# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamlmod/ocamlmod-0.0.3.ebuild,v 1.2 2012/07/09 21:06:43 ulm Exp $

EAPI=4

#OASIS_BUILD_TESTS=1

inherit oasis

DESCRIPTION="Generate OCaml modules from source files"
HOMEPAGE="http://forge.ocamlcore.org/projects/ocamlmod/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/856/${P}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
#	test? ( >=dev-ml/ounit-1.1.1 )"

DOCS=( "AUTHORS.txt" "README.txt" )
