# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/dot2tex/dot2tex-2.8.7.ebuild,v 1.7 2011/02/06 21:51:48 maekke Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="A Graphviz to LaTeX converter"
HOMEPAGE="http://www.fauskes.net/code/dot2tex/"
SRC_URI="http://dot2tex.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ~ppc64 x86 ~ppc-macos"
IUSE="doc examples"

DEPEND=""
RDEPEND=">=dev-python/pyparsing-1.4.8
	media-gfx/pydot
	media-gfx/graphviz"

DOCS="changelog.txt"

src_install() {
	distutils_src_install
	if use doc; then
		dohtml -r doc/*
		dodoc doc/usage.{txt,pdf}
	fi
	if use examples; then
		insinto "/usr/share/doc/${PF}/examples"
		doins examples/*
	fi
}
