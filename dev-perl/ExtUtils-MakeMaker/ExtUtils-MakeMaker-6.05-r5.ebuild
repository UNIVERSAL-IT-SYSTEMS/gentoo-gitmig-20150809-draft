# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ExtUtils-MakeMaker/ExtUtils-MakeMaker-6.05-r5.ebuild,v 1.11 2005/01/04 12:59:40 mcummings Exp $

DESCRIPTION="MakeMaker Perl Module"
SRC_URI="mirror://cpan/authors/id/M/MS/MSCHWERN/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~mschwern/${P}/"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 sparc ppc alpha mips hppa"

DEPEND=">=dev-lang/perl-5.6.1-r10 >=sys-apps/sed-4"

src_compile() {
	perl Makefile.PL ${myconf} PREFIX=${D}/usr || die
}

src_install () {
	perlinfo
	dodir ${POD_DIR}

	test -z ${mytargets} && mytargets="install"
	make \
		PREFIX=${D}/usr \
		INSTALLMAN1DIR=${D}/usr/share/man/man1 \
		INSTALLMAN2DIR=${D}/usr/share/man/man2 \
		INSTALLMAN3DIR=${D}/usr/share/man/man3 \
		INSTALLMAN4DIR=${D}/usr/share/man/man4 \
		INSTALLMAN5DIR=${D}/usr/share/man/man5 \
		INSTALLMAN6DIR=${D}/usr/share/man/man6 \
		INSTALLMAN7DIR=${D}/usr/share/man/man7 \
		INSTALLMAN8DIR=${D}/usr/share/man/man8 \
		INSTALLSITEMAN1DIR=${D}/usr/share/man/man1 \
		INSTALLSITEMAN2DIR=${D}/usr/share/man/man2 \
		INSTALLSITEMAN3DIR=${D}/usr/share/man/man3 \
		INSTALLSITEMAN4DIR=${D}/usr/share/man/man4 \
		INSTALLSITEMAN5DIR=${D}/usr/share/man/man5 \
		INSTALLSITEMAN6DIR=${D}/usr/share/man/man6 \
		INSTALLSITEMAN7DIR=${D}/usr/share/man/man7 \
		INSTALLSITEMAN8DIR=${D}/usr/share/man/man8 \
		INSTALLSITEARCH=${D}/${SITE_ARCH} \
		INSTALLSCRIPT=${D}/usr/bin \
		${myinst} \
		${mytargets} || die

	if [ -f ${D}${ARCH_LIB}/perllocal.pod ];
	then
		touch ${D}/${POD_DIR}/${P}.pod
		sed -e "s:${D}::g" ${D}${ARCH_LIB}/perllocal.pod \
			>> ${D}/${POD_DIR}/${P}.pod
		touch ${D}/${POD_DIR}/${P}.pod.arch
		cat ${D}/${POD_DIR}/${P}.pod >>${D}/${POD_DIR}/${P}.pod.arch
		rm -f ${D}/${ARCH_LIB}/perllocal.pod
	fi
	if [ -f ${D}${SITE_LIB}/perllocal.pod ];
	then
		touch ${D}/${POD_DIR}/${P}.pod
		sed -e "s:${D}::g" ${D}${SITE_LIB}/perllocal.pod \
			>> ${D}/${POD_DIR}/${P}.pod
		touch ${D}/${POD_DIR}/${P}.pod.site
		cat ${D}/${POD_DIR}/${P}.pod >>${D}/${POD_DIR}/${P}.pod.site
		rm -f ${D}/${SITE_LIB}/perllocal.pod
	fi

	for FILE in `find ${D} -type f -name "*.html" -o -name ".packlist"`; do
		sed -i -e "s:${D}:/:g" ${FILE}
	done

	dodoc Change* MANIFEST* README* ${mydoc}
}

pkg_setup() {

	perlinfo
}


pkg_preinst() {

	perlinfo
}

pkg_postinst() {

	updatepod
}

pkg_prerm() {

	updatepod
}

pkg_postrm() {

	updatepod
}

perlinfo() {

	if [ -f /usr/bin/perl ]
	then
		eval `perl '-V:installarchlib'`
		eval `perl '-V:installsitearch'`
		ARCH_LIB=${installarchlib}
		SITE_LIB=${installsitearch}

		eval `perl '-V:version'`
		POD_DIR="/usr/share/perl/gentoo-pods/${version}"
	fi

}

updatepod() {
	perlinfo

	if [ -d "${POD_DIR}" ]
	then
		for FILE in `find ${POD_DIR} -type f -name "*.pod.arch"`; do
		   cat ${FILE} >> ${ARCH_LIB}/perllocal.pod
		   rm -f ${FILE}
		done
		for FILE in `find ${POD_DIR} -type f -name "*.pod.site"`; do
		   cat ${FILE} >> ${SITE_LIB}/perllocal.pod
		   rm -f ${FILE}
		done

		#cat ${POD_DIR}/*.pod.arch >> ${ARCH_LIB}/perllocal.pod
		#cat ${POD_DIR}/*.pod.site >> ${SITE_LIB}/perllocal.pod
		#rm -f ${POD_DIR}/*.pod.site
		#rm -f ${POD_DIR}/*.pod.site
	fi
}
