# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/netlogo-bin/netlogo-bin-4.0.4.ebuild,v 1.2 2009/12/22 23:58:23 caster Exp $

inherit eutils java-pkg-2
#RESTRICT="fetch"
MY_PN="netlogo"
MY_P=${MY_PN}-${PV}
DESCRIPTION="NetLogo cross-platform multi-agent programmable modeling environment"

HOMEPAGE="http://ccl.northwestern.edu/netlogo/"
SRC_URI="http://ccl.northwestern.edu/netlogo/${PV}/${MY_P}.tar.gz"
LICENSE="netlogo"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND=""
RDEPEND=">=virtual/jre-1.5"

IUSE=""

S=${WORKDIR}/${MY_P}

src_install() {
	java-pkg_dojar *.jar
	java-pkg_dojar extensions/sound/*.jar
	java-pkg_dojar extensions/profiler/*.jar
	java-pkg_dojar extensions/array/*.jar
	java-pkg_dojar extensions/gogo/*.jar
	java-pkg_dojar extensions/sample/*.jar
	java-pkg_dojar extensions/table/*.jar
	java-pkg_dojar extensions/gis/*.jar
	java-pkg_dojar lib/*.jar

	dohtml -r docs/*
	insinto /usr/share/"${PN}"/models
	doins -r models/*

	insinto /usr/share/pixmaps
	doins  "${FILESDIR}"/netlogo.gif

	exeinto /opt/bin
	newexe "${FILESDIR}"/netlogo.sh netlogo

	make_desktop_entry netlogo "NetLogo" /usr/share/pixmaps/netlogo.gif

	#3D Libs right now only for x86
	insinto /usr/share/"${PN}"/lib
	doins lib/*.so
}
