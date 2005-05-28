# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/python/python-2.2.3-r6.ebuild,v 1.4 2005/05/28 00:55:06 kloeri Exp $

inherit flag-o-matic eutils python versionator

PYVER_MAJOR=$(get_major_version)
PYVER_MINOR=$(get_version_component_range 2)
PYVER="${PYVER_MAJOR}.${PYVER_MINOR}"

S="${WORKDIR}/Python-${PV}"
DESCRIPTION="A really great language"
HOMEPAGE="http://www.python.org"
SRC_URI="http://www.python.org/ftp/python/${PV%_*}/Python-${PV}.tgz"

LICENSE="PSF-2.2"
SLOT="2.2"
KEYWORDS="amd64 x86 ppc sparc alpha mips hppa ia64 ppc64"
IUSE="berkdb bootstrap build doc gdbm ncurses readline ssl tcltk nocxx"

DEPEND=">=sys-libs/zlib-1.1.3
	!build? ( 	tcltk? ( >=dev-lang/tk-8.0 )
				ncurses? ( >=sys-libs/ncurses-5.2 readline? ( >=sys-libs/readline-4.1 ) )
				berkdb? ( >=sys-libs/db-3 )
				dev-libs/expat
				gdbm? ( sys-libs/gdbm )
				ssl? ( dev-libs/openssl )
				doc? ( =dev-python/python-docs-${PV}* )
	)"

RDEPEND="${DEPEND} dev-python/python-fchksum"

# The dev-python/python-fchksum RDEPEND is needed to that this python provides
# the functionality expected from previous pythons.

PROVIDE="virtual/python"

src_unpack() {
	unpack ${A}
	#Fixes security vulnerability in XML-RPC server - pythonhead (06 Feb 05)
	#http://www.python.org/security/PSF-2005-001/
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${PN}-2.2.3-xmlrpc.patch
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${P}-db4.patch
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${P}-disable_modules_and_ssl.patch
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${PN}-2.3-add_portage_search_path.patch
	epatch ${FILESDIR}/${PN}-2.2.3-gentoo_py_dontcompile.patch
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${P}-fPIC.patch
}

src_configure() {
	# disable extraneous modules with extra dependencies
	if use build; then
		export PYTHON_DISABLE_MODULES="readline pyexpat dbm gdbm bsddb _curses _curses_panel _tkinter"
		export PYTHON_DISABLE_SSL=1
	else
		use gdbm \
			|| PYTHON_DISABLE_MODULES="${PYTHON_DISABLE_MODULES} gdbm"
		use berkdb \
			|| PYTHON_DISABLE_MODULES="${PYTHON_DISABLE_MODULES} dbm bsddb"
		use readline \
			|| PYTHON_DISABLE_MODULES="${PYTHON_DISABLE_MODULES} readline"
		use tcltk \
			|| PYTHON_DISABLE_MODULES="${PYTHON_DISABLE_MODULES} _tkinter"
		use ncurses \
			|| PYTHON_DISABLE_MODULES="${PYTHON_DISABLE_MODULES} _curses _curses_panel"
		use ssl \
			|| export PYTHON_DISABLE_SSL=1
		export PYTHON_DISABLE_MODULES
	fi
}

src_compile() {
	filter-flags -malign-double

	export CFLAGSFORSHARED="-fPIC"
	export OPT="${CFLAGS}"

	# adjust makefile to install pydoc into ${D} correctly
	t="${S}/Makefile.pre.in"
	cp ${t} ${t}.orig || die
	sed 's:install-platlib.*:& --install-scripts=$(BINDIR):' ${t}.orig > ${t}

	local myopts
	#if we are creating a new build image, we remove the dependency on g++
	if use build && ! use bootstrap || use nocxx
	then
		myopts="--with-cxx=no"
	fi

	src_configure

	# build python with threads support
	myopts="${myopts} --with-threads"

	econf --with-fpectl \
		--infodir='${prefix}'/share/info \
		--mandir='${prefix}'/share/man \
		${myopts} || die
	emake || die "Parallel make failed"
}

src_install() {
	dodir /usr
	src_configure
	make install prefix=${D}/usr || die

	rm -f ${D}/usr/bin/python
	dodoc README

	# install our own custom python-config
	exeinto /usr/bin
	newexe ${FILESDIR}/python-config-${PYVER} python-config

	# seems like the build do not install Makefile.pre.in anymore
	# it probably shouldn't - use DistUtils, people!
	insinto /usr/lib/python${PYVER}/config
	doins ${S}/Makefile.pre.in

	# While we're working on the config stuff... Let's fix the OPT var
	# so that it doesn't have any opts listed in it. Prevents the problem
	# with compiling things with conflicting opts later.
	dosed -e 's:^OPT=.*:OPT=-DNDEBUG:' /usr/lib/python${PYVER}/config/Makefile

	# If USE tcltk lets install idle
	# Need to script the python version in the path
	if use tcltk; then
		dodir /usr/lib/python${PYVER}/tools
		cp -r "${S}/Tools/idle" "${D}/usr/lib/python${PYVER}/tools/"
		dosym /usr/lib/python${PYVER}/tools/idle/idle.py /usr/bin/idle.py
	fi
	use ncurses || rm -rf ${D}/usr/lib/python${PYVER}/curses
}

pkg_postinst() {
	python_makesym
	PYTHON_OVERRIDE_PYVER="2.2" python_mod_optimize
	PYTHON_OVERRIDE_PYVER="2.2" python_mod_optimize -x site-packages -x test ${ROOT}usr/lib/python${SLOT}
}

pkg_postrm() {
	python_makesym
	python_mod_cleanup /usr/lib/python2.2
}
