# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/hcfpcimodem/hcfpcimodem-1.11.ebuild,v 1.1 2007/02/10 08:15:52 mrness Exp $

inherit eutils linux-info

#The document is the same as in hsfmodem, even if it has a different URL
MY_DOC="100498D_RM_HxF_Released.pdf"

DESCRIPTION="Linuxant's modem driver for Connexant HCF chipset"
HOMEPAGE="http://www.linuxant.com/drivers/hcf/index.php"
SRC_URI="http://www.linuxant.com/drivers/hcf/full/archive/${P}full/${P}full.tar.gz
	doc? ( http://www.linuxant.com/drivers/hcf/full/archive/${P}full/${MY_DOC} )"

LICENSE="Conexant"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE="doc"

DEPEND="dev-lang/perl
	app-arch/cpio"

S="${WORKDIR}/${P}full"

QA_EXECSTACK="usr/lib/hcfpcimodem/modules/imported/hcfblam-i386.O usr/lib/hcfpcimodem/modules/imported/hcfengine-i386.O"

pkg_setup() {
	linux-info_pkg_setup

	MOD_N="hcfpci"
	# Check to see if module is inserted into kernel, otherwise, build fails
	if [ "`lsmod | sed '/^'$MOD_N'serial/!d'`" ]; then
		eerror
		eerror "Module is in use by the kernel!!!"
		eerror "Attempting to unload..."
		eerror

		# Unloading module...
		${MOD_N}stop
		if [ "`lsmod | sed '/^'$MOD_N'serial/!d'`" ]; then
			eerror "Failed to unload modules from kernel!!!"
			eerror "Please manualy remove the module from the kernel and emerge again."
			eerror
			die
		fi
		einfo "Successfuly removed module from memory.  Resuming emerge."
		einfo
	fi
}

src_compile() {
	emake all || die "make failed"
}

pkg_preinst() {
	local NVMDIR="${ROOT}/etc/${PN}/nvm"
	if [ -d "${NVMDIR}" ]; then
		einfo "Cleaning ${NVMDIR}..."
		rm -rf "${NVMDIR}"
		eend
	fi
}

src_install () {
	make PREFIX="${D}/usr/" ROOT="${D}" install || die "make install failed"

	use doc && dodoc "${DISTDIR}/${MY_DOC}"
}

pkg_postinst() {
	einfo "To complete the installation and configuration of your HCF modem,"
	einfo "please run hcfpciconfig."
}

