# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/Cheetah-docs/Cheetah-docs-0.9.15_alpha1.ebuild,v 1.5 2003/09/29 22:47:55 mr_bones_ Exp $

DESCRIPTION="Documentation for Cheetah templates."
HOMEPAGE="http://www.cheetahtemplate.org/"
LICENSE="PSF-2.2"

KEYWORDS="x86"
SLOT="0"

DEPEND=""

SRC_URI="mirror://sourceforge/cheetahtemplate/CheetahDocs-${PV/_alpha/a}.tgz"
S=${WORKDIR}/CheetahDocs

src_compile() {

	true

}

src_install() {

	dodoc *.ps *.pdf *.txt TODO
	dohtml -r devel_guide_html devel_guide_html_multipage
	dohtml -r users_guide_html users_guide_html_multipage
	dohtml OnePageTutorial.html

	# Install the source code.
	local srcdir=/usr/lib/Cheetah-docs
	dodir ${srcdir}
	mv devel_guide_src users_guide_src ${D}${srcdir}/

}
