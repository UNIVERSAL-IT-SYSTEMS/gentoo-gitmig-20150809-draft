# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/util-vserver/util-vserver-0.30.216_pre3011.ebuild,v 1.1 2012/02/17 10:13:52 hollow Exp $

EAPI=4

inherit eutils bash-completion-r1

MY_P=${P/_/-}
S="${WORKDIR}"/${MY_P}

DESCRIPTION="Linux-VServer admin utilities"
HOMEPAGE="http://www.nongnu.org/util-vserver/"
SRC_URI="http://people.linux-vserver.org/~dhozac/t/uv-testing/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~sparc ~x86"

IUSE=""

CDEPEND="dev-libs/beecrypt
	net-firewall/iptables
	net-misc/vconfig
	sys-apps/iproute2
	|| ( >=sys-apps/coreutils-6.10-r1 sys-apps/mktemp )"

DEPEND=">=dev-libs/dietlibc-0.33_pre20110403
	${CDEPEND}"

RDEPEND="${CDEPEND}"

pkg_setup() {
	if [[ -z "${VDIRBASE}" ]]; then
		einfo
		einfo "You can change the default vserver base directory (/vservers)"
		einfo "by setting the VDIRBASE environment variable."
	fi

	: ${VDIRBASE:=/vservers}

	einfo
	einfo "Using \"${VDIRBASE}\" as vserver base directory"
	einfo
}

src_test() {
	# do not use $D from portage by accident (#297982)
	sed -i -e 's/^\$D //' "${S}"/src/testsuite/vunify-test.sh
	default
}

src_configure() {
	econf --with-vrootdir=${VDIRBASE} \
		--with-initscripts=gentoo \
		--localstatedir=/var
}

src_compile() {
	emake || die "emake failed!"
}

src_install() {
	make DESTDIR="${D}" install install-distribution \
		|| die "make install failed!"

	# make sure cgroup is mounted in the right place
	mkdir -p "${D}"/etc/vservers/.defaults/cgroup
	echo /sys/fs/cgroup > "${D}"/etc/vservers/.defaults/cgroup/mnt

	# keep dirs
	keepdir /var/run/vservers
	keepdir /var/run/vservers.rev
	keepdir /var/run/vshelper
	keepdir /var/lock/vservers
	keepdir /var/cache/vservers
	keepdir "${VDIRBASE}"
	keepdir "${VDIRBASE}"/.pkg

	# remove legacy config file
	rm -f "${D}"/etc/vservers.conf

	# bash-completion
	newbashcomp "${FILESDIR}"/bash_completion ${PN}

	dodoc README ChangeLog NEWS AUTHORS THANKS util-vserver.spec
}

pkg_postinst() {
	# Create VDIRBASE in postinst, so it is (a) not unmerged and (b) also
	# present when merging.

	mkdir -p "${VDIRBASE}"
	setattr --barrier "${VDIRBASE}"

	rm /etc/vservers/.defaults/vdirbase
	ln -sf "${VDIRBASE}" /etc/vservers/.defaults/vdirbase

	# make sure cgroup is mounted in the right place
	mkdir -p /etc/vservers/.defaults/cgroup
	echo /sys/fs/cgroup > /etc/vservers/.defaults/cgroup/mnt

	elog
	elog "You have to run the vprocunhide command after every reboot"
	elog "in order to setup /proc permissions correctly for vserver"
	elog "use. An init script has been installed by this package."
	elog "To use it you should add it to a runlevel:"
	elog
	elog " rc-update add vprocunhide default"
	elog
}
