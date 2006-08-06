# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/mecab-perl/mecab-perl-0.92.ebuild,v 1.3 2006/08/06 02:49:43 mcummings Exp $

inherit perl-module

DESCRIPTION="MeCab library module for Perl."
HOMEPAGE="http://mecab.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/mecab/20898/${P}.tar.gz"

SLOT="0"
LICENSE="|| ( GPL-2 LGPL-2.1 BSD )"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=app-text/mecab-${PV}
	dev-lang/perl"
RDEPEND="${DEPEND}"

src_test() {
	perl test.pl  || die "test.pl failed"
	perl test2.pl || die "test2.pl failed"
}

src_install() {
	perl-module_src_install || die "perl-module_src_install failed"
	dohtml bindings.html    || die "dohtml failed"
	dodoc test.pl test2.pl  || die "dodoc test{,2}.pl failed"
}


