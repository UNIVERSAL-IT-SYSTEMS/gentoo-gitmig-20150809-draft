# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-libart2/ruby-libart2-0.8.1.ebuild,v 1.5 2004/06/25 02:01:10 agriffis Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby Libart2 bindings"
KEYWORDS="~alpha x86 ~ppc"
USE_RUBY="ruby16 ruby18 ruby19"
DEPEND="${DEPEND} >=media-libs/libart_lgpl-2"
RDEPEND="${RDEPEND} >=media-libs/libart_lgpl-2"
