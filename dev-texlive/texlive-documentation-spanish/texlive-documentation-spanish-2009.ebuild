# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-spanish/texlive-documentation-spanish-2009.ebuild,v 1.2 2010/02/02 21:34:30 abcd Exp $

TEXLIVE_MODULE_CONTENTS="es-tex-faq l2tabu-spanish latexcheat-esmx lshort-spanish collection-documentation-spanish
"
TEXLIVE_MODULE_DOC_CONTENTS="es-tex-faq.doc l2tabu-spanish.doc latexcheat-esmx.doc lshort-spanish.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive Spanish documentation"

LICENSE="GPL-2 as-is LPPL-1.3 public-domain "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2009
"
RDEPEND="${DEPEND} "
