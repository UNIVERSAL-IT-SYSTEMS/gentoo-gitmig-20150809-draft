# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/rackview/rackview-0.04-r1.ebuild,v 1.6 2004/05/31 19:21:33 vapier Exp $

inherit perl-module

DESCRIPTION="tool for visualizing the layout of rack-mounted equipment"
HOMEPAGE="http://rackview.sourceforge.net/"
SRC_URI="mirror://sourceforge/rackview/rackview-${PV}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86"
IUSE="apache2 mysql"

DEPEND="dev-lang/perl
	dev-perl/GD
	dev-perl/DBI
	mysql? ( dev-db/mysql )"

DOCS="ChangeLog README* doc/*"

src_install() {
	#In case of Apache

	use apache2 || HTTPD_ROOT="`grep '^DocumentRoot' /etc/apache/conf/apache.conf | cut -d\  -f2`" \
				|| HTTPD_USER="`grep '^User' /etc/apache/conf/commonapache.conf | cut -d \  -f2`" \
				|| HTTPD_GROUP="`grep '^Group' /etc/apache/conf/commonapache.conf | cut -d \  -f2`"

	#In case of Apache2

	use apache2 && HTTPD_ROOT="`grep '^DocumentRoot' /etc/apache2/conf/apache2.conf | cut -d\  -f2`" \
				&& HTTPD_USER="`grep '^User' /etc/apache2/conf/commonapache2.conf | cut -d \  -f2`" \
				&& HTTPD_GROUP="`grep '^Group' /etc/apache2/conf/commonapache2.conf | cut -d \  -f2`"

	# Else use defaults

	[ -z "${HTTPD_ROOT}" ] && HTTPD_ROOT="/home/httpd/htdocs"
	[ -z "${HTTPD_USER}" ] && HTTPD_USER="apache"
	[ -z "${HTTPD_GROUP}" ] && HTTPD_GROUP="apache"


	perl-module_src_install

	dodoc ${DOCS}

	#Correct configfile
	dodir /etc/${PN}
	mv ${D}usr/etc/eidetic/* ${D}etc/${PN}
	cd ${D}etc/${PN}
	sed -i -e "s:eidetic:${PN}:" \
		-e "s:/home/www/site_html/images:${HTTPD_ROOT}:" \
		-e "s:images/rack_images:rack_images:" ${PN}.conf \
		&& rm *.orig \
		|| ewarn "Please check /etc/${PN}/${PN}.conf"
	rm -fr ${D}usr/etc											#Remove trash

	einfo "Installing example in ${HTTPD_ROOT}/${PN}"
	cd ${S}
	dodir ${HTTPD_ROOT}/${PN}
	mv example/* ${D}${HTTPD_ROOT}/${PN}
	mv ${D}usr/var/www/html/* ${D}${HTTPD_ROOT}
	rm -fr ${D}usr/var											#Remove trash

	#Install .cgi
	dodir ${HTTPD_ROOT}/../cgi-bin
	cp cgi-bin/rackview.cgi ${D}${HTTPD_ROOT}/../cgi-bin/${PN}.cgi \
		&& cd ${D}${HTTPD_ROOT}/../cgi-bin \
		&& sed -i -e "s:/var/www/html:${HTTPD_ROOT}:" \
		       -e "s:eidetic:${PN}:" ${PN}.cgi \
		&& chmod u+x ${PN}.cgi \
		&& rm ${PN}.cgi.orig	\
		|| ewarn "Please copy (& check) ${PN}.cgi manually."

	#Script needs to change also
	cd ${D}usr/bin
	sed -i -e "s:eidetic:${PN}:" e${PN} \
		&& chmod ugo+x e${PN} \
		&& rm erackview.orig \
		|| ewarn "Please check script 'e${PN}'."

	#Making sure HTTPD_USER owns all files
	cd ${D}
	chown -R ${HTTPD_USER}:${HTTPD_GROUP} * || ewarn "Check if ${HTTPD_USER} owns all files."
}

pkg_postinst() {
	use mysql && einfo "To load data from mysql, change 'dat' in 'db' in /etc/${PN}/${PN}.conf" \
		&& einfo "SQL files for creating these tables are available in ${S}/sql"
	einfo "Now go to http://${HOSTNAME}/${PN}/ to test."
}
