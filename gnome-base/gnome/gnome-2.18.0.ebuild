# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome/gnome-2.18.0.ebuild,v 1.3 2007/04/23 17:07:17 dang Exp $

DESCRIPTION="Meta package for the GNOME desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="as-is"
SLOT="2.0"

# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="accessibility cdr cups dvdr hal ldap"

S=${WORKDIR}

RDEPEND="!gnome-base/gnome-core

	>=dev-libs/glib-2.12.11
	>=x11-libs/gtk+-2.10.10
	>=dev-libs/atk-1.18.0
	>=x11-libs/pango-1.16.1

	>=dev-libs/libxml2-2.6.27
	>=dev-libs/libxslt-1.1.20

	>=media-libs/audiofile-0.2.6-r1
	>=media-sound/esound-0.2.37
	>=x11-libs/libxklavier-3.0
	>=media-libs/libart_lgpl-2.3.19

	>=dev-libs/libIDL-0.8.8
	>=gnome-base/orbit-2.14.7

	>=x11-libs/libwnck-2.18.0
	>=x11-wm/metacity-2.18.0

	>=gnome-base/gnome-keyring-0.8
	>=gnome-extra/gnome-keyring-manager-2.17.0

	>=gnome-base/gnome-vfs-2.18.0.1

	>=gnome-base/gnome-mime-data-2.4.3

	>=gnome-base/gconf-2.18.0.1
	>=net-libs/libsoup-2.2.100

	>=gnome-base/libbonobo-2.18.0
	>=gnome-base/libbonoboui-2.18.0
	>=gnome-base/libgnome-2.18.0
	>=gnome-base/libgnomeui-2.18.1
	>=gnome-base/libgnomecanvas-2.14.0
	>=gnome-base/libglade-2.6.0

	>=gnome-extra/bug-buddy-2.17.4
	>=gnome-base/control-center-2.18.0

	>=gnome-base/eel-2.18.0.1
	>=gnome-base/nautilus-2.18.0.1

	>=media-libs/gstreamer-0.10.8
	>=media-libs/gst-plugins-base-0.10.7
	>=media-libs/gst-plugins-good-0.10.3
	>=gnome-extra/gnome-media-2.18.0
	>=media-sound/sound-juicer-2.16.3
	>=media-video/totem-2.18.0

	>=media-gfx/eog-2.18.0.1

	>=www-client/epiphany-2.18.0
	>=app-arch/file-roller-2.18.0
	>=gnome-extra/gcalctool-5.9.14

	>=gnome-extra/gconf-editor-2.17.0
	>=gnome-base/gdm-2.18.0
	>=x11-libs/gtksourceview-1.8.5
	>=app-editors/gedit-2.18.0

	>=app-text/evince-0.8.0

	>=gnome-base/gnome-desktop-2.18.0
	>=gnome-base/gnome-session-2.18.0
	>=gnome-base/gnome-applets-2.18.0
	>=gnome-base/gnome-panel-2.18.0
	>=gnome-base/gnome-menus-2.18.0
	>=x11-themes/gnome-icon-theme-2.18.0
	>=x11-themes/gnome-themes-2.18.0
	>=gnome-extra/deskbar-applet-2.17.93

	>=x11-themes/gtk-engines-2.10.0
	>=x11-themes/gnome-backgrounds-2.16.2

	>=x11-libs/vte-0.16.0
	>=x11-terms/gnome-terminal-2.18.0

	>=gnome-extra/gucharmap-1.10.0
	>=gnome-base/libgnomeprint-2.17.92
	>=gnome-base/libgnomeprintui-2.18.0

	>=gnome-extra/gnome-utils-2.18.0

	>=gnome-extra/gnome-games-2.18.0
	>=gnome-base/librsvg-2.16.1

	>=gnome-extra/gnome-system-monitor-2.16.1
	>=gnome-base/libgtop-2.14.8

	>=x11-libs/startup-notification-0.8

	>=gnome-extra/gnome2-user-docs-2.16.1
	>=gnome-extra/yelp-2.18.0
	>=gnome-extra/zenity-2.18.0

	>=net-analyzer/gnome-netstatus-2.12.1
	>=net-analyzer/gnome-nettool-2.17.4

	cdr? ( >=gnome-extra/nautilus-cd-burner-2.18.0 )
	dvdr? ( >=gnome-extra/nautilus-cd-burner-2.18.0 )

	hal? ( >=gnome-base/gnome-volume-manager-2.17.0 )

	>=gnome-extra/gtkhtml-3.14.0
	>=mail-client/evolution-2.10.0
	>=gnome-extra/evolution-data-server-1.10.0
	>=gnome-extra/evolution-webcal-2.9.92

	>=net-misc/vino-2.18.0

	>=app-admin/gnome-system-tools-2.14.0
	>=app-admin/system-tools-backends-1.4.2
	>=gnome-extra/fast-user-switch-applet-2.17.4

	>=app-admin/pessulus-2.16.2
	ldap? (
		>=app-admin/sabayon-2.18.0
		>=net-im/ekiga-2.0.7
		)

	>=gnome-extra/gnome-screensaver-2.18.0
	>=x11-misc/alacarte-0.11.3
	>=gnome-extra/gnome-power-manager-2.18.0

	accessibility? (
		>=gnome-extra/libgail-gnome-1.18.0
		>=gnome-base/gail-1.18.0
		>=gnome-extra/at-spi-1.18.0
		>=app-accessibility/dasher-4.4.0
		>=app-accessibility/gnome-mag-0.14.3
		>=app-accessibility/gnome-speech-0.4.10
		>=app-accessibility/gok-1.2.3
		>=app-accessibility/orca-2.18 )
	cups? ( >=net-print/gnome-cups-manager-0.31-r2 )"

#	mono? ( >=app-misc/tomboy-0.4.1 )

# Development tools
#   scrollkeeper
#   pkgconfig
#   intltool
#   gtk-doc
#   gnome-doc-utils


pkg_postinst() {

	elog "Note that to change windowmanager to metacity do: "
	elog " export WINDOW_MANAGER=\"/usr/bin/metacity\""
	elog "of course this works for all other window managers as well"
	elog
	elog "To take full advantage of GNOME's functionality, please emerge"
	elog "gamin, a File Alteration Monitor."
	elog "Make sure you have inotify enabled in your kernel ( >=2.6.13 )"
	elog
	elog "Make sure you rc-update del famd and emerge unmerge fam if you"
	elog "are switching from fam to gamin."
	elog
	elog "If you have problems, you may want to try using fam instead."
	elog
	elog
	elog "Add yourself to the plugdev group if you want"
	elog "automounting to work."
	elog
}
