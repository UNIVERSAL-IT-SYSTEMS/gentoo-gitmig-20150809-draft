# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-pam/pecl-pam-1.0.2-r1.ebuild,v 1.1 2010/11/04 15:33:56 mabi Exp $

EAPI=3

PHP_EXT_NAME="pam"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="README"

inherit php-ext-pecl-r2 pam

KEYWORDS="~amd64 ~x86"

DESCRIPTION="This extension provides PAM (Pluggable Authentication Modules) integration."
LICENSE="PHP-2.02"
SLOT="0"
IUSE="debug"

DEPEND="sys-libs/pam"
RDEPEND="${DEPEND}"

src_configure() {
	my_conf="--with-pam=/usr $(use_enable debug)"
	php-ext-source-r2_src_configure
}

src_install() {
	pamd_mimic_system php auth account password
	php-ext-pecl-r2_src_install
}
