# kernel.eclass rewrite for a clean base regarding the 2.6 series of kernel
# with back-compatibility for 2.4

# added functionality:
# unipatch		- a flexible, singular method to extract, add and remove patches.

# A Couple of env vars are available to effect usage of this eclass
# These are as follows:
#
# K_NOSETEXTRAVERSION	- if this is set then EXTRAVERSION will not be automatically set within the kernel Makefile
# K_NOUSENAME		- if this is set then EXTRAVERSION will not include the first part of ${PN} in EXTRAVERSION
# UNIPATCH_LIST		- space delimetered list of patches to be applied to the kernel
# UNIPATCH_DOCS		- space delimemeted list of docs to be installed to the doc dir

ECLASS="kernel-2"
EXPORT_FUNCTIONS src_unpack src_compile src_install pkg_preinst pkg_postinst

HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/" 
LICENSE="GPL-2"
IUSE="${IUSE} build"
SLOT="${KV}"

# capture the sources type and set depends
if [ "${ETYPE}" == "sources" ]
then
	#console-tools is needed to solve the loadkeys fiasco; binutils version needed to avoid Athlon/PIII/SSE assembler bugs.
	DEPEND="!build? ( sys-apps/sed
		>=sys-devel/binutils-2.11.90.0.31 )"

	RDEPEND="${DEPEND}
		 !build? ( >=sys-libs/ncurses-5.2
		dev-lang/perl
		virtual/modutils
		sys-devel/make )"
 
	PROVIDE="virtual/linux-sources virtual/alsa"

elif [ "${ETYPE}" == "headers" ]
then
	PROVIDE="virtual/kernel virtual/os-headers"
else
	eerror "Unknown ETYPE=\"${ETYPE}\", must be either \"sources\" or \"headers\""
	die
fi

# Grab kernel version from KV
KV_MAJOR=$(echo ${KV} | cut -d. -f1)
KV_MINOR=$(echo ${KV} | cut -d. -f2)
KV_PATCH=$(echo ${KV} | cut -d. -f3)
KV_PATCH=${KV_PATCH/[-_]*/}

# set LINUX_HOSTCFLAGS if not already set
[ -z "$LINUX_HOSTCFLAGS" ] && LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -Os -fomit-frame-pointer -I${S}/include"


#eclass functions only from here onwards.
#==============================================================
kernel_is_2_4() {
	[ ${KV_MAJOR} -eq 2 -a ${KV_MINOR} -eq 4 ] && return 0 || return 1
}

kernel_is_2_6() {
	[ ${KV_MAJOR} -eq 2 -a ${KV_MINOR} -eq 5 -o ${KV_MINOR} -eq 6 ] && return 0 || return 1
}


# Unpack functions
#==============================================================
unpack_2_4() {
	cd ${S}
	# this file is required for other things to build properly, 
	# so we autogenerate it
	make mrproper || die "make mrproper died"
	make include/linux/version.h || die "make include/linux/version.h failed"
	echo ">>> version.h compiled successfully."
}

universal_unpack() {
	# remove all backup files
	find . -iname "*~" -exec rm {} \; 2> /dev/null

	if [ -d "${S}/Documentation/DocBook" ]
	then
		cd ${S}/Documentation/DocBook
		sed -e "s:db2:docbook2:g" Makefile > Makefile.new \
			&& mv Makefile.new Makefile
		cd ${S}
	fi
}

unpack_set_extraversion() {
	# Gentoo Linux uses /boot, so fix 'make install' to work properly and fix EXTRAVERSION
	cd ${S}
	mv Makefile Makefile.orig
	sed	-e 's:#export\tINSTALL_PATH:export\tINSTALL_PATH:' \
		-e "s:^\(EXTRAVERSION =\).*:\1 ${EXTRAVERSION}:" \
		Makefile.orig > Makefile
	rm Makefile.orig
}

# Compile Functions
#==============================================================
compile_headers() {
	local MY_ARCH
	
	MY_ARCH=${ARCH}
	unset ${ARCH}
	yes "" | make oldconfig
	echo ">>> make oldconfig complete"
	ARCH=${MY_ARCH}	
}

# install functions
#==============================================================
install_universal() {
	#fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R root:root *
	chmod -R a+r-w+X,u+w *
}

install_headers() {
	[ $(kernel_is_2_4) $? == 0 ] && unpack_2_4

	cd ${S}
	dodir /usr/include/linux
	cp -ax ${S}/include/linux/* ${D}/usr/include/linux
	rm -rf ${D}/usr/include/linux/modules
	dodir /usr/include/asm
	cp -ax ${S}/include/asm/* ${D}/usr/include/asm
}

install_sources() {
		local doc
		local docs

		cd ${S}
		dodir /usr/src
		echo ">>> Copying sources..."
		if [ -d "${WORKDIR}/${KV}/docs/" ]
		then
			for file in $(ls -1 ${WORKDIR}/${KV}/docs/)
			do
				echo "XX_${file}*" >> ${S}/patches.txt
				cat ${WORKDIR}/${KV}/docs/${file} >> ${S}/patches.txt
				echo "" >> ${S}/patches.txt
			done
		fi
		
		if [ ! -f ${S}/patches.txt ]
		then
			# patches.txt is empty so lets use our ChangeLog
			[ -f ${FILESDIR}/../ChangeLog ] && echo "Please check the ebuild ChangeLog for more details." > ${S}/patches.txt
		fi

		for doc in ${UNIPATCH_DOCS}
		do
			[ -f ${doc} ] && docs="${docs} ${doc}"
		done

		if [ -f ${S}/patches.txt ]; then
			docs="${docs} ${S}/patches.txt"
		fi
		dodoc ${docs}
		mv ${WORKDIR}/linux* ${D}/usr/src
}

# pkg_preinst functions
#==============================================================
preinst_headers() {
		[ -L ${ROOT}usr/include/linux ] && rm ${ROOT}usr/include/linux
		[ -L ${ROOT}usr/include/asm ] && rm ${ROOT}usr/include/asm
}

# pkg_postinst functions
#==============================================================
postinst_sources() {
	if [ ! -h ${ROOT}usr/src/linux ]
	then
		ln -sf ${ROOT}usr/src/linux-${KV} ${ROOT}usr/src/linux
	fi

	# Don't forget to make directory for sysfs
	[ ! -d "${ROOT}/sys" -a $(kernel_is_2_6) $? == 0 ] && mkdir /sys

	echo
	einfo "After installing a new kernel of any version, it is important"
	einfo "that you have the appropriate /etc/modules.autoload.d/kernel-X.Y"
	einfo "created (X.Y is the first 2 parts of your new kernel version)"
	echo
	einfo "For example, this kernel will require:"
	einfo "/etc/modules.autoload.d/kernel-${KV_MAJOR}.${KV_MINOR}"
	echo
}

# unipatch
#==============================================================
unipatch() {
	local i
	local x
	local extention
	local PIPE_CMD
	local UNIPATCH_EXCLUDE
	local KPATCH_DIR
	local PATCH_DEPTH

	[ -z "${KPATCH_DIR}" ] && KPATCH_DIR="${WORKDIR}/patches/"
	[ ! -d ${KPATCH_DIR} ] && mkdir -p ${KPATCH_DIR}

	# This function will unpack all passed tarballs, add any passed patches, and remove any passed patchnumbers
	# usage can be either via an env var or by params
	[ -z "${UNIPATCH_LIST}" ] && UNIPATCH_LIST="${@}"

	#unpack any passed tarballs
	for i in ${UNIPATCH_LIST}
	do
		if [ -n "$(echo ${i} | grep -e ".tar" -e ".tbz" -e ".tgz")" ]
		then
			extention=${i/*./}
			case ${extention} in
				tbz2) PIPE_CMD="tar -xvjf";;
				 bz2) PIPE_CMD="tar -xvjf";;
				 tgz) PIPE_CMD="tar -xvzf";;
				  gz) PIPE_CMD="tar -xvzf";;
				   *) eerror "Unrecognized tarball compression"
				      die "Unrecognized tarball compression";;
			esac

			${PIPE_CMD} ${i} -C ${KPATCH_DIR} 1>/dev/null
			if [ $? == 0 ]
			then
				einfo "${i/*\//} unpacked"
			else
				eerror "Failed to unpack ${i}"
				die "unable to unpack patch tarball"
			fi

			UNIPATCH_LIST="${UNIPATCH_LIST/${i}/}"
		fi
	done

	#so now everything is unpacked, lets work out whats to be dropped and whats to be included.
	for i in ${UNIPATCH_LIST}
	do
		extention=${i/*./}
		PIPE_CMD=""
		case ${extention} in
			    bz2) PIPE_CMD="bzip2 -dc";;
			  patch) PIPE_CMD="cat";;
			 gz|Z|z) PIPE_CMD="gzip -dc";;
			ZIP|zip) PIPE_CMD="unzip -p";;
			      *) UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} ${i}";;
		esac
		[ -n "${PIPE_CMD}" ] && ${PIPE_CMD} ${i} > ${KPATCH_DIR}/${i/*\//}.patch
	done

	#populate KPATCH_DIRS so we know where to look to remove the excludes
	x=${KPATCH_DIR}
	KPATCH_DIR=""
	for i in $(find ${x} -type d)
	do
		KPATCH_DIR="${KPATCH_DIR} ${i}"
	done

	#so now lets get rid of the patchno's we want to exclude
	for i in ${UNIPATCH_EXCLUDE}
	do
		for x in ${KPATCH_DIR}
		do
			rm ${x}/${i}_* 2>/dev/null
			if [ $? == 0 ]
			then
				einfo "Excluding Patch #${i}"
				einfo "From: ${x/${WORKDIR}/}"
			fi
		done
	done

	# and now, finally, we patch it :)
	for x in ${KPATCH_DIR}
	do
		for i in $(find ${x} -maxdepth 1 -iname "*.patch" | sort -u)
		do


			PATCH_DEPTH=0
			ebegin "Applying ${i/*\//}"
			while [ ${PATCH_DEPTH} -lt 5 ]
			do
				if (patch -p${PATCH_DEPTH} --dry-run -f < ${i} >/dev/null)
				then
					$(patch -p${PATCH_DEPTH} -f < ${i} >/dev/null)
					if [ "$?" -eq 0 ]
					then
						eend 0
						break
					else
						eend 1
						eerror "Failed to apply patch ${i/*\//}"
						die "Failed to apply ${i/*\//}"
					fi
				else
					PATCH_DEPTH=$((${PATCH_DEPTH} + 1))
				fi
			done
			if [ ${PATCH_DEPTH} -eq 5 ]
			then
				eend 1
				die "Unable to dry-run patch."
			fi


		done
	done
}

# custom functions
#==============================================================
detect_version() {
	# this function will detect and set
	# - OKV: Original Kernel Version (2.6.0/2.6.0-test11)
	# - KV: Kernel Version (2.6.0-gentoo/2.6.0-test11-gentoo-r1)
	# - EXTRAVERSION: The additional version appended to OKV (-gentoo/-gentoo-r1)
	
	OKV=${PV/_beta/-test}
	OKV=${OKV/_rc/-rc}
	OKV=${OKV/_pre*/}
	OKV=${OKV/-r*/}
	
	KV_MAJOR=$(echo ${OKV} | cut -d. -f1)
	KV_MINOR=$(echo ${OKV} | cut -d. -f2)
	KV_PATCH=$(echo ${OKV} | cut -d. -f3)
	KV_PATCH=${KV_PATCH/[-_]*/}	
	
	KERNEL_URI="mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/linux-${OKV}.tar.bz2"
	
	RELEASE=${PV/${OKV}/}
	RELEASE=${RELEASE/_beta/}
	RELEASE=${RELEASE/_rc/-rc}
	RELEASE=${RELEASE/_pre/-bk}
	RELEASETYPE=${RELEASE//[0-9]/}
	
	EXTRAVERSION="${RELEASE}"
	[ -z "${K_NOUSENAME}" ] && EXTRAVERSION="${EXTRAVERSION}-${PN/-*/}"
	[ ! "${PR}" == "r0" ] && EXTRAVERSION="${EXTRAVERSION}-${PR}"
	
	KV=${OKV}${EXTRAVERSION}
	
	# -rcXX-bkXX pulls are *IMPOSSIBLE* to support within the portage naming convention
	# these cannot be supported, but the code here can handle it up until this point
	# and theoretically thereafter.
	
	if [ "${RELEASETYPE}" == "-rc" ]
	then
		OKV="${KV_MAJOR}.${KV_MINOR}.$([ $((${KV_PATCH} - 1)) -lt 0 ] && echo ${KV_PATCH} || echo $((${KV_PATCH} - 1)))"
		KERNEL_URI="mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/testing/patch-${PV//_/-}.bz2
			    mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/linux-${OKV}.tar.bz2"
		UNIPATCH_LIST="${DISTDIR}/patch-${PV//_/-}.bz2 ${UNIPATCH_LIST}"
		KV=${PV/[-_]*/}${EXTRAVERSION}
	fi
	
	if [ "${RELEASETYPE}" == "-bk" ]
	then
		OKV="${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}"
		KERNEL_URI="mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/snapshots/patch-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}${RELEASE}.bz2
			    mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/linux-${OKV}.tar.bz2"
		UNIPATCH_LIST="${DISTDIR}/patch-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}${RELEASE}.bz2 ${UNIPATCH_LIST}"
		KV=${PV/[-_]*/}${EXTRAVERSION}
	fi
	
	if [ "${RELEASETYPE}" == "-rc-bk" ]
	then
		OKV="${KV_MAJOR}.${KV_MINOR}.$((${KV_PATCH} - 1))-${RELEASE/-bk*}"
		EXTRAVERSION="$([ -n "${RELEASE}" ] && echo ${RELEASE/*-bk/-bk})$([ -n "${K_USENAME}" ] && echo -${PN/-*/})$([ ! "${PR}" == "r0" ] && echo -${PR})"
		
		KERNEL_URI="mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/snapshots/patch-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}${RELEASE}.bz2
			    mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/linux-${OKV}.tar.bz2"
		UNIPATCH_LIST="${DISTDIR}/patch-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}${RELEASE}.bz2 ${UNIPATCH_LIST}"
		KV=${PV/[-_]*/}${EXTRAVERSION}
	fi
}


# common functions
#==============================================================
src_unpack() {
	[ -z "${OKV}" ] && OKV="${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}"

	cd ${WORKDIR}
	unpack linux-${OKV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die "Unable to move source tree to ${KV}."
	cd ${S}

	universal_unpack
	[ -n "${UNIPATCH_LIST}" ] && unipatch ${UNIPATCH_LIST}
	[ -z "${K_NOSETEXTRAVERSION}" ] && unpack_set_extraversion

	[ $(kernel_is_2_4) $? == 0 ] && unpack_2_4
}

src_compile() {
	[ "${ETYPE}" == "headers" ] && compile_headers
}

pkg_preinst() {
	[ "${ETYPE}" == "headers" ] && preinst_headers
}

src_install() {
	install_universal
	[ "${ETYPE}" == "headers" ] && install_headers
	[ "${ETYPE}" == "sources" ] && install_sources
}

pkg_postinst() {
	[ "${ETYPE}" == "sources" ] && postinst_sources
}
