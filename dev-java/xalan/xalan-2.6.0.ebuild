# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xalan/xalan-2.6.0.ebuild,v 1.7 2004/10/04 08:00:25 sejo Exp $

inherit java-pkg eutils

IUSE="doc"

MY_P=${PN}-j_${PV//./_}
S=${WORKDIR}/${MY_P}
DESCRIPTION="XSLT processor"
HOMEPAGE="http://xml.apache.org/xalan-j/index.html"
SRC_URI="mirror://apache/xml/xalan-j/source/${MY_P}-src.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ~amd64 ppc"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-core-1.5.2
	>=dev-java/xerces-2.6.0"
RDEPEND=">=virtual/jdk-1.3
	>=dev-java/xerces-2.6.0"

can_build_doc() {
	if [ `java-config --java-version 2>&1 | grep "1\.4\."  | wc -l` -lt 1 ]  ; then
		return 0
	else
		return 1
	fi
}

src_compile() {
	CLASSPATH=$CLASSPATH:`pwd`/bin/xercesImpl.jar:`pwd`/bin/bsf.jar:`pwd`/src\
	ant jar ${myc} || die "build failed"

	if use doc ; then
		if can_build_doc  ; then
			ant javadocs || die "Build Javadocs Failed"
		else
			einfo "                                                          "
			einfo " 1.4.x JDKs are unable to compile Javadocs at this time.  "
			einfo "                                                          "
		fi
	fi
}

src_install () {
	java-pkg_dojar build/*.jar
	dohtml readme.html

	if use doc ; then
		dodir /usr/share/doc/${P}
		dodoc TODO STATUS README LICENSE ISSUES
		dohtml -r build/docs/*
	fi
}

pkg_postinst() {
	if use doc && can_build_doc ; then
		einfo "                                                          "
		einfo " API Documentation is in /usr/share/doc/${PN}-${PV}.      "
		einfo "                                                          "
		einfo " Design documentation can be found online at:             "
		einfo "     http://xml.apache.org/xalan-j/design/design2_0_0.html"
		einfo "                                                          "
		epause 5
	else
		einfo "                                                          "
		einfo " Online Documentation:                                    "
		einfo "     http://xml.apache.org/xalan-j/design/design2_0_0.html"
		einfo "     http://xml.apache.org/xalan-j/apidocs/index.html     "
		einfo "                                                          "
		epause 5
	fi
}
