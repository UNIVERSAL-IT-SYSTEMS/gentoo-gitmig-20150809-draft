# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wireless-tools/wireless-tools-28_pre10.ebuild,v 1.4 2005/12/18 18:04:26 corsair Exp $

inherit toolchain-funcs multilib

# The following works with both pre-releases and releases
MY_P=${PN/-/_}.${PV/_/.}
S=${WORKDIR}/${MY_P/\.pre*/}

DESCRIPTION="A collection of tools to configure IEEE 802.11 wireless LAN cards"
SRC_URI="http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/${MY_P}.tar.gz"
HOMEPAGE="http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html"

KEYWORDS="~amd64 hppa ~mips ~ppc ppc64 ~sparc x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="sys-apps/sed"
RDEPEND="virtual/libc"
IUSE="multicall nls"

src_unpack() {
	unpack ${A}

	sed -i \
		-e "s:^\(CC\) = gcc:\1 = $(tc-getCC):" \
		-e "s:^\(AR\) = ar:\1 = $(tc-getAR):" \
		-e "s:^\(RANLIB\) = ranlib:\1 = $(tc-getRANLIB):" \
		-e "s:^\(CFLAGS=-Os\):#\1:" \
		-e "s:\(@\$(LDCONFIG).*\):#\1:" \
		-e "s:^\(INSTALL_MAN= \$(PREFIX)\)/man/:\1/share/man:" \
		-e "s:^\(INSTALL_LIB= \$(PREFIX)\)/lib/:\1/$(get_libdir)/:" \
		${S}/Makefile
}

src_compile() {
	if use multicall; then
		emake || die "emake failed"
		emake iwmulticall || die "emake iwmulticall failed"
	else
		emake || die "emake failed"
	fi
}

src_install() {
	if use multicall; then
		emake PREFIX=${D}/ INSTALL_INC=${D}/usr/include INSTALL_MAN=${D}/usr/share/man install \
			|| die "emake install failed"
		# 'make install-iwmulticall will overwrite some of the tools
		# with symlinks - this is intentional (brix)
		emake PREFIX=${D}/ INSTALL_INC=${D}/usr/include INSTALL_MAN=${D}/usr/share/man install-iwmulticall \
			|| die "emake install-iwmulticall failed"
	else
		emake PREFIX=${D}/ INSTALL_INC=${D}/usr/include INSTALL_MAN=${D}/usr/share/man install \
			|| die "emake install failed"
	fi

	if use nls; then
		insinto /usr/share/man/fr/man5
		doins fr/iftab.5

		insinto /usr/share/man/fr/man7
		doins fr/wireless.7

		insinto /usr/share/man/fr/man8
		doins fr/{ifrename,iwconfig,iwevent,iwgetid,iwlist,iwpriv,iwspy}.8

		dodoc README.fr

		insinto /usr/share/man/cs/man5
		doins cs/iftab.5

		insinto /usr/share/man/cs/man7
		doins cs/wireless.7

		insinto /usr/share/man/cs/man8
		doins cs/{ifrename,iwconfig,iwevent,iwgetid,iwlist,iwpriv,iwspy}.8
	fi

	dodoc CHANGELOG.h COPYING INSTALL HOTPLUG.txt PCMCIA.txt README
}
