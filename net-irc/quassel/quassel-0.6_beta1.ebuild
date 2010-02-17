# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/quassel/quassel-0.6_beta1.ebuild,v 1.1 2010/02/17 20:25:37 billie Exp $

EAPI="2"

MY_P="${P/_/-}"

inherit cmake-utils eutils

DESCRIPTION="Qt4/KDE4 IRC client suppporting a remote daemon for 24/7 connectivity."
HOMEPAGE="http://quassel-irc.org/"
SRC_URI="http://quassel-irc.org/pub/${MY_P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
SLOT="0"
IUSE="ayatana dbus debug kde monolithic phonon postgres +server +ssl webkit +X"

SERVER_RDEPEND="
	!postgres? ( x11-libs/qt-sql:4[sqlite] dev-db/sqlite[threadsafe] )
	postgres? ( x11-libs/qt-sql:4[postgres] )
	x11-libs/qt-script:4
"

GUI_RDEPEND="
	x11-libs/qt-gui:4
	ayatana? ( dev-libs/libindicate-qt )
	kde? (
		>=kde-base/kdelibs-4.3
		ayatana? ( kde-misc/plasma-indicatordisplay )
	)
	phonon? ( || ( media-sound/phonon x11-libs/qt-phonon ) )
	webkit? ( x11-libs/qt-webkit:4 )
"

RDEPEND="
	dbus? ( x11-libs/qt-dbus:4 )
	monolithic? (
		${SERVER_RDEPEND}
		${GUI_RDEPEND}
	)
	!monolithic? (
		server? ( ${SERVER_RDEPEND} )
		X? ( ${GUI_RDEPEND} )
	)
	ssl? ( x11-libs/qt-core:4[ssl] )
	"
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog README"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if ! use monolithic && ! use server && ! use X ; then
		eerror "You have to build at least one of the monolithic client (USE=monolithic),"
		eerror "the quasselclient (USE=X) or the quasselcore (USE=server)."
		die "monolithic, server and X flag unset."
	fi
}

src_configure() {
	local mycmakeargs="
		$(cmake-utils_use_with ayatana LIBINDICATE)
		$(cmake-utils_use_want X QTCLIENT)
		$(cmake-utils_use_want server CORE)
		$(cmake-utils_use_want monolithic MONO)
		$(cmake-utils_use_with webkit)
		$(cmake-utils_use_with phonon)
		$(cmake-utils_use_with kde)
		$(cmake-utils_use_with dbus)
		$(cmake-utils_use_with ssl OPENSSL)
		$(cmake-utils_use_with !kde OXYGEN)
		-DEMBED_DATA=OFF
	"

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	if use server ; then
		newinitd "${FILESDIR}"/quasselcore-2.init quasselcore || die "newinitd failed"
		newconfd "${FILESDIR}"/quasselcore-2.conf quasselcore || die "newconfd failed"

		insinto /etc/logrotate.d
		newins "${FILESDIR}/quassel.logrotate" quassel
	fi
}

pkg_postinst() {
	if use server ; then
		ewarn
		ewarn "In order to use the quassel init script you must set the"
		ewarn "QUASSEL_USER variable in ${ROOT%/}/etc/conf.d/quasselcore to your username."
		ewarn "Note: This is the user who runs the quasselcore and is independent"
		ewarn "from the users you set up in the quasselclient."
	fi

	if ( use server || use monolithic ) && use ssl ; then
		elog
		elog "Information on how to enable SSL support for client/core connections"
		elog "is available at http://bugs.quassel-irc.org/wiki/quassel-irc."
	fi
}
