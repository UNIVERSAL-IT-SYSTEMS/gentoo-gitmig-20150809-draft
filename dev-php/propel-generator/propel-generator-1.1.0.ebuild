# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/propel-generator/propel-generator-1.1.0.ebuild,v 1.2 2005/09/07 05:38:58 sebastian Exp $

inherit php-pear

DESCRIPTION="Object Persistence Layer for PHP 5 (Generator)"
HOMEPAGE="http://propel.phpdb.org/wiki/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
SRC_URI="http://propel.phpdb.org/pear/propel_generator-${PV}.tgz"
RDEPEND=">=dev-lang/php-5.0.0
	dev-php/phing"
S="${WORKDIR}/propel_generator-${PV}"
