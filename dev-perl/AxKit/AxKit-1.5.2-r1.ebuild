# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/AxKit/AxKit-1.5.2-r1.ebuild,v 1.5 2002/07/27 18:27:15 aliz Exp $

inherit perl-module

S=${WORKDIR}/${PN}-1.52
DESCRIPTION="The Apache AxKit Perl Module"
SRC_URI="http://xml.sergeant.org/download/${P}.tar.gz"
HOMEPAGE="http://xml.sergeant.org/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86"

newdepend ">=dev-perl/libapreq-0.31 \
	>=dev-perl/Compress-Zlib-1.10 \
	>=dev-perl/Error-0.13 \
	>=dev-perl/HTTP-GHTTP-1.06 \
	>=dev-perl/Storable-1.0.7 \
	>=dev-perl/XML-XPath-1.04 \
	>=dev-perl/XML-XPath-1.04 \
	>=dev-perl/XML-LibXML-1.31 \
	>=dev-perl/XML-LibXSLT-1.31 \
	>=dev-perl/libapreq-1.0 \
	>=dev-perl/XML-Sablot-0.50"

src_unpack() {
  unpack ${A}
  cd ${S}
  cp Makefile.PL Makefile.PL.orig
  sed -e "s:0\.31_03:0.31:" Makefile.PL.orig > Makefile.PL
}

src_install () {
	
	perl-module_src_install
	
    diropts -o nobody -g nogroup
    dodir /var/cache/axkit
    dodir /home/httpd/htdocs/xslt
    insinto /etc/apache
    doins ${FILESDIR}/httpd.axkit

}
