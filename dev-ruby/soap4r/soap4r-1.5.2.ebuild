# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/soap4r/soap4r-1.5.2.ebuild,v 1.3 2004/06/25 02:04:52 agriffis Exp $

inherit ruby

USE_RUBY="any"

MY_P=${P//./_}
DESCRIPTION="an implementation of SOAP 1.1"
HOMEPAGE="http://rrr.jin.gr.jp/rwiki?cmd=view;name=soap4r"
SRC_URI="http://rrr.jin.gr.jp/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="<dev-lang/ruby-1.8.1
	>=dev-ruby/devel-logger-1.0.1
	>=dev-ruby/http-access2-0j
	>=dev-ruby/rexml-2.5.3
	>=dev-ruby/uconv-0.4.10"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}

	cd ${S}
	cp install.rb ${T}
	sed -e "s:^RUBYLIBDIR = :RUBYLIBDIR = \"${D}\" + :" \
		-e "s:^SITELIBDIR = :SITELIBDIR = \"${D}\" + :" \
		${T}/install.rb > install.rb || die
}
