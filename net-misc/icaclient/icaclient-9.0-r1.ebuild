# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/icaclient/icaclient-9.0-r1.ebuild,v 1.1 2006/10/02 17:07:44 wolf31o2 Exp $

inherit eutils multilib rpm

DESCRIPTION="ICA Client"
HOMEPAGE="http://www.citrix.com/"
SRC_URI="http://download2.citrix.com/files/en/products/client/ica/current/ICAClient-9.0-1.i386.rpm"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch strip"

QA_TEXTRELS="opt/ICAClient/VDSCARD.DLL
	opt/ICAClient/TW1.DLL
	opt/ICAClient/NDS.DLL
	opt/ICAClient/CHARICONV.DLL
	opt/ICAClient/PDCRYPT1.DLL
	opt/ICAClient/VDCM.DLL
	opt/ICAClient/libctxssl.so
	opt/ICAClient/PDCRYPT2.DLL
	opt/ICAClient/npica.so"

RDEPEND="virtual/libc
	x86? (
		x11-libs/libXp
		x11-libs/libXaw
		x11-libs/libX11
		x11-libs/libSM
		x11-libs/libICE )
	>=x11-libs/openmotif-2.2.2
	amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.0 )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/usr"

pkg_setup() {
	# Binary x86 package
	has_multilib_profile && ABI="x86"
}

pkg_nofetch() {
	einfo "Please download ${A} yourself from www.citrix.com"
	einfo "http://www.citrix.com/English/SS/downloads/details.asp?dID=2755&downloadID=3323&pID=186"
	einfo "and place it in ${DISTDIR}"
}

src_unpack() {
	# You must download ICAClient-9.0-1.i386.rpm
	# from www.citrix.com and put it in ${DISTDIR}
	rpm_src_unpack
}

src_install() {
	dodir /opt/ICAClient

	insinto /opt/ICAClient/.config
	doins lib/ICAClient/.config/*

	insinto /opt/ICAClient
	doins lib/ICAClient/Npica* lib/ICAClient/*.DLL lib/ICAClient/Wfcmgr* \
		lib/ICAClient/Wfica* lib/ICAClient/eula.txt lib/ICAClient/npica.so \
		lib/ICAClient/readme.txt lib/ICAClient/libctxssl.so

	insinto /opt/ICAClient/cache
	doins lib/ICAClient/cache/*

	insinto /opt/ICAClient/config
	doins lib/ICAClient/config/* lib/ICAClient/config/.*

	insinto /opt/ICAClient/help
	doins lib/ICAClient/help/*

	insinto /opt/ICAClient/nls
	dosym en /opt/ICAClient/nls/C

	insinto /opt/ICAClient/nls/en
	doins lib/ICAClient/nls/en/*

	insinto /opt/ICAClient/icons
	doins lib/ICAClient/icons/*

	insinto /opt/ICAClient/keyboard
	doins lib/ICAClient/keyboard/*

	insinto /opt/ICAClient/keystore/cacerts
	doins lib/ICAClient/keystore/cacerts/*

	insinto /opt/ICAClient/util
	doins lib/ICAClient/util/{XCapture,XCapture.ad,echo_cmd,icalicense.sh,integrate.sh,nslaunch,pac.js,pacexec,xcapture}
	dosym /opt/ICAClient/util/integrate.sh /opt/ICAClient/util/disintegrate.sh

	exeinto /opt/ICAClient
	doexe lib/ICAClient/wfcmgr lib/ICAClient/wfcmgr.bin lib/ICAClient/wfica

	insinto /etc/env.d
	doins "${FILESDIR}"/10ICAClient

	insinto /usr/$(get_libdir)/nsbrowser/plugins
	dosym /opt/ICAClient/npica.so /usr/$(get_libdir)/nsbrowser/plugins/npica.so

	# The .desktop file included in the rpm links to /usr/lib, so we make a new
	# one.  The program gives errors and has slowdowns if the locale is not
	# English, so strip it since it has no translations anyway
	doicon lib/ICAClient/icons/*
	make_wrapper wfcmgr 'env LC_ALL="" LANG="" /opt/ICAClient/wfcmgr'
	make_desktop_entry wfcmgr 'Citrix ICA Client' citrix48.xpm
}
