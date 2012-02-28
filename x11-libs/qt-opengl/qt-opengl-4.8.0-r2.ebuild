# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-opengl/qt-opengl-4.8.0-r2.ebuild,v 1.2 2012/02/28 13:30:35 jlec Exp $

EAPI="3"
inherit qt4-build

DESCRIPTION="The OpenGL module for the Qt toolkit"
SLOT="4"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 -sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="egl qt3support"

DEPEND="~x11-libs/qt-core-${PV}[aqua=,c++0x=,qpa=,debug=,qt3support=]
	~x11-libs/qt-gui-${PV}[aqua=,c++0x=,qpa=,debug=,egl=,qt3support=]
	virtual/opengl"
RDEPEND="${DEPEND}"

pkg_setup() {
	QT4_TARGET_DIRECTORIES="
		src/opengl
		src/plugins/graphicssystems/opengl"

	QT4_EXTRACT_DIRECTORIES="
		include/QtCore
		include/QtGui
		include/QtOpenGL
		src/corelib
		src/gui
		src/opengl
		src/plugins
		src/3rdparty"

	QCONFIG_ADD="opengl"
	QCONFIG_DEFINE="QT_OPENGL $(use egl && echo QT_EGL)"
	qt4-build_pkg_setup
}

src_configure() {
	myconf="${myconf} -opengl
		$(qt_use qt3support)
		$(qt_use egl)"

	qt4-build_src_configure

	# Not building tools/designer/src/plugins/tools/view3d as it's
	# commented out of the build in the source
}

src_install() {
	qt4-build_src_install

	#touch the available graphics systems
	mkdir -p "${ED}/usr/share/qt4/graphicssystems/" ||
		die "could not create ${ED}/usr/share/qt4/graphicssystems/"
	echo "experimental" > "${ED}/usr/share/qt4/graphicssystems/opengl" ||
		die "could not touch ${ED}/usr/share/qt4/graphicssystems/opengl"
}
