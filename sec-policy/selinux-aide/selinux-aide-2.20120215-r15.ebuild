# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-aide/selinux-aide-2.20120215-r15.ebuild,v 1.1 2012/07/26 13:07:32 swift Exp $
EAPI="4"

IUSE=""
MODS="aide"
BASEPOL="2.20120215-r15"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for aide"

KEYWORDS="~amd64 ~x86"
