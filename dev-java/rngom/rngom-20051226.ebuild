# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/rngom/rngom-20051226.ebuild,v 1.1 2007/05/01 18:41:46 nelchael Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="RNGOM is an open-source Java library for parsing RELAX NG grammars."
HOMEPAGE="https://rngom.dev.java.net/"
SRC_URI="https://rngom.dev.java.net/files/documents/1647/26424/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.5
	dev-java/relaxng-datatype
	dev-java/xsdlib
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.5"

src_unpack() {

	unpack ${A}

	cd "${S}"
	rm -v *.jar || die
	mkdir lib || die

	cd lib/
	java-pkg_jarfrom relaxng-datatype
	java-pkg_jarfrom xsdlib

	cp "${FILESDIR}/build.xml-${PV}" "${S}/build.xml" -i || die "cp failed"

}

src_install() {

	java-pkg_dojar rngom.jar

	use source && java-pkg_dosrc src/*
	use doc && java-pkg_dojavadoc javadoc/*

}
