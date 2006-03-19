# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/ikvm/ikvm-0.14.0.1.ebuild,v 1.3 2006/03/19 22:09:20 halcy0n Exp $

inherit mono

CLASSPATH_P="classpath-0.15"

DESCRIPTION="Java VM for .NET"
HOMEPAGE="http://www.ikvm.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip
		ftp://ftp.gnu.org/gnu/classpath/${CLASSPATH_P}.tar.gz"
LICENSE="as-is"

SLOT="0"
S=${WORKDIR}/${PN}
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-1.1"
DEPEND="${RDEPEND}
		!dev-dotnet/ikvm-bin
		>=dev-java/jikes-1.21
		>=dev-dotnet/nant-0.85_rc2
		app-arch/unzip"

src_compile() {
	nant || die "ikvm build failed"
}

src_install() {
	dodir /usr/bin
	for exe in ikvm ikvmc ikvmstub;
	do
		sed -e "s:EXE:${exe}:" \
			-e "s:P:${P}:" \
			${FILESDIR}/script-template \
			> ${D}/usr/bin/${exe}
		fperms +x /usr/bin/${exe}
	done

	insinto /usr/lib/${P}
	doins ${S}/bin/*
}
