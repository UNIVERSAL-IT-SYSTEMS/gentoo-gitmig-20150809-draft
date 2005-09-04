# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/php4_4-sapi.eclass,v 1.1 2005/09/04 10:54:53 stuart Exp $
#
# ########################################################################
#
# eclass/php4_4-sapi.eclass
#               Eclass for building different php4 SAPI instances
#
#				USE THIS ECLASS FOR THE "CONCENTRATED" PACKAGES
#
#               Based on robbat2's work on the php4 sapi eclass
#
# Author(s)		Stuart Herbert
#				<stuart@gentoo.org>
#
#				CHTEKK
#				<chtekk@longitekk.org>
#
# ========================================================================

CONFUTILS_MISSING_DEPS="adabas birdstep db2 dbmaker empress empress-bcs esoob frontbase hyperwave-api informix interbase msql oci8 oracle7 ovrimos pfpro sapdb solid sybase sybase-ct"
EBUILD_SUPPORTS_SHAREDEXT=1

inherit flag-o-matic eutils confutils libtool php-common-r1

# set MY_PHP_P in the ebuild

# we only set these variables if we're building a copy of php which can be
# installed as a package in its own right
#
# copies of php which are compiled into other packages (e.g. php support
# for the thttpd web server) don't need these variables

if [ "${PHP_PACKAGE}" = 1 ]; then
	HOMEPAGE="http://www.php.net/"
	LICENSE="PHP-3"
	SRC_URI="http://www.php.net/distributions/${MY_PHP_P}.tar.bz2"
	S="${WORKDIR}/${MY_PHP_P}"
fi

IUSE="${IUSE} adabas bcmath berkdb birdstep bzip2 calendar cdb crypt ctype curl curlwrappers db2 dba dbase dbm dbmaker dbx debug doc empress empress-bcs esoob exif fastbuild frontbase fdftk filepro firebird flatfile ftp gd gd-external gdbm gmp hardenedphp hyperwave-api iconv imap informix inifile interbase iodbc ipv6 java java-external jpeg kerberos ldap libedit mcal mcve memlimit mhash ming msql mssql mysql ncurses nls oci8 odbc oracle7 overload ovrimos pcntl pcre pear pfpro png posix postgres readline recode sapdb sasl session sharedext sharedmem snmp sockets solid spell sqlite ssl sybase sybase-ct sysvipc threads tiff tokenizer truetype wddx xml xml2 xmlrpc xpm xsl yaz zip zlib"

# these USE flags should have the correct dependencies
DEPEND="${DEPEND}
	!dev-php/php
	!dev-php/php-cgi
	!dev-php/mod_php
	berkdb? ( =sys-libs/db-4* )
	bzip2? ( app-arch/bzip2 )
	cdb? ( dev-db/cdb )
	crypt? ( >=dev-libs/libmcrypt-2.4 )
	curl? ( >=net-misc/curl-7.10.5 )
	fdftk? ( app-text/fdftk )
	firebird? ( dev-db/firebird  )
	gd-external? ( media-libs/gd )
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	gmp? ( dev-libs/gmp )
	imap? ( virtual/imap-c-client )
	iodbc? ( dev-db/libiodbc )
	!alpha? ( !amd64? ( java? ( =virtual/jdk-1.4* dev-java/java-config ) ) )
	jpeg? ( >=media-libs/jpeg-6b )
	kerberos? ( virtual/krb5 )
	ldap? ( >=net-nds/openldap-1.2.11 )
	libedit? ( dev-libs/libedit )
	mcal? ( dev-libs/libmcal !=dev-libs/libmcal-0.7-r2 )
	mcve? ( net-libs/libmonetra )
	mhash? ( app-crypt/mhash )
	ming? ( media-libs/ming )
	mssql? ( dev-db/freetds )
	mysql? ( dev-db/mysql )
	ncurses? ( sys-libs/ncurses )
	nls? ( sys-devel/gettext )
	odbc? ( >=dev-db/unixODBC-1.8.13 )
	png? ( media-libs/libpng )
	postgres? ( >=dev-db/postgresql-7.1 )
	readline? ( sys-libs/readline )
	recode? ( app-text/recode )
	sharedmem? ( dev-libs/mm )
	snmp? ( >=net-analyzer/net-snmp-5.2 )
	spell? ( >=app-text/aspell-0.60 )
	ssl? ( >=dev-libs/openssl-0.9.7 )
	sybase? ( dev-db/freetds )
	tiff? ( media-libs/tiff )
	truetype? ( =media-libs/freetype-2* >=media-libs/t1lib-5.0.0 )
	wddx? ( dev-libs/expat )
	xpm? ( virtual/x11 )
	xml? ( dev-libs/expat )
	xml2? ( dev-libs/libxml2 )
	xsl? ( app-text/sablotron dev-libs/expat )
	zlib? ( sys-libs/zlib )
	virtual/mta"

# libswf conflicts with ming and should not
# be installed with the new PHP ebuilds
DEPEND="${DEPEND} !media-libs/libswf"

# 9libs causes a configure error
DEPEND="${DEPEND} !dev-libs/9libs"

# simplistic for now
RDEPEND="${RDEPEND} ${DEPEND}"

# Additional features
#
# They are in PDEPEND because we need PHP installed first!
PDEPEND="${PDEPEND}
		doc? ( app-doc/php-docs )
		java-external? ( dev-php4/php-java-bridge )
		pear? ( >=dev-php/PEAR-PEAR-1.3.6 )
		sqlite? ( dev-php4/pecl-sqlite )
		yaz? ( dev-php4/pecl-yaz )
		zip? ( dev-php4/pecl-zip )"

# ========================================================================
# php.ini Support
# ========================================================================

PHP_INI_FILE="php.ini"

# ========================================================================
# Hardened-PHP Support
# ========================================================================
#
# I've done it like this so that we can support different versions of
# the patch for different versions of PHP

case "${PV}" in
	4.4.0) HARDENEDPHP_PATCH="hardening-patch-${PV}-0.4.1.patch.gz" ;;
esac

[ -n "${HARDENEDPHP_PATCH}" ] && SRC_URI="${SRC_URI} hardenedphp? ( http://www.hardened-php.net/${HARDENEDPHP_PATCH} )"

# ========================================================================

EXPORT_FUNCTIONS pkg_setup src_compile src_install src_unpack pkg_postinst

# ========================================================================
# INTERNAL FUNCTIONS
# ========================================================================

php4_4-sapi_check_awkward_uses() {
	# ------------------------------------
	# Rules for things unexpectedly broken
	# go below here
	#
	# These rules override the "normal"
	# rules listed later on
	# ------------------------------------

	# No special rules at the moment

	# ------------------------------------
	# Normal rules go below here
	# ------------------------------------

	# A variety of extensions need DBA
	confutils_use_depend_all "berkdb"	"dba"
	confutils_use_depend_all "cdb"		"dba"
	confutils_use_depend_all "dbm"		"dba"
	confutils_use_depend_all "flatfile"	"dba"
	confutils_use_depend_all "gdbm"		"dba"
	confutils_use_depend_all "inifile"	"dba"

	# DBX checks
	confutils_use_depend_any "dbx" "frontbase" "mssql" "odbc" "postgres" "sybase-ct" "oci8"

	# DOM XML support
	confutils_use_depend_all "xml2"		"zlib"

	# EXIF only gets built if we support a file format that uses it
	confutils_use_depend_any "exif" "jpeg" "tiff"

	# support for the GD graphics library
	confutils_use_conflict "gd" "gd-external"
	confutils_use_depend_any "truetype" "gd" "gd-external"
	confutils_use_depend_any "jpeg" "gd" "gd-external"
	confutils_use_depend_any "png"  "gd" "gd-external"
	confutils_use_depend_any "tiff" "gd" "gd-external"
	confutils_use_depend_any "xpm"  "gd" "gd-external"
	confutils_use_depend_all "png"  "zlib"

	# Hardened-PHP doesn't work well with Apache; needs further investigation
	confutils_use_conflict "hardenedphp" "apache" "apache2"

	# IMAP support
	php_check_imap

	# Java support
	php_check_java

	# Java-external support
	confutils_use_conflict "java-external" "java"
	confutils_use_depend_all "java-external" "session"

	# Mail support
	php_check_mta

	# Oracle support
	php_check_oracle

	# LDAP-sasl support
	confutils_use_depend_all "sasl" "ldap"

	# MCVE needs OpenSSL
	confutils_use_depend_all "mcve" "ssl"

	# ODBC support
	confutils_use_depend_all "adabas"		"odbc"
	confutils_use_depend_all "birdstep"		"odbc"
	confutils_use_depend_all "dbmaker"		"odbc"
	confutils_use_depend_all "empress"		"odbc"
	confutils_use_depend_all "empress-bcs"	"odbc" "empress"
	confutils_use_depend_all "esoob"		"odbc"
	confutils_use_depend_all "db2"			"odbc"
	confutils_use_depend_all "iodbc"		"odbc"
	confutils_use_depend_all "sapdb"		"odbc"
	confutils_use_depend_all "solid"		"odbc"

	# PEAR support
	confutils_use_depend_all "pear"			"cli" "pcre" "xml"

	# Readline and libedit do the same thing; you can't have both
	confutils_use_conflict "readline" "libedit"

	# Recode is not liked
	confutils_use_conflict "recode" "mysql" "imap" "nis"

	# the MM extension isn't thread-safe
	confutils_use_conflict "sharedmem" "threads"

	confutils_warn_about_missing_deps
}

# ========================================================================
# EXPORTED FUNCTIONS
# ========================================================================

php4_4-sapi_pkg_setup() {
	# let's do all the USE flag testing before we do anything else
	# this way saves a lot of time

	php4_4-sapi_check_awkward_uses
}

php4_4-sapi_src_unpack() {
	if [ "${PHP_PACKAGE}" == 1 ]; then
		unpack ${A}
	fi

	cd ${PHP_S}

	# Patch PHP to show Gentoo as the server platform
	sed -i "s/PHP_UNAME=\`uname -a\`/PHP_UNAME=\`uname -s -n -r -v\`/g" configure
	# Patch for PostgreSQL support
	sed -e 's|include/postgresql|include/postgresql include/postgresql/pgsql|g' -i configure

	# stop php from activating the apache config, as we will do that ourselves
	for i in configure sapi/apache/config.m4 sapi/apache2filter/config.m4 sapi/apache2handler/config.m4 ; do
		sed -i.orig -e 's,-i -a -n php,-i -n php,g' ${i}
		sed -i.orig -e 's,-i -A -n php,-i -n php,g' ${i}
	done

	# hardenedphp support
	use hardenedphp && [ -n "${HARDENEDPHP_PATCH}" ] && epatch ${DISTDIR}/${HARDENEDPHP_PATCH}

	# imap support
	use imap && epatch ${FILESDIR}/4.4.0/php4-imap-symlink.diff

	# iodbc support
	use iodbc && epatch ${FILESDIR}/4.4.0/php4-iodbc-config.diff
	use iodbc && epatch ${FILESDIR}/4.4.0/php4-with-iodbc.diff

	# fix configure scripts to recognize uClibc
	uclibctoolize

	# Just in case ;-)
	chmod 755 configure

	# fastbuild support
	use fastbuild && epatch ${FILESDIR}/4.4.0/fastbuild.patch

	# rebuild configure to make sure it's up to date
	einfo "Rebuilding configure script"
	WANT_AUTOCONF=2.5 autoconf -W no-cross || die "Unable to regenerate configure script"

	# fix DBA support
	sed -e 's!for LIB in dbm c gdbm!for LIB in dbm c gdbm gdbm_compat!' -i configure
}

set_php_ini_dir() {
	PHP_INI_DIR="/etc/php/${PHPSAPI}-php4"
	PHP_EXT_INI_DIR="${PHP_INI_DIR}/ext"
}

php4_4-sapi_src_compile() {
	destdir=/usr/$(get_libdir)/php4
	set_php_ini_dir

	cd ${PHP_S}
	confutils_init

	my_conf="${my_conf} --with-config-file-path=${PHP_INI_DIR} --with-config-file-scan-dir=${PHP_EXT_INI_DIR} --without-pear"

	#				extension		USE flag		shared support?
	enable_extension_enable		"bcmath"		"bcmath"		1
	enable_extension_with		"bz2"			"bzip2"			1
	enable_extension_enable		"calendar"		"calendar"		1
	enable_extension_disable	"ctype"			"ctype"			0
	enable_extension_with		"curl"			"curl"			1
	enable_extension_with		"curlwrappers"	"curlwrappers"	1
	enable_extension_enable		"dbase"			"dbase"			1
	enable_extension_with		"dom"			"xml2"			0
	enable_extension_enable		"exif"			"exif"			1
	enable_extension_with		"fbsql"			"frontbase"		1
	enable_extension_with		"fdftk"			"fdftk"			1 "/opt/fdftk-6.0"
	enable_extension_enable		"filepro"		"filepro"		1
	enable_extension_enable		"ftp"			"ftp"			1
	enable_extension_with		"gettext"		"nls"			1
	enable_extension_with		"gmp"			"gmp"			1
	enable_extension_with		"hwapi"			"hyperwave-api"	1
	enable_extension_with		"iconv"			"iconv"			1
	enable_extension_with		"informix"		"informix"		1
	enable_extension_disable	"ipv6"			"ipv6"			0
	# ircg extension not supported on Gentoo at this time
	enable_extension_with 		"jpeg-dir" 		"jpeg" 			0 "/usr"
	enable_extension_with		"kerberos"		"kerberos"		0 "/usr"
	enable_extension_enable		"mbstring"		"nls"			1
	enable_extension_with		"mcal"			"mcal"			1 "/usr"
	enable_extension_with		"mcrypt"		"crypt"			1
	enable_extension_with		"mcve"			"mcve"			1
	enable_extension_enable		"memory-limit"	"memlimit"		0
	enable_extension_with		"mhash"			"mhash"			1
	enable_extension_with		"ming"			"ming"			1
	enable_extension_with		"msql"			"msql"			1
	enable_extension_with		"mssql"			"mssql"			1
	enable_extension_with		"ncurses"		"ncurses"		1
	enable_extension_with		"oci8"			"oci8"			1
	enable_extension_with		"oracle"		"oracle7"		1
	enable_extension_with		"openssl"		"ssl"			1
	enable_extension_with		"openssl-dir"	"ssl"			0 "/usr"
	enable_extension_disable	"overload"		"overload"		0
	enable_extension_with		"ovrimos"		"ovrimos"		1
	enable_extension_enable		"pcntl" 		"pcntl" 		1
	enable_extension_without	"pcre-regex"	"pcre"			0
	enable_extension_with		"pfpro"			"pfpro"			1
	enable_extension_with		"pgsql"			"postgres"		1
	enable_extension_disable	"posix"			"posix"			1
	enable_extension_with		"pspell"		"spell"			1
	enable_extension_with		"recode"		"recode"		1
	enable_extension_enable		"shmop"			"sharedmem"		0
	enable_extension_with		"snmp"			"snmp"			1
	enable_extension_enable		"sockets"		"sockets"		1
	enable_extension_with		"sybase"		"sybase"		1
	enable_extension_with		"sybase-ct"		"sybase-ct"		1
	enable_extension_enable		"sysvmsg"		"sysvipc"		1
	enable_extension_enable		"sysvsem"		"sysvipc"		1
	enable_extension_enable		"sysvshm"		"sysvipc"		1
	enable_extension_disable	"tokenizer"		"tokenizer"		1
	enable_extension_enable		"wddx"			"wddx"			1
	enable_extension_disable	"xml"			"xml"			0
	enable_extension_with		"xmlrpc"		"xmlrpc"		1
	enable_extension_with		"zlib"			"zlib"			1
	enable_extension_enable		"debug"			"debug"			0

	# DBA support
	enable_extension_enable		"dba"		"dba"		1

	if useq dba ; then
		enable_extension_with "cdb"			"cdb"		1
		enable_extension_with "db4"			"berkdb"	1
		enable_extension_with "dbm"			"dbm"		1
		enable_extension_with "flatfile"	"flatfile"	1
		enable_extension_with "gdbm"		"gdbm"		1
		enable_extension_with "inifile"		"inifile"	1
	fi

	# DBX support
	if useq dbx ; then
		enable_extension_enable	"dbx"		"dbx"		1
	fi

	# support for the GD graphics library
	if useq gd-external ; then
		enable_extension_with	"freetype-dir"	"truetype"		0 "/usr"
		enable_extension_with	"t1lib"			"truetype"		0 "/usr"
		enable_extension_enable	"gd-jis-conv"	"nls" 			0
		enable_extension_enable	"gd-native-ttf"	"truetype"		0
		enable_extension_with 	"gd" 			"gd-external"	1 "/usr"
	else
		enable_extension_with	"freetype-dir"	"truetype"		0 "/usr"
		enable_extension_with	"t1lib"			"truetype"		0 "/usr"
		enable_extension_enable	"gd-jis-conv"	"nls"			0
		enable_extension_enable	"gd-native-ttf"	"truetype"		0
		enable_extension_with 	"png-dir" 		"png" 			0 "/usr"
		enable_extension_with 	"tiff-dir" 		"tiff" 			0 "/usr"
		enable_extension_with 	"xpm-dir" 		"xpm" 			0 "/usr/X11R6"
		# enable gd last, so configure can pick up the previous settings
		enable_extension_with 	"gd" 			"gd" 			0
	fi

	# Java support
	if useq java ; then
		enable_extension_with	"java"			"java"			0 "`java-config --jdk-home`"
	fi

	# IMAP support
	if useq imap ; then
		enable_extension_with	"imap"			"imap"			1
		enable_extension_with	"imap-ssl"		"ssl"			0
	fi

	# Interbase support
	if useq firebird || useq interbase ; then
		my_conf="${my_conf} --with-interbase"
	fi

	# LDAP support
	if useq ldap ; then
		enable_extension_with	"ldap"			"ldap"			1
		enable_extension_with	"ldap-sasl"		"sasl"			0
	fi

	# MySQL support
	# In PHP4 MySQL is enabled by default, so if no 'mysql' USE flag is set,
	# we must turn it off.
	if ! useq mysql ; then
		enable_extension_without	"mysql"		"mysql"			1 "/usr"
	fi
	if useq mysql ; then
		enable_extension_with	"mysql"			"mysql"			1 "/usr"
		enable_extension_with	"mysql-sock"	"mysql"			0 "/var/run/mysqld/mysqld.sock"
	fi

	# ODBC support
	if useq odbc ; then
		enable_extension_with		"unixODBC"		"odbc"			1 "/usr"

		enable_extension_with		"adabas"		"adabas"		1
		enable_extension_with		"birdstep"		"birdstep"		1
		enable_extension_with		"dbmaker"		"dbmaker"		1
		enable_extension_with		"empress"		"empress"		1
		if useq empress ; then
			enable_extension_with	"empress-bcs"	"empress-bcs"	0
		fi
		enable_extension_with		"esoob"			"esoob"			1
		enable_extension_with		"ibm-db2"		"db2"			1
		enable_extension_with		"iodbc"			"iodbc"			1 "/usr"
		enable_extension_with		"sapdb"			"sapdb"			1
		enable_extension_with		"solid"			"solid"			1
	fi

	# readline/libedit support
	# you can use readline or libedit, but you can't use both
	enable_extension_with		"readline"		"readline"		0
	enable_extension_with		"libedit"		"libedit"		1

	# Sablotron/XSLT support
	enable_extension_enable		"xslt"			"xsl"			1
	enable_extension_with		"xslt-sablot"	"xsl"			1
	if useq xml2 ; then
		enable_extension_with		"dom-xslt"		"xsl"			0 	"/usr"
		enable_extension_with		"dom-exslt"		"xsl"			0	"/usr"
	fi

	# session support
	if ! useq session ; then
		enable_extension_disable	"session"	"session"		1
	else
		enable_extension_with		"mm"		"sharedmem"		0
	fi

	# fix ELF-related problems
	if has_pic ; then
		einfo "Enabling PIC support"
		my_conf="${my_conf} --with-pic"
	fi

	# apache2 & threads support
	if useq apache2 && useq threads ; then
		my_conf="${my_conf} --enable-experimental-zts"
		ewarn "Enabling ZTS for Apache2 MPM"
	fi

	# catch cflag problems
	php_check_cflags

	# multilib support
	if [[ $(get_libdir) != lib ]] ; then
		my_conf="--with-libdir=$(get_libdir) ${my_conf}"
	fi

	# all done

	# we don't use econf, because we need to override all of its settings
	./configure --prefix=${destdir} --sysconfdir=/etc --cache-file=./config.cache ${my_conf} || die "configure failed"
	emake || die "make failed"
}

php4_4-sapi_src_install() {
	destdir=/usr/$(get_libdir)/php4

	cd ${PHP_S}
	addpredict /usr/share/snmp/mibs/.index

	PHP_INSTALLTARGETS="install-build install-headers install-programs"
	useq sharedext && PHP_INSTALLTARGETS="${PHP_INSTALLTARGETS} install-modules"
	make INSTALL_ROOT=${D} ${PHP_INSTALLTARGETS} || die "install failed"

	# get the extension dir
	PHPEXTDIR="`${D}/${destdir}/bin/php-config --extension-dir`"

	# don't forget the php.ini file
	local phpinisrc=php.ini-dist
	einfo "Setting extension_dir in php.ini"
	sed -e "s|^extension_dir .*$|extension_dir = ${PHPEXTDIR}|g" -i ${phpinisrc}

	# A patch for PHP for security. PHP-CLI interface is exempt, as it cannot be
	# fed bad data from outside.
	einfo "Securing fopen wrappers"
	sed -e 's|^allow_url_fopen .*|allow_url_fopen = Off|g' -i ${phpinisrc}

	# Set the include path to point to where we want to find PEAR packages
	einfo "Setting correct include_path"
	sed -e 's|^;include_path .*|include_path = ".:/usr/share/php:/usr/share/php4"|' -i ${phpinisrc}

	# Java install needs to insert the correct lines into phpinisrc
	php_install_java

	# Install any extensions built as shared objects
	if useq sharedext; then
		for x in `ls ${D}/${PHPEXTDIR}/*.so | sort | sed -e "s|.*java.*||g"`; do
			echo "extension=`basename ${x}`" >> ${phpinisrc}
		done;
	fi

	# create the directory where we'll put php4-only php scripts
	keepdir /usr/share/php4
}

php4_4-sapi_install_ini() {
	# work out where we are installing the ini file
	set_php_ini_dir
	local phpinisrc=php.ini-dist

	dodir ${PHP_INI_DIR}
	insinto ${PHP_INI_DIR}
	newins ${phpinisrc} ${PHP_INI_FILE}

	dodir ${PHP_EXT_INI_DIR}
}

php4_4-sapi_pkg_postinst() {
	ewarn "If you have additional third party PHP extensions (such as"
	ewarn "dev-php4/phpdbg) you may need to recompile them now."

	if useq curl; then
		ewarn "Please be aware that CURL can allow the bypass of open_basedir restrictions."
		ewarn "This can be a security risk!"
	fi
}
