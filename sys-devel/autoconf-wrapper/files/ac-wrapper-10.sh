#!/bin/sh
# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autoconf-wrapper/files/ac-wrapper-10.sh,v 1.2 2010/09/24 02:20:33 vapier Exp $

# Based on the ac-wrapper.pl script provided by MandrakeSoft
# Rewritten in bash by Gregorio Guidi
#
# Executes the correct autoconf version.
#
# - defaults to newest version available (hopefully autoconf-2.60)
# - runs autoconf 2.13 if:
#   - envvar WANT_AUTOCONF is set to `2.1'
#     -or-
#   - `ac{local,include}.m4' or `configure.{in,ac}' have AC_PREREQ(2.1) (not higher)
#     -or-
#   - `configure' is already present and was generated by autoconf 2.13

warn() { printf "ac-wrapper: $*\n" 1>&2; }
err() { warn "$@"; exit 1; }

if [ "${0##*/}" = "ac-wrapper.sh" ] ; then
	err "Don't call this script directly"
fi

if [ "${WANT_AUTOCONF}" = "2.1" ] && [ "${0##*/}" = "autom4te" ] ; then
	err "Autoconf 2.13 doesn't contain autom4te.\n" \
	    "   Either unset WANT_AUTOCONF or don't execute anything\n" \
	    "   that would use autom4te."
fi

if ! seq 0 0 2>/dev/null 1>&2 ; then #338518
	seq() {
		local f l i
		case $# in
			1) f=1 i=1 l=$1;;
			2) f=$1 i=1 l=$2;;
			3) f=$1 i=$2 l=$3;;
		esac
		while :; do
			[ $l -lt $f -a $i -gt 0 ] && break
			[ $f -lt $l -a $i -lt 0 ] && break
			echo $f
			: $(( f += i ))
		done
		return 0
	}
fi

#
# Set up bindings between actual version and WANT_AUTOCONF
#
vers="$(printf '2.%s:2.5 ' `seq 99 -1 59`) 2.13:2.1"

binary=""
for v in ${vers} ; do
	auto_ver=${v%:*}
	if [ -z "${binary}" ] && [ -x "${0}-${auto_ver}" ] ; then
		binary="${0}-${auto_ver}"
	fi
done
if [ -z "${binary}" ] ; then
	err "Unable to locate any usuable version of autoconf.\n" \
	    "\tI tried these versions: ${vers}\n" \
	    "\tWith a base name of '${0}'."
fi

#
# Check the WANT_AUTOCONF setting.  We accept a whitespace delimited
# list of autoconf versions.
#
if [ -n "${WANT_AUTOCONF}" ] ; then
	for v in ${vers} x ; do
		if [ "${v}" = "x" ] ; then
			warn "warning: invalid WANT_AUTOCONF '${WANT_AUTOCONF}'; ignoring."
			unset WANT_AUTOCONF
			break
		fi

		auto_ver=${v%:*}
		want_ver=${v#*:}
		for wx in ${WANT_AUTOCONF} ; do
			if [ "${wx}" = "${want_ver}" ] && [ -x "${0}-${auto_ver}" ] ; then
				binary="${0}-${auto_ver}"
				v="x"
			fi
		done
		[ "${v}" = "x" ] && break
	done
fi

#
# autodetect helpers
#
acprereq_version() {
	gawk \
	'($0 !~ /^[[:space:]]*(#|dnl)/) {
		if (match($0, "AC_PREREQ\\(\\[?([0-9]\\.[0-9])", res))
			VERSIONS[COUNT++] = res[1]
	}

	END {
		asort(VERSIONS)
		print VERSIONS[COUNT]
	}' "$@"
}

generated_version() {
	gawk \
	'{
		if (match($0,
		          "^# Generated (by (GNU )?Autoconf|automatically using autoconf version) ([0-9].[0-9])",
		          res)) {
			print res[3]
			exit
		}
	}' "$@"
}

#
# autodetect routine
#
if [ "${WANT_AUTOCONF}" = "2.1" ] && [ -f "configure.ac" ] ; then
	err "Since configure.ac is present, aclocal always use\n" \
	    "\tautoconf 2.59+, which conflicts with your choice and\n" \
	    "\tcauses error. You have two options:\n" \
	    "\t1. Try execute command again after removing configure.ac\n" \
	    "\t2. Don't set WANT_AUTOCONF"
fi

if [ "${WANT_AUTOCONF}" != "2.5" ] && [ -n "${WANT_AUTOMAKE}" ] ; then
	# Automake-1.7 and better require autoconf-2.5x so if WANT_AUTOMAKE
	# is set to an older version, let's do some sanity checks.
	case "${WANT_AUTOMAKE}" in
	1.[456])
		acfiles=$(ls ac{local,include}.m4 configure.{in,ac} 2>/dev/null)
		[ -n "${acfiles}" ] && confversion=$(acprereq_version ${acfiles})
		
		[ -z "${confversion}" ] && [ -r "configure" ] \
			&& confversion=$(generated_version configure)

		if [ "${confversion}" = "2.1" ] && [ ! -f "configure.ac" ] ; then
			binary="${0}-2.13"
		fi
	esac
fi

if [ -n "${WANT_ACWRAPPER_DEBUG}" ] ; then
	if [ -n "${WANT_AUTOCONF}" ] ; then
		warn "DEBUG: WANT_AUTOCONF is set to ${WANT_AUTOCONF}"
	fi
	warn "DEBUG: will execute <${binary}>"
fi

#
# for further consistency
#
for v in ${vers} ; do
	auto_ver=${v%:*}
	want_ver=${v#*:}
	if [ "${binary}" = "${0}-${auto_ver}" ] ; then
		export WANT_AUTOCONF="${want_ver}"
	fi
done

#
# Now try to run the binary
#
if [ ! -x "${binary}" ] ; then
	# this shouldn't happen
	err "${binary} is missing or not executable.\n" \
	    "\tPlease try emerging the correct version of autoconf."
fi

exec "${binary}" "$@"

err "was unable to exec ${binary} !?"
