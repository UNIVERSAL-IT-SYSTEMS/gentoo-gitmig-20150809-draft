# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/snortalog/snortalog-2.3.0.ebuild,v 1.1 2005/03/07 10:43:53 ka0ttic Exp $

inherit eutils

DESCRIPTION="a powerful perl script that summarizes snort logs"
SRC_URI="http://jeremy.chartier.free.fr/${PN}/${PN}_v${PV}.tgz"
HOMEPAGE="http://jeremy.chartier.free.fr/snortalog/"

KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE="tcltk"

S="${WORKDIR}/${PN}_v${PV%.?}"

RDEPEND="dev-lang/perl
	dev-perl/Getopt-Long
	dev-perl/DB_File
	dev-perl/HTML-HTMLDoc
	tcltk? ( dev-perl/perl-tk
			 dev-perl/GDGraph )"

src_unpack() {
	unpack ${A} && cd ${S}
	use tcltk || epatch ${FILESDIR}/${PN}-notcltk.diff
	# fix paths
	sed -i -e "s:\(modules/\):/usr/lib/snortalog/${PV}/\1:g" \
		-e 's:\($domains_file = "\)\(domains\)\(".*\):\1/etc/snortalog/\2\3:' \
		-e 's:\($rules_file = "\)\(rules\)\(".*\):\1/etc/snortalog/\2\3:' \
		-e 's:\($hw_file = "\)\(hw\)\(".*\):\1/etc/snortalog/\2\3:' \
		-e 's:\($lang_file = "\)\(lang\)\(".*\):\1/etc/snortalog/\2\3:' \
		snortalog.pl || die "sed snortalog.pl failed"

}

src_install () {
	dobin snortalog.pl || die

	insinto /etc/${PN}
	doins domains hw lang rules

	insinto /usr/lib/${PN}/${PV}/modules
	doins modules/*
	dodoc CHANGES README snortalog_v2.2.0.pdf
}
