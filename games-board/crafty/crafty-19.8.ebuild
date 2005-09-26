# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/crafty/crafty-19.8.ebuild,v 1.8 2005/09/26 17:43:45 wolf31o2 Exp $

inherit eutils flag-o-matic games

DESCRIPTION="Bob Hyatt's strong chess engine"
HOMEPAGE="ftp://ftp.cis.uab.edu/pub/hyatt/"
SRC_URI="ftp://ftp.cis.uab.edu/pub/hyatt/v19/${P}.tar.gz"

LICENSE="crafty"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE="icc no-opts"

DEPEND="virtual/libc
	icc? ( >=dev-lang/icc-5.0 )"
RDEPEND="virtual/libc"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i '/-o crafty/s/CC/CXX/' Makefile
	epatch ${FILESDIR}/${PV}-ppc.patch #5932
}

src_compile() {
	local makeopts="target=LINUX"
	if ! use no-opts ; then
		if use icc ; then
			makeopts="${makeopts} CC=icc CXX=gcc asm=X86.o"
			append-flags -D_REENTRANT -tpp6 \
				-DCOMPACT_ATTACKS -DUSE_ATTACK_FUNCTIONS \
				-DUSE_ASSEMBLY_A -DUSE_ASSEMBLY_B -DFAST \
				-DSMP -DCPUS=4 -DCLONE -DDGT
			append-flags -O2 -fno-alias -fforce-mem \
				-fomit-frame-pointer -fno-gcse -mpreferred-stack-boundary=2
		else
			if [ "${CHOST}" == "i686-pc-linux-gnu" ] || [ "${CHOST}" == "i586-pc-linux-gnu" ] ; then
				append-flags -DCOMPACT_ATTACKS -DUSE_ATTACK_FUNCTIONS \
					-DUSE_ASSEMBLY_A -DUSE_ASSEMBLY_B \
					-DFAST -DSMP -DCPUS=4 -DCLONE -DDGT
				append-flags -fforce-mem -fno-gcse \
					-fomit-frame-pointer -mpreferred-stack-boundary=2
				makeopts="${makeopts} CC=gcc CXX=g++ asm=X86.o"
			else
				: # everything else :)
			fi
		fi
	fi
	append-flags -DPOSIX
	emake ${makeopts} crafty-make LDFLAGS="-lpthread" || die "build failed"
}

src_install() {
	dogamesbin crafty || die
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo
	einfo "Note: No books or tablebases have been installed. If you want them, just"
	einfo "      download them from ${HOMEPAGE}."
	einfo "      You will find documentation there too. In most cases you take now "
	einfo "      your xboard compatible application, (xboard, eboard, knights) and "
	einfo "      just play chess against computer opponent. Have fun."
	einfo
}
