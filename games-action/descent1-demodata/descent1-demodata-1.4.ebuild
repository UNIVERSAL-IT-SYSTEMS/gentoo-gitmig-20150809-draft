# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/descent1-demodata/descent1-demodata-1.4.ebuild,v 1.2 2007/01/10 17:39:22 wolf31o2 Exp $

inherit eutils games

MY_PV=${PV/./}
DEMO="desc${MY_PV}sw.exe"

DESCRIPTION="Demo data files for Descent 1"
HOMEPAGE="http://en.wikipedia.org/wiki/Descent_%28computer_game%29"
SRC_URI="http://icculus.org/d2x/data/${DEMO}
	ftp://ftp.planetmirror.com/pub/3dgamers/games/descent/${DEMO}
	ftp://ftp.funet.fi/pub/msdos/games/interplay/${DEMO}"

# See readme.txt
LICENSE="free-noncomm"

SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND=""
DEPEND="app-arch/unzip
	app-arch/unarj"

S=${WORKDIR}

src_unpack() {
	unzip -qo "${DISTDIR}/${A}" || die "unzip failed"

	unarj e DESCENT1.SOW || die "unarj DESCENT1.SOW failed"
	mv descent.pig{,1}
	unarj e DESCENT2.SOW || die "unarj DESCENT2.SOW failed"
	mv descent.pig{,2}

	# From the sows, big porkie pies shall grow
	cat descent.pig{1,2} > descent.pig || die "cat descent.pig failed"

	rm *{1,2} *.{bat,exe,EXE,SOW,ubn}
}

src_install() {
	local dir=${GAMES_DATADIR}/d1x

	insinto "${dir}"
	doins descent.* || die "doins failed"

	dodoc *.txt

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	elog "A client is needed to run the game, e.g. d1x-rebirth."
	elog "Not all Descent 1 clients support the demo data."
	echo
}

