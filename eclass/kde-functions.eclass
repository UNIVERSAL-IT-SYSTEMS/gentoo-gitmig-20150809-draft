# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-functions.eclass,v 1.4 2002/04/13 16:19:51 danarmak Exp $
# This contains everything except things that modify ebuild variables and functions (e.g. $P, src_compile() etc.)
ECLASS=kde-functions

# ---------------------------------------------------------------
# kde/qt directory management etc. functions, was kde-dirs.ebuild
# ---------------------------------------------------------------

need-kde() {

	debug-print-function $FUNCNAME $*
	KDEVER="$1"
	
	min-kde-ver $KDEVER
	newdepend "=kde-base/kdelibs-${selected_version}*"
	set-kdedir $KDEVER

	qtver-from-kdever $KDEVER
	need-qt $selected_version
	
	SLOT="$KDEMAJORVER"

}

set-kdedir() {

	debug-print-function $FUNCNAME $*
	
	case "$1" in
	    2*)	
	    debug-print "$FUNCNAME: requesting autoconf-2.1, automake-1.4 for kde version 2*"
	    export WANT_AUTOCONF_2_1=1
	    export WANT_AUTOMAKE_1_4=1
	    ;;
	    3*)	
	    debug-print "$FUNCNAME: requesting autoconf-2.5, automake-1.4 for kde version 3*"
	    export WANT_AUTOCONF_2_5=1
	    export WANT_AUTOMAKE_1_4=1
	    ;;
	esac
	
	# default settings for older make.globals versions which don't include the default KDE?DIR settings
	[ -z "$KDE2DIR" ] && export KDE2DIR="/usr/kde/2"
	[ -z "$KDE3DIR" ] && export KDE3DIR="/usr/kde/3"
	# not defined at all by default
	[ -z "$KDE2LIBSDIR" ] && export KDE2LIBSDIR="$KDE2DIR" 
	[ -z "$KDE3LIBSDIR" ] && export KDE3LIBSDIR="$KDE3DIR" 
	
	# select 1st element in dot-separated string
	IFSBACKUP=$IFS
	IFS="."
	KDEMAJORVER=""
	for x in $1; do
		[ -z "$KDEMAJORVER" ] && KDEMAJORVER=$x
	done
	IFS=$IFSBACKUP
	
	case $KDEMAJORVER in
	    2) export KDEDIR=${KDE2LIBSDIR};;
	    3) export KDEDIR=${KDE3LIBSDIR};;
	esac
	
	debug-print "$FUNCNAME: result: KDEDIR=$KDEDIR"

}

need-qt() {

	debug-print-function $FUNCNAME $*
	QTVER="$1"
	min-qt-ver $QTVER
	newdepend "=x11-libs/qt-$selected_version*"
	set-qtdir $QTVER

}

set-qtdir() {

	debug-print-function $FUNCNAME $*

	# select 1st element in dot-separated string
	IFSBACKUP=$IFS
	IFS="."
	QTMAJORVER=""
	for x in $1; do
		[ -z "$QTMAJORVER" ] && QTMAJORVER=$x
	done
	IFS=$IFSBACKUP

	export QTDIR="/usr/qt/$QTMAJORVER"

}

# returns minimal qt version needed for specified kde version
qtver-from-kdever() {

	debug-print-function $FUNCNAME $*

	local ver

	case $1 in
		2*)	ver=2.3.1;;
		3*)	ver=3.0.3;;
		*)	echo "!!! error: $FUNCNAME() called with invalid parameter: \"$1\", please report bug" && exit 1;;
	esac

	selected_version="$ver"

}

# compat
need-kdelibs() {
    echo "WARNING: need-kdelibs() called, where need-kde() is correct.
If this happens at the unmerging of an old ebuild, disregard; otherwise report."
    need-kde $*
}

min-kde-ver() {

	debug-print-function $FUNCNAME $*

	case $1 in
	    2*)		selected_version="2.2.2";;
	    3.0_beta1)	selected_version="3.0_beta1";;
	    3.0_beta2)	selected_version="3.0_beta2";;
	    3.0_rc1)	selected_version="3.0_rc1";;
	    3.0_rc2)	selected_version="3.0_rc2";;
	    3.0_rc3)	selected_version="3.0_rc3";;
	    3*)		selected_version="3.0";;
	    *)		echo "!!! error: $FUNCNAME() called with invalid parameter: \"$1\", please report bug" && exit 1;;
	esac
	
}

min-qt-ver() {

	debug-print-function $FUNCNAME $*

	case $1 in
	    2*)	selected_version="2.3";;
	    3*)	selected_version="3";;
	    *)	echo "!!! error: $FUNCNAME() called with invalid parameter: \"$1\", please report bug" && exit 1;;
	esac

}


# generic makefile sed for sandbox compatibility. for some reason when the kde makefiles (of many packages
# and versions) try to chown root and chmod 4755 some binaries (after installing, target isntall-exec-local),
# they do it to the files in $(bindir), not $(DESTDIR)/$(bindir). I've fild a report on bugs.kde.org but no
# response so far.
# Pass a list of dirs to sed, Makefile.{am,in} in these dirs will be sed'ed.
# This should be harmless if the makefile doesn't need fixing.
kde_sandbox_patch() {

    debug-print-function $FUNCNAME $*
    
    while [ -n "$1" ]; do
	# can't use dosed, because it only works for things in ${D}, not ${S}
	cd $1
	for x in Makefile.am Makefile.in Makefile
	do
	    if [ -f "$x" ]; then
		echo Running sed on $x
		cp $x ${x}.orig
		sed -e 's: $(bindir): $(DESTDIR)/$(bindir):g' -e 's: $(kde_datadir): $(DESTDIR)/$(kde_datadir):g' ${x}.orig > ${x}
		rm ${x}.orig
	    fi
	done
	shift
    done

}

