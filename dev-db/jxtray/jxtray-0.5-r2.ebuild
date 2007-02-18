# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/jxtray/jxtray-0.5-r2.ebuild,v 1.7 2007/02/18 10:27:31 nixnut Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Java based Database Explorer"
HOMEPAGE="http://jxtray.sourceforge.net"
SRC_URI="mirror://sourceforge/jxtray/${PN}-src-${PV}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~ppc64 x86"
IUSE="doc firebird mssql mysql postgres"

RDEPEND="|| ( =virtual/jre-1.4* =virtual/jre-1.5* )
	=dev-java/jdom-1.0_beta9*
	>=dev-java/kunststoff-2.0.2
	dev-java/poi
	dev-java/sax
	>=dev-java/xerces-2.7
	dev-java/xml-commons
	firebird? ( dev-java/jdbc-jaybird )
	mssql? ( =dev-java/jtds-0.9* )
	mysql? ( dev-java/jdbc-mysql )
	postgres? ( dev-java/jdbc-postgresql )
	!firebird? ( !mssql? ( !postgres? ( dev-java/jdbc-mysql ) ) )"
DEPEND="|| ( =virtual/jdk-1.4* =virtual/jdk-1.5* )
	${RDEPEND}
	dev-java/ant-core"

S="${WORKDIR}/${PN}-src-${PV}"

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/build.xml ${FILESDIR}/default.properties ${S}
	local cp=""

	cd ${S}/lib
	rm *.jar
	cp="${cp}:$(java-pkg_getjars jdom-1.0_beta9)"
	cp="${cp}:$(java-pkg_getjars xerces-2)"
	cp="${cp}:$(java-pkg_getjars xml-commons)"
	cp="${cp}:$(java-pkg_getjars sax)"
	cp="${cp}:$(java-pkg_getjars poi)"

	cd ${S}/lib/lookandfeel
	rm *.jar
	cp="${cp}:$(java-pkg_getjars kunststoff-2.0)"

	cd ${S}/lib/drivers
	rm *.jar
	use firebird && cp="${cp}:$(java-pkg_getjars jdbc-jaybird)"
	use mssql && cp="${cp}:$(java-pkg_getjars jtds-0.9)"
	use mysql && cp="${cp}:$(java-pkg_getjars jdbc-mysql)"
	use postgres && cp="${cp}:$(java-pkg_getjars jdbc-postgresql)"

	echo "classpath=${cp}" > ${S}/build.properties
}

src_compile() {
	eant jar $(use_doc javadoc)
}

src_install() {
	java-pkg_newjar ${S}/dist/${P}.jar ${PN}.jar

	java-pkg_dolauncher jxtray --main jxtray.Jxtray

	dodoc CHANGELOG.txt README.txt
	use doc && java-pkg_dojavadoc -r ${S}/javadoc
}
