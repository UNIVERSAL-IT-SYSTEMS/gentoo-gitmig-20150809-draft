# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jjtraveler/jjtraveler-0.4.3-r1.ebuild,v 1.4 2007/04/06 18:37:17 opfer Exp $

JAVA_PKG_IUSE="source doc"
WANT_AUTOMAKE="1.7"

inherit autotools java-pkg-2

DESCRIPTION="A visitor combinator framework for Java"
HOMEPAGE="http://www.cwi.nl/htbin/sen1/twiki/bin/view/SEN1/ATermLibrary"
MY_P=JJTraveler-${PV}
SRC_URI="http://www.cwi.nl/projects/MetaEnv/jjtraveler/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
S=${WORKDIR}/${MY_P}

DEPEND="
	>=virtual/jdk-1.4
	dev-java/junit"
RDEPEND=">=virtual/jre-1.4
	dev-java/junit"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/0.4.3-makefile.am.patch"
	eautomake

	(
		echo "#!/bin/sh"
		echo "java-config -p ${PN}"
	) > "${S}/jjtraveler-config"

	rm -v jars/*.jar || die
	cd jars
	java-pkg_jar-from junit
}

src_compile() {
	econf \
		--with-javac-flags="$(java-pkg_javac-args)"
	emake || die "emake failed"
	if use doc; then
		cd src/jjtraveler
		make htmljava.stamp || die "Failed to create javadoc"
	fi
}

src_install() {
	java-pkg_newjar ./src/${P}.jar

	dobin jjtraveler-config || die
	dodoc AUTHORS ChangeLog NEWS README TODO || die

	use source && java-pkg_dosrc src/jjtraveler
	use doc && java-pkg_dojavadoc src/jjtraveler/doc
}
