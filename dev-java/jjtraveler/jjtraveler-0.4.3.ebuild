# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jjtraveler/jjtraveler-0.4.3.ebuild,v 1.7 2005/07/16 09:35:50 axxo Exp $

inherit java-pkg

DESCRIPTION="A visitor combinator framework for Java"
HOMEPAGE="http://www.cwi.nl/htbin/sen1/twiki/bin/view/SEN1/ATermLibrary"
SRC_URI="http://www.cwi.nl/projects/MetaEnv/jjtraveler/JJTraveler-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc amd64"
IUSE=""
DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4"
S=${WORKDIR}/JJTraveler-${PV}

src_compile() {
	econf || die "Failed to configure"
	emake || die "Failed to make"

	(
		echo "#! /bin/sh"
		echo "java-config -p jjtraveler"
	) > jjtraveler-config
}

src_install() {
	java-pkg_newjar src/${P}.jar ${PN}.jar

	dobin jjtraveler-config

	dodoc AUTHORS COPYING INSTALL NEWS TODO ChangeLog
}
