# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpwiki/phpwiki-1.2.4.ebuild,v 1.5 2005/07/05 22:25:55 stuart Exp $

inherit webapp

DESCRIPTION="PhpWiki is a WikiWikiWeb clone in PHP"
HOMEPAGE="http://phpwiki.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ppc"
IUSE=""

RDEPEND="virtual/php
		net-www/apache"

src_install() {
	webapp_src_preinst

	cp -a *.php admin images lib locale pgsrc templates \
		 "${D}/${MY_HTDOCSDIR}"

	dodoc DBLIB.txt CREDITS ChangeLog LICENSE README INSTALL.*
		UPGRADING.readme schemas/*

	webapp_serverowned ${MY_HTDOCSDIR}/lib/dbalib.php
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_src_install
}
