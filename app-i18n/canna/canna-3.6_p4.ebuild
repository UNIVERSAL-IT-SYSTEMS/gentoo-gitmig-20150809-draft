# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/canna/canna-3.6_p4.ebuild,v 1.2 2003/09/22 20:47:21 usata Exp $

inherit cannadic eutils

IUSE="tetex"

MY_P="Canna36${PV#*_}"

DESCRIPTION="A client-server based Kana-Kanji conversion system"
HOMEPAGE="http://canna.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/canna/6059/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="virtual/glibc
	x11-base/xfree
	>=sys-apps/sed-4
	tetex? ( app-text/ptex
		app-text/dvipdfmx )"
RDEPEND="virtual/glibc"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	find . -name '*.man' -o -name '*.jmn' | xargs sed -i.bak -e 's/1M/8/g'
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	xmkmf || die
	make Makefiles || die
	# make includes
	make canna || die

	if [ -n "`use tetex`" ] ; then
		einfo "Compiling DVI, PS and PDF document"
		cd doc/man/guide/tex
		xmkmf || die
		make JLATEXCMD=platex \
			DVI2PSCMD="dvips -f" \
			canna.dvi canna.ps canna.pdf || die
	fi
}

src_install() {
	make DESTDIR=${D} install || die
	make DESTDIR=${D} install.man || die

	dodir /usr/share/man/man8 /usr/share/man/ja/man8
	for man in cannaserver cannakill ; do
		for mandir in ${D}/usr/share/man ${D}/usr/share/man/ja ; do
			mv ${mandir}/man1/${man}.1 ${mandir}/man8/${man}.8
		done
	done

	dodoc CHANGES.jp ChangeLog INSTALL* README* WHATIS*
	
	if [ -n "`use tetex`" ] ; then
		insinto /usr/share/doc/${PF}
		doins doc/man/guide/tex/canna.{dvi,ps,pdf}
	fi

	exeinto /etc/init.d ; newexe ${FILESDIR}/canna.initd.new canna || die
	insinto /etc/conf.d ; newins ${FILESDIR}/canna.confd canna || die
	insinto /etc/       ; newins ${FILESDIR}/canna.hosts hosts.canna || die
	keepdir /var/log/canna/ || die

	# for backward compatibility
	dosbin ${FILESDIR}/update-canna-dics_dir

	insinto /var/lib/canna/dic/dics.d/
	newins ${D}/var/lib/canna/dic/canna/dics.dir 00canna.dics.dir

	# fix permission for user dictionary
	keepdir /var/lib/canna/dic/{user,group}
	fowners root:bin /var/lib/canna/dic/{user,group}
	fperms 775 /var/lib/canna/dic/{user,group}
}

pkg_prerm () {

	if [ -S /tmp/.iroha_unix/IROHA ] ; then
		einfo
		einfo "Stopping Canna for safe unmerge"
		einfo
		/etc/init.d/canna stop
	fi
}

pkg_postrm () {

	if [ -f /usr/sbin/cannaserver ] ; then
		update-cannadic-dir
		einfo
		einfo "Restarting Canna"
		einfo
		/etc/init.d/canna start
	fi
}
