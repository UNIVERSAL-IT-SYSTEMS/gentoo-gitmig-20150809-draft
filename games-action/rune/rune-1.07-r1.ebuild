# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/rune/rune-1.07-r1.ebuild,v 1.1 2005/11/22 01:46:02 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="Viking hack and slay game"
HOMEPAGE="http://www.runegame.com"
SRC_URI="mirror://gentoo/rune-all-0.1.tar.bz2
	http://dev.gentoo.org/~wolf31o2/sources/dump/rune-all-0.1.tar.bz2"

LICENSE="LOKI-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/x11
	!amd64? ( =media-libs/libsdl-1.2* )
	opengl? ( virtual/opengl )
	amd64? ( app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-compat
		app-emulation/emul-linux-x86-sdl )"

DEPEND=""

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
export CDROM_SET_NAMES=("Linux Rune CD" "Windows Rune CD")
	cdrom_get_cds System/rune.bin:System/Rune.exe
	games_pkg_setup
}

src_unpack() {
	dodir "${dir}"
	if [[ ${CDROM_SET} -eq 1 ]]
	then
		# unpack the data files
		tar xzf "${CDROM_ROOT}"/data.tar.gz || die "Could not unpack data.tar.gz"
	elif [[ ${CDROM_SET} -eq 2 ]]
	then
		# unpack the runelinuxfiles.tar.gz
		unpack ${A} || die "Could not unpack runelinuxfiles.tar.gz"
	fi
}

src_install() {
	insinto "${dir}"
	exeinto "${dir}"
	einfo "Copying files... this may take a while..."

	case ${CDROM_SET} in
	1)
		for x in Help Maps Meshes Sounds System Textures Web
		do
			doins -r $x || die "copying $x"
		done

		# copy linux specific files
		doins -r "${CDROM_ROOT}"/System \
			|| die "Could not copy Linux specific files"

		# the most important things: rune and ucc :)
		doexe "${CDROM_ROOT}"/bin/x86/rune \
			|| die "Could not install rune executable"
		fperms 750 ${dir}/System/{ucc{,-bin},rune-bin} \
			|| die "Could not make executables executable"

		# installing documentation/icon
		dodoc "${CDROM_ROOT}"/{README,CREDITS} || die "Could not dodoc README.linux"
		newicon "${CDROM_ROOT}"/icon.xpm rune.xpm || die "Could not copy pixmap"
	;;
	2)
		# copying Maps Sounds and Web
		for x in Maps Sounds Web
		do
			doins -r "${CDROM_ROOT}"/$x || die "copying $x"
		done

		# copying the texture files
		dodir ${dir}/Textures
		for x in $(find "${CDROM_ROOT}"/Textures/ -type f -printf '%f ')
		do
			echo -ne '\271\325\036\214' | cat - ${CDROM_ROOT}/Textures/$x \
				|sed -e '1 s/\(....\)..../\1/' > ${Ddir}/Textures/$x \
				|| die "modifying and copying $x"
		done

		doins -r ${S}/System || die "Could not copy Linux specific files"
		doins -r ${S}/Help || die "Could not copy Help data"
		doins -r ${S}/patch/* || die "Could not copy Patch data"

		insinto ${dir}/System

		# copying system files from the Windows CD
		for x in "${CDROM_ROOT}"/System/*.{int,u,url}; do
			doins $x || die "copying $x"
		done

		# modify the files
		mv ${Ddir}/System/OpenGlDrv.int ${Ddir}/System/OpenGLDrv.int \
			|| die "Could not modify System file OpenGlDrv.int"
		mv ${Ddir}/Textures/bloodFX.utx ${Ddir}/Textures/BloodFX.utx \
			|| die "Could not modify Texture file bloodFX.utx"
		mv ${Ddir}/Textures/RUNESTONES.UTX ${Ddir}/Textures/RUNESTONES.utx \
			|| die "Could not modify Texture file RUNESTONES.UTX"
		mv ${Ddir}/Textures/tedd.utx ${Ddir}/Textures/Tedd.utx \
			|| die "Could not modify Texture file tedd.utx"
		mv ${Ddir}/Textures/UNDERANCIENT.utx ${Ddir}/Textures/UnderAncient.utx \
			|| die "Could not modify Texture file UNDERANCIENT.utx"
		rm ${Ddir}/System/{Setup.int,SGLDrv.int,MeTaLDrv.int,Manifest.int,D3DDrv.int,Galaxy.int,SoftDrv.int,WinDrv.int,Window.int} || die "Could not delete not needed System files"

		# the most important things: rune and ucc :)
		doexe ${S}/bin/x86/rune || die "Could not install rune executable"
		fperms 750 ${dir}/System/{ucc,ucc-bin,rune-bin} \
			|| die "Could not make executables executable"

		# installing documentation/icon
		dodoc "${S}"/{README,CREDITS} || die "Could not dodoc README.linux"
		doicon "${S}"/rune.xpm rune.xpm || die "Could not copy pixmap"
	;;
	esac

	use amd64 && mv ${Ddir}/System/libSDL-1.2.so.0 \
		${Ddir}/System/libSDL-1.2.so.0.backup

	games_make_wrapper rune ./rune "${dir}" "${dir}"
	make_desktop_entry rune "Rune" rune.xpm "Game;ActionGame"
	find ${Ddir} -exec touch '{}' \;
	prepgamesdirs
}
