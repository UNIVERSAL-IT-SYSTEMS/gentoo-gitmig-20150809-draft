# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk/asterisk-1.8.8.2.ebuild,v 1.2 2012/01/20 20:08:20 ago Exp $

EAPI=4
inherit autotools base eutils linux-info multilib

MY_P="${PN}-${PV/_/-}"

DESCRIPTION="Asterisk: A Modular Open Source PBX System"
HOMEPAGE="http://www.asterisk.org/"
SRC_URI="http://downloads.asterisk.org/pub/telephony/asterisk/${MY_P}.tar.gz
	 mirror://gentoo/gentoo-asterisk-patchset-1.7.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"

IUSE="ais alsa bluetooth calendar +caps curl dahdi debug doc freetds gtalk http iconv jabber jingle ldap lua mysql newt +samples odbc osplookup oss portaudio postgres radius snmp span speex sqlite sqlite3 srtp static syslog usb vorbis"

EPATCH_SUFFIX="patch"
PATCHES=( "${WORKDIR}/asterisk-patchset" )

RDEPEND="dev-libs/popt
	dev-libs/libxml2
	dev-libs/openssl
	ais? ( sys-cluster/openais )
	alsa? ( media-libs/alsa-lib )
	bluetooth? ( net-wireless/bluez )
	calendar? ( net-libs/neon
		 dev-libs/libical
		 dev-libs/iksemel )
	caps? ( sys-libs/libcap )
	curl? ( net-misc/curl )
	dahdi? ( >=net-libs/libpri-1.4.12_beta2
		net-misc/dahdi-tools )
	freetds? ( dev-db/freetds )
	gtalk? ( dev-libs/iksemel )
	http? ( dev-libs/gmime:2.4 )
	iconv? ( virtual/libiconv )
	jabber? ( dev-libs/iksemel )
	jingle? ( dev-libs/iksemel )
	ldap? ( net-nds/openldap )
	lua? ( dev-lang/lua )
	mysql? ( dev-db/mysql )
	newt? ( dev-libs/newt )
	odbc? ( dev-db/unixODBC )
	osplookup? ( net-libs/osptoolkit )
	portaudio? ( media-libs/portaudio )
	postgres? ( dev-db/postgresql-base )
	radius? ( net-dialup/radiusclient-ng )
	snmp? ( net-analyzer/net-snmp )
	span? ( media-libs/spandsp )
	speex? ( media-libs/speex )
	sqlite? ( dev-db/sqlite:0 )
	sqlite3? ( dev-db/sqlite:3 )
	srtp? ( net-libs/libsrtp )
	usb? ( dev-libs/libusb
		media-libs/alsa-lib )
	vorbis? ( media-libs/libvorbis )"

DEPEND="${RDEPEND}
	!net-libs/openh323"

RDEPEND="${RDEPEND}
	syslog? ( virtual/logger )"

PDEPEND="net-misc/asterisk-core-sounds
	net-misc/asterisk-extra-sounds
	net-misc/asterisk-moh-opsound"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	CONFIG_CHECK="~!NF_CONNTRACK_SIP"
	local WARNING_NF_CONNTRACK_SIP="SIP (NAT) connection tracking is enabled. Some users
	have reported that this module dropped critical SIP packets in their deployments. You
	may want to disable it if you see such problems."
	check_extra_config

	enewgroup asterisk
	enewgroup dialout 20
	enewuser asterisk -1 -1 /var/lib/asterisk "asterisk,dialout"
}

src_prepare() {
	base_src_prepare
	AT_M4DIR=autoconf eautoreconf
}

src_configure() {
	econf \
		--libdir="/usr/$(get_libdir)" \
		--localstatedir="/var" \
		--with-crypto \
		--with-gsm=internal \
		--with-popt \
		--with-ssl \
		--with-z \
		$(use_with caps cap) \
		$(use_with http gmime) \
		$(use_with newt) \
		$(use_with portaudio)

	# Blank out sounds/sounds.xml file to prevent
	# asterisk from installing sounds files (we pull them in via
	# asterisk-{core,extra}-sounds and asterisk-moh-opsound.
	>"${S}"/sounds/sounds.xml

	# Compile menuselect binary for optional components
	emake menuselect.makeopts

	# Broken functionality is forcibly disabled (bug #360143)
	menuselect/menuselect --disable chan_misdn menuselect.makeopts
	menuselect/menuselect --disable chan_ooh323 menuselect.makeopts

	# Utility set is forcibly enabled (bug #358001)
	menuselect/menuselect --enable smsq menuselect.makeopts
	menuselect/menuselect --enable streamplayer menuselect.makeopts
	menuselect/menuselect --enable aelparse menuselect.makeopts
	menuselect/menuselect --enable astman menuselect.makeopts

	# this is connected, otherwise it would not find
	# ast_pktccops_gate_alloc symbol
	menuselect/menuselect --enable chan_mgcp menuselect.makeopts
	menuselect/menuselect --enable res_pktccops menuselect.makeopts

	# SSL is forcibly enabled, IAX2 & DUNDI are expected to be available
	menuselect/menuselect --enable pbx_dundi menuselect.makeopts
	menuselect/menuselect --enable func_aes menuselect.makeopts
	menuselect/menuselect --enable chan_iax2 menuselect.makeopts

	# The others are based on USE-flag settings
	use_select() {
		local state=$(use "$1" && echo enable || echo disable)
		shift # remove use from parameters

		while [[ -n $1 ]]; do
			menuselect/menuselect --${state} "$1" menuselect.makeopts
			shift
		done
	}

	use_select ais			res_ais
	use_select alsa			chan_alsa
	use_select bluetooth	chan_mobile
	use_select calendar		res_calendar res_calendar_{caldav,ews,exchange,icalendar}
	use_select curl			func_curl res_config_curl res_curl
	use_select dahdi		app_dahdibarge app_dahdiras chan_dahdi codec_dahdi res_timing_dahdi
	use_select freetds		{cdr,cel}_tds
	use_select gtalk		chan_gtalk
	use_select http			res_http_post
	use_select iconv		func_iconv
	use_select jabber		res_jabber
	use_select jingle		chan_jingle
	use_select ldap			res_config_ldap
	use_select lua			pbx_lua
	use_select mysql		app_mysql cdr_mysql res_config_mysql
	use_select odbc			cdr_adaptive_odbc res_config_odbc {cdr,cel,res,func}_odbc
	use_select osplookup	app_osplookup
	use_select oss			chan_oss
	use_select postgres		{cdr,cel}_pgsql res_config_pgsql
	use_select radius		{cdr,cel}_radius
	use_select snmp			res_snmp
	use_select span			res_fax_spandsp
	use_select speex		{codec,func}_speex
	use_select sqlite		cdr_sqlite
	use_select sqlite3		{cdr,cel}_sqlite3_custom
	use_select srtp			res_srtp
	use_select syslog		cdr_syslog
	use_select usb			chan_usbradio
	use_select vorbis		format_ogg_vorbis
}

src_compile() {
	ASTLDFLAGS="${LDFLAGS}" emake
}

src_install() {
	mkdir -p "${D}"usr/$(get_libdir)/pkgconfig || die
	emake DESTDIR="${D}" installdirs
	emake DESTDIR="${D}" install

	if use radius; then
		insinto /etc/radiusclient-ng/
		doins contrib/dictionary.digium
	fi
	if use samples; then
		emake DESTDIR="${D}" samples
		for conffile in "${D}"etc/asterisk/*.*
		do
			chown asterisk:asterisk $conffile
			chmod 0660 $conffile
		done
		einfo "Sample files have been installed"
	else
		einfo "Skipping installation of sample files..."
		rm -f  "${D}"var/lib/asterisk/mohmp3/* || die
		rm -f  "${D}"var/lib/asterisk/sounds/demo-* || die
		rm -f  "${D}"var/lib/asterisk/agi-bin/* || die
		rm -f  "${D}"etc/asterisk/* || die
	fi
	rm -rf "${D}"var/spool/asterisk/voicemail/default || die

	# keep directories
	diropts -m 0770 -o asterisk -g asterisk
	keepdir	/etc/asterisk
	keepdir /var/lib/asterisk
	keepdir /var/run/asterisk
	keepdir /var/spool/asterisk
	keepdir /var/spool/asterisk/{system,tmp,meetme,monitor,dictate,voicemail}
	diropts -m 0750 -o asterisk -g asterisk
	keepdir /var/log/asterisk/{cdr-csv,cdr-custom}

	newinitd "${FILESDIR}"/1.8.0/asterisk.initd2 asterisk
	newconfd "${FILESDIR}"/1.8.0/asterisk.confd asterisk

	# install the upgrade documentation
	#
	dodoc README UPGRADE* BUGS CREDITS

	# install extra documentation
	#
	if use doc
	then
		dodoc doc/*.txt
		dodoc doc/*.pdf
	fi

	# install SIP scripts; bug #300832
	#
	dodoc "${FILESDIR}/1.6.2/sip_calc_auth"
	dodoc "${FILESDIR}/1.6.2/find_call_sip_trace.sh"
	dodoc "${FILESDIR}/1.6.2/find_call_ids.sh"
	dodoc "${FILESDIR}/1.6.2/call_data.txt"

	# install logrotate snippet; bug #329281
	#
	insinto /etc/logrotate.d
	newins "${FILESDIR}/1.6.2/asterisk.logrotate3" asterisk
}

pkg_postinst() {
	#
	# Announcements, warnings, reminders...
	#
	einfo "Asterisk has been installed"
	echo
	elog "If you want to know more about asterisk, visit these sites:"
	elog "http://www.asteriskdocs.org/"
	elog "http://www.voip-info.org/wiki-Asterisk"
	echo
	elog "http://www.automated.it/guidetoasterisk.htm"
	echo
	elog "Gentoo VoIP IRC Channel:"
	elog "#gentoo-voip @ irc.freenode.net"
	echo
	echo
	elog "1.6 -> 1.8 changes that you may care about:"
	elog "http://svn.asterisk.org/svn/${PN}/tags/${PV}/UPGRADE.txt"
	elog "or: bzless ${ROOT}usr/share/doc/${PF}/UPGRADE.txt.bz2"
}

pkg_config() {
	einfo "Do you want to reset file permissions and ownerships (y/N)?"

	read tmp
	tmp="$(echo $tmp | tr '[:upper:]' '[:lower:]')"

	if [[ "$tmp" = "y" ]] ||\
		[[ "$tmp" = "yes" ]]
	then
		einfo "Resetting permissions to defaults..."

		for x in spool run lib log; do
			chown -R asterisk:asterisk "${ROOT}"var/${x}/asterisk
			chmod -R u=rwX,g=rwX,o=    "${ROOT}"var/${x}/asterisk
		done

		chown -R root:asterisk  "${ROOT}"etc/asterisk
		chmod -R u=rwX,g=rwX,o= "${ROOT}"etc/asterisk

		einfo "done"
	else
		einfo "skipping"
	fi
}
