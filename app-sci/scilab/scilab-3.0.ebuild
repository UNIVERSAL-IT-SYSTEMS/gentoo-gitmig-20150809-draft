# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/scilab/scilab-3.0.ebuild,v 1.1 2004/08/19 23:06:45 ribosome Exp $

DESCRIPTION="Scientific software package for numerical computations (Matlab lookalike)"
SRC_URI="ftp://ftp.inria.fr/INRIA/Scilab/distributions/${P}.src.tar.gz"
HOMEPAGE="http://www.scilab.org/"

LICENSE="scilab"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="tcltk atlas gtk gtk2 Xaw3d"

RDEPEND="virtual/x11
	sys-libs/ncurses
	atlas? ( dev-libs/atlas )
	gtk? (
		>=gnome-base/gnome-libs-1.4.2
		>=dev-libs/glib-2.2
		media-libs/jpeg
		media-libs/libpng
		sys-libs/zlib
		gtk2? ( >=x11-libs/gtk+-2*
			>=x11-libs/libzvt-2*
			>=gnome-extra/libgtkhtml-2*
		)
		!gtk2? ( =x11-libs/gtk+-1.2* )
	)
	tcltk? ( >=dev-lang/tk-8.4
		>=dev-lang/tcl-8.4 )
	Xaw3d? ( x11-libs/Xaw3d )"

DEPEND="${RDEPEND}
	app-text/sablotron
	dev-libs/libxslt"

src_compile() {
	local myopts
	use tcltk || myopts="${myopts} --without-tk"
	use Xaw3d || myopts="${myopts} --without-xaw3d"
	use atlas && myopts="${myopts} --with-atlas-library=/usr/lib"
	use gtk2 && myopts="${myopts} --with-gtk2" || \
		use gtk && myopts="${myopts} --with-gtk"

	econf ${myopts} || die
	env HOME=${S} make all || die
}

src_install() {
	# These instructions come from the file ${P}/Makefile, mostly section
	# install. Make sure files have not been removed or added to these list
	# when you use this ebuild as a template for future versions.
	PVMBINDISTFILES="\
		${P}/pvm3/Readme \
		${P}/pvm3/lib/pvm \
		${P}/pvm3/lib/pvmd \
		${P}/pvm3/lib/pvmtmparch \
		${P}/pvm3/lib/pvmgetarch \
		${P}/pvm3/lib/LINUX/pvmd3 \
		${P}/pvm3/lib/LINUX/pvmgs \
		${P}/pvm3/lib/LINUX/pvm \
		${P}/pvm3/bin/LINUX/*"
	BINDISTFILES="\
		${P}/.binary \
		${P}/.pvmd.conf \
		${P}/ACKNOWLEDGEMENTS \
		${P}/CHANGES \
		${P}/Makefile \
		${P}/Makefile.OBJ \
		${P}/Makefile.incl \
		${P}/Makemex \
		${P}/Path.incl \
		${P}/README_Unix \
		${P}/Version.incl \
		${P}/configure \
		${P}/libtool \
		${P}/license.txt \
		${P}/licence.txt \
		${P}/scilab.quit \
		${P}/scilab.star \
		${P}/X11_defaults \
		${P}/bin \
		${P}/config \
		${P}/contrib \
		${P}/demos \
		${P}/examples \
		${P}/imp/NperiPos.ps \
		${P}/imp/giffonts \
		${P}/macros \
		${P}/man/eng/ \
		${P}/man/fr/ \
		${P}/man/*.dtd \
		${P}/man/*/*.xsl \
		${P}/maple \
		${P}/routines/*.h \
		${P}/routines/Make.lib \
		${P}/routines/default/FCreate \
		${P}/routines/default/Flist \
		${P}/routines/default/README \
		${P}/routines/default/fundef \
		${P}/routines/default/*.c \
		${P}/routines/default/*.f \
		${P}/routines/default/*.h \
		${P}/routines/graphics/Math.h \
		${P}/routines/graphics/Graphics.h \
		${P}/routines/graphics/Entities.h \
		${P}/routines/interf/*.h \
		${P}/routines/intersci/sparse.h \
		${P}/routines/menusX/*.h \
		${P}/routines/scicos/scicos.h \
		${P}/routines/scicos/scicos_block.h \
		${P}/routines/sun/*.h \
		${P}/routines/xsci/*.h \
		${P}/scripts \
		${P}/tcl \
		${P}/tests \
		${P}/util"

	touch .binary
	strip bin/scilex
	cd ${S}/tests && make distclean
	cd ${S}/examples && make distclean
	cd ${S}/man && make man

	dodir /usr/lib
	(cd ${S}/.. && tar cf - ${BINDISTFILES} ${PVMBINDISTFILES} | (cd ${D}/usr/lib; tar xf -))
	rm .binary

	dodir /usr/bin
	dosym /usr/lib/${P}/bin/scilab /usr/bin/scilab
	dosym /usr/lib/${P}/bin/intersci /usr/bin/intersci
	dosym /usr/lib/${P}/bin/intersci-n /usr/bin/intersci-n
}

pkg_preinst() {
	# The compile and install process causes the work folder to be registered
	# as the runtime folder in the launch script. This is corrected here.
	BAD_LINE=SCI\=\"${WORKDIR}/${P}\"
	FIXED_LINE=SCI\=\"/usr/lib/${P}\"
	sed -i -e "s#${BAD_LINE}#${FIXED_LINE}#" ${D}/usr/lib/${P}/bin/scilab
}

pkg_postinst() {
	einfo "To tell Scilab about your printers, set the environment"
	einfo "variable PRINTERS in the form:"
	einfo
	einfo "PRINTERS=\"firstPrinter:secondPrinter:anotherPrinter\""
}
