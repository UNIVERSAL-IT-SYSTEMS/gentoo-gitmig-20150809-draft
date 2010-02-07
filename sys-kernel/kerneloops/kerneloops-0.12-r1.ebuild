# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/kerneloops/kerneloops-0.12-r1.ebuild,v 1.1 2010/02/07 19:31:52 jlec Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Tool to automatically collect and submit Linux kernel crash signatures"
HOMEPAGE="http://www.kerneloops.org/"
SRC_URI="http://www.kerneloops.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-misc/curl
		sys-apps/dbus
		x11-libs/gtk+
		x11-libs/libnotify
		dev-util/desktop-file-utils"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-FLAGS.patch
}

src_compile() {
	emake \
		CC=$(tc-getCC) \
		kerneloops kerneloops-applet || die
}

src_install() {
	emake DESTDIR="${D}" install-system || die "Install of system failed"
	emake DESTDIR="${D}" install-kerneloops || die "Install of deamon failed"
	emake DESTDIR="${D}" install-applet || die "Install of applet failed"

	doinitd "${FILESDIR}"/kerneloops || die "doinitd failed"

	dosed 's:\(nodaemon\):\1 --file "${LOGFILE}":g' /etc/init.d/${PN}

	cat >> "${T}"/kerneloops <<- EOF
	# Change this according to your syslogger
	LOGFILE="/var/log/messages"
	EOF

	doconfd "${T}"/kerneloops
}

pkg_postinst() {
	ewarn "PRIVACY NOTE"
	ewarn "You must allow the kerneloops program to send the oops messages"
	ewarn "by either editing the /etc/kerneloops.conf file, or by running the"
	ewarn "kerneloops-applet program first."
	ewarn "Enabling this option will cause your system to submit certain kernel"
	ewarn "output to the kerneloops.org website, where it will be available via"
	ewarn "this website to developers and everyone else."
	ewarn "The submitted info are so-called \"oopses\", kernel crash signature."
	ewarn "However, due to the nature of oopses, it may happen that a few"
	ewarn "surrounding lines of the oops in the \"dmesg\" are being sent together"
	ewarn "with the oops."
}
