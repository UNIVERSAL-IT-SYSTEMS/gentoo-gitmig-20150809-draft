# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sinatra/sinatra-1.3.2.ebuild,v 1.1 2012/03/18 12:27:28 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 ree18"

# no documentation is generable, it needs hanna, which is broken
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README.rdoc AUTHORS CHANGES"

inherit ruby-fakegem

DESCRIPTION="Sinatra is a DSL for quickly creating web applications in Ruby with minimal effort."
HOMEPAGE="http://www.sinatrarb.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_rdepend "=dev-ruby/rack-1* >=dev-ruby/rack-1.3.6
	>=dev-ruby/rack-protection-1.2:1
	=dev-ruby/tilt-1* >=dev-ruby/tilt-1.3.3"
ruby_add_bdepend "test? ( >=dev-ruby/rack-test-0.5.6 >=dev-ruby/haml-3.0 dev-ruby/erubis dev-ruby/builder )"
