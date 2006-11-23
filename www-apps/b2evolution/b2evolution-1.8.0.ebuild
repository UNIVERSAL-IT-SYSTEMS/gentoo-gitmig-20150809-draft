# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/b2evolution/b2evolution-1.8.0.ebuild,v 1.3 2006/11/23 16:23:46 vivo Exp $

inherit webapp eutils

MY_EXT="-2006-07-09"

DESCRIPTION="Multilingual multiuser multi-blog engine"
HOMEPAGE="http://www.b2evolution.net"
SRC_URI="mirror://sourceforge/evocms/${P}${MY_EXT}.zip"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE=""
RDEPEND="virtual/httpd-php
	 virtual/mysql"

DEPEND="${DEPEND} ${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/${PN}"

pkg_setup() {
	webapp_pkg_setup
	has_php
	if [[ ${PHP_VERSION} == "4" ]]; then
		require_php_with_use expat
	else
		require_php_with_use xml
	fi
}

pkg_setup() {
	webapp_pkg_setup
	require_php_with_use tokenizer mysql
}

src_install() {
	webapp_src_preinst

	einfo "Installing main files"
	cp -r blogs/* ${D}${MY_HTDOCSDIR}
	einfo "Done"

	dodoc doc/license.txt doc/install_new.html doc/upgradefrom_b2evo.html doc/upgradefrom_b2.html \
		doc/upgradefrom_gl.html doc/upgradefrom_miniblog.html doc/upgradefrom_mt.html

	# Identify the configuration files that this app uses
	# User can want to make changes to these!
	webapp_serverowned ${MY_HTDOCSDIR}
	webapp_serverowned ${MY_HTDOCSDIR}/conf/_basic_config.php
	webapp_configfile ${MY_HTDOCSDIR}/conf/_{basic_config,advanced,locales,formatting,admin,stats,application}.php

	# post-install instructions
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	# now strut stuff
	webapp_src_install
}
