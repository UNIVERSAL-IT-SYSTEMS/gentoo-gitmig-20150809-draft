# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perl-ldap/perl-ldap-0.440.0.ebuild,v 1.4 2012/08/05 18:32:44 maekke Exp $

EAPI=4

MODULE_AUTHOR=MARSCHAP
MODULE_VERSION=0.44
inherit perl-module

DESCRIPTION="A collection of perl modules which provide an object-oriented interface to LDAP servers."

SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="sasl xml ssl"

RDEPEND="
	dev-perl/Convert-ASN1
	dev-perl/URI
	sasl? (
		virtual/perl-Digest-MD5
		dev-perl/Authen-SASL
	)
	xml? (
		dev-perl/XML-Parser
		dev-perl/XML-SAX
		dev-perl/XML-SAX-Writer
	)
	ssl? (
		>=dev-perl/IO-Socket-SSL-1.26
	)"
DEPEND="${RDEPEND}"

#SRC_TEST=do
