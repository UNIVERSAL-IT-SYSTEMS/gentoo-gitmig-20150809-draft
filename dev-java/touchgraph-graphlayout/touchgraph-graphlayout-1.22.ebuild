# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/touchgraph-graphlayout/touchgraph-graphlayout-1.22.ebuild,v 1.3 2010/06/26 15:15:48 angelos Exp $

MY_PN="TGGraphLayout"
JAVA_PKG_IUSE="source"

inherit java-pkg-2

DESCRIPTION="TouchGraph provides a set of interfaces for graph visualization"
HOMEPAGE="http://touchgraph.sourceforge.net"
SRC_URI="mirror://sourceforge/touchgraph/TGGL_${PV//./}_jre11.zip"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${MY_PN}"

src_compile() {
	mkdir -p bin || die
	ejavac -d bin `find com -name "*.java" || die`
	`java-config -j` cvf ${MY_PN}.jar -C bin . || die
}

src_install() {
	java-pkg_newjar ${MY_PN}.jar
	dodoc "TGGL ReleaseNotes.txt" || die
	use source && java-pkg_dosrc com
}
