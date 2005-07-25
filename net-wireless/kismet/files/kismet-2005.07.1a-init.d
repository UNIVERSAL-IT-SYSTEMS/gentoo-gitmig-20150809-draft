#!/sbin/runscript
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kismet/files/kismet-2005.07.1a-init.d,v 1.1 2005/07/25 15:59:49 brix Exp $

checkconfig() {
	if [ ! -e /etc/kismet.conf ]; then
		eerror "Configuration file /etc/kismet.conf not found"
		return 1
	fi
}

start() {
	checkconfig || return 1

	ebegin "Starting kismet server"
	start-stop-daemon --start --quiet --pidfile /var/run/kismet_server.pid \
		--background --make-pidfile --exec /usr/bin/kismet_server \
		-- ${KISMET_SERVER_OPTIONS}
	eend ${?}
}

stop() {
	ebegin "Stopping kismet server"
	start-stop-daemon --stop --quiet --pidfile /var/run/kismet_server.pid
	eend ${?}
}
