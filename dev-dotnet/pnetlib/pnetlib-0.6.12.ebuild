# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/pnetlib/pnetlib-0.6.12.ebuild,v 1.2 2005/01/29 21:39:51 scandium Exp $

inherit eutils libtool

DESCRIPTION="Portable.NET C# library"
HOMEPAGE="http://www.dotgnu.org/"
SRC_URI="mirror://gnu/dotgnu/pnet/${P}.tar.gz"

LICENSE="GPL-2-with-linking-exception"
SLOT="0"
KEYWORDS="x86 ppc ppc64 sparc ~mips ~alpha arm ~hppa amd64 ia64"
IUSE="truetype X"

DEPEND="=dev-dotnet/pnet-${PV}*
	X? ( virtual/x11 )
	truetype? ( virtual/xft )"

src_unpack() {
	unpack ${A}
	cd ${S}
	# patch configure.in to detect renamed resgen.pnet
	# bug 39369
	epatch ${FILESDIR}/${PV}-resgen.patch

	# syntax error; patch not needed anymore for the next release
	epatch ${FILESDIR}/configure-freetype.patch
}

src_compile() {
	local lib_profile="default1.1"
	einfo "Using profile: ${lib_profile}"

	WANT_AUTOCONF=2.5 ./auto_gen.sh
	elibtoolize
	econf --with-profile=${lib_profile} \
		`use_enable truetype xft` || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS ChangeLog HACKING INSTALL NEWS README
	dodoc doc/*.txt
	dohtml doc/*.html
}
