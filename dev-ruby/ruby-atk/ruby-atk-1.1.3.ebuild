# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-atk/ruby-atk-1.1.3.ebuild,v 1.1 2012/04/17 05:30:54 graaff Exp $

EAPI="2"
USE_RUBY="ruby18 ruby19 ree18"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby Atk bindings"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="${DEPEND} dev-libs/atk"
RDEPEND="${RDEPEND} dev-libs/atk"

ruby_add_rdepend ">=dev-ruby/ruby-glib2-${PV}"
