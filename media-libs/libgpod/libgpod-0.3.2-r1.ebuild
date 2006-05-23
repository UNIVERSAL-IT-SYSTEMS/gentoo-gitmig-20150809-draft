# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgpod/libgpod-0.3.2-r1.ebuild,v 1.3 2006/05/23 11:50:59 corsair Exp $

inherit eutils

DESCRIPTION="Shared library to access the contents of an iPod"
HOMEPAGE="http://www.gtkpod.org/libgpod.html"
SRC_URI="mirror://sourceforge/gtkpod/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ppc64 ~sparc ~x86"
IUSE="hal gtk python"

RDEPEND=">=dev-libs/glib-2.4
		gtk? ( >=x11-libs/gtk+-2 )
		hal? ( >=sys-apps/dbus-0.5.2
				>=sys-apps/hal-0.5
				>=sys-apps/pmount-0.9.6 )
		python? ( >=dev-lang/python-2.3 )
		virtual/eject"
DEPEND="${RDEPEND}
		sys-devel/autoconf
		sys-devel/libtool
		>=dev-util/intltool-0.2.9"
src_unpack() {
	unpack ${A}

	cd ${S}

	sed -i -e "s:/usr/include/python2.3/:`python -c 'import distutils.sysconfig;print distutils.sysconfig.get_python_inc()'`:" bindings/python/Makefile

	epatch ${FILESDIR}/${PN}-0.3.0-config-enables.diff
	autoreconf
	libtoolize --force --copy
}

src_compile() {

	local myconf=""

	myconf="${myconf}
		$(use_enable hal)
		$(use_enable gtk gdk-pixbuf)"

	if use hal ; then
		myconf="${myconf} --with-eject-comand=/usr/bin/eject \
						--with-unmount-command=/usr/bin/pumount"
	else
	myconf="${myconf}
		--with-eject-command=/usr/bin/eject \
		--with-unmount-command=/bin/umount"
	fi

	econf \
	${myconf} \
	|| die "configure failed"
	emake || die "make failed"

	if use python; then
		cd ${S}/bindings/python
		emake
	fi
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc README

	if use python; then
		cd ${S}/bindings/python

		insinto $(python -c 'import distutils.sysconfig;print distutils.sysconfig.get_python_lib()')
		doins ${S}/bindings/python/_gpod.so
		doins ${S}/bindings/python/gpod.py
	fi
}

