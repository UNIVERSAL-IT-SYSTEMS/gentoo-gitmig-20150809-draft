# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/fontconfig/fontconfig-2.1.94.ebuild,v 1.1 2003/04/17 18:02:12 foser Exp $

inherit debug eutils

DESCRIPTION="A library for configuring and customizing font access."
SRC_URI="http://fontconfig.org/release/${P}.tar.gz"
HOMEPAGE="http://fontconfig.org/"

LICENSE="fontconfig"
SLOT="1.0"
KEYWORDS="~x86 ~alpha ~ppc ~sparc ~mips ~hppa ~arm"

# Seems like patches in freetype-2.1.2-r2 fixes bug #10028
DEPEND=">=media-libs/freetype-2.1.2-r2
	>=dev-libs/expat-1.95.3
	>=sys-apps/ed-0.2"

src_unpack() {
	unpack ${A}

	cd ${S}
	local PPREFIX="${FILESDIR}/patch/${PN}"

	# Some patches from Redhat
	epatch ${PPREFIX}-2.1-slighthint.patch

	# The date can be troublesome 
	mv configure configure.old
	sed -e "s:\`date\`::" configure.old > configure
	chmod +x configure
}

src_compile() {
	# FIXME : docs do not work
	econf --disable-docs \
		--x-includes=/usr/X11R6/include \
		--x-libraries=/usr/X11R6/lib \
		--with-default-fonts=/usr/X11R6/lib/X11/fonts/Type1 || die

	# this triggers sandbox, we do this ourselves 
	mv Makefile Makefile.old
	sed -e "s:fc-cache/fc-cache -f -v:sleep 0:" Makefile.old > Makefile
	
	emake || die

	# remove Luxi TTF fonts from the list, the Type1 are much better
	mv fonts.conf fonts.conf.old 
	sed -e "s:<dir>/usr/X11R6/lib/X11/fonts/TTF</dir>::" fonts.conf.old > fonts.conf
}

src_install() {
	einstall confdir=${D}/etc/fonts \
		datadir=${D}/usr/share || die
	
	insinto /etc/fonts
	doins ${S}/fonts.conf
	newins ${S}/fonts.conf fonts.conf.new

	cd ${S}
	
	mv fc-cache/fc-cache.man fc-cache/fc-cache.1
	mv fc-list/fc-list.man fc-list/fc-list.1
	mv src/fontconfig.man src/fontconfig.3
	for x in fc-cache/fc-cache.1 fc-list/fc-list.1 src/fontconfig.3
	do
		doman ${x}
	done

	dodoc AUTHORS COPYING ChangeLog NEWS README
}

pkg_postinst() {
	# Changes should be made to /etc/fonts/local.conf, and as we had
	# too much problems with broken fonts.conf, we force update it ...
	# <azarah@gentoo.org> (11 Dec 2002)
	ewarn "Please make fontconfig related changes to /etc/fonts/local.conf,"
	ewarn "and NOT to /etc/fonts/fonts.conf, as it will be replaced!"
	mv -f ${ROOT}/etc/fonts/fonts.conf.new ${ROOT}/etc/fonts/fonts.conf
	rm -f ${ROOT}/etc/fonts/._cfg????_fonts.conf

	if [ "${ROOT}" = "/" ]
	then
		echo
		einfo "Creating font cache..."
		HOME="/root" /usr/bin/fc-cache -f
	fi
}

