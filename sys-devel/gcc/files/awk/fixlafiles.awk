# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Author:  Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/files/awk/fixlafiles.awk,v 1.11 2004/07/15 00:59:02 agriffis Exp $

function printn(string)
{
	system("echo -n \"" string "\"")
}

function einfo(string)
{
	system("echo -e \" \\e[32;01m*\\e[0m " string "\"")
}

function einfon(string)
{
	system("echo -ne \" \\e[32;01m*\\e[0m " string "\"")
}

function ewarn(string)
{
	system("echo -e \" \\e[33;01m*\\e[0m " string "\"")
}

function ewarnn(string)
{
	system("echo -ne \" \\e[33;01m*\\e[0m " string "\"")
}
	
function eerror(string)
{
	system("echo -e \" \\e[31;01m*\\e[0m " string "\"")
}

# assert --- assert that a condition is true. Otherwise exit.
# This is from the gawk info manual.
function assert(condition, string)
{
	if (! condition) {
		printf("%s:%d: assertion failed: %s\n",
			FILENAME, FNR, string) > "/dev/stderr"
		_assert_exit = 1
		exit 1
	}
}

# system() wrapper that normalize return codes ...
function dosystem(command,		ret)
{
	ret = 0
 
	ret = system(command)
	if (ret == 0)
		return 1
	else
		return 0
}


BEGIN {

	# Get our variables from environment
	OLDVER = ENVIRON["OLDVER"]
	OLDCHOST = ENVIRON["OLDCHOST"]

	if (OLDVER == "") {
		eerror("Could not get OLDVER!");
		exit 1
	}

	LIBCOUNT = 0
	HAVE_GCC34 = 0
	# Add the two default library paths
	DIRLIST[1] = "/lib"
	DIRLIST[2] = "/usr/lib"

	# Walk /etc/ld.so.conf line for line and get any library paths
	pipe = "cat /etc/ld.so.conf | sort 2>/dev/null"
	while(((pipe) | getline ldsoconf_data) > 0) {

		if (ldsoconf_data !~ /^[[:space:]]*#/) {

			if (ldsoconf_data == "") continue

			# Remove any trailing comments
			sub(/#.*$/, "", ldsoconf_data)
			# Remove any trailing spaces
			sub(/[[:space:]]+$/, "", ldsoconf_data)
	
			split(ldsoconf_data, nodes, /[:,[:space:]]/)

			# Now add the rest from ld.so.conf
			for (x in nodes) {

				sub(/=.*/, "", nodes[x])
				sub(/\/$/, "", nodes[x])

				if (nodes[x] == "") continue

				CHILD = 0

				# Drop the directory if its a child directory of
				# one that was already added ...
				for (y in DIRLIST) {

					if (nodes[x] ~ "^" DIRLIST[y]) {
					
						CHILD = 1
						break
					}
				}

				if (CHILD) continue
		
				DIRLIST[++LIBCOUNT + 2] = nodes[x]
			}
		}
	}

	close(pipe)

# We have no guarantee that ld.so.conf have more library paths than
# the default, and its better to fix .la files only in /lib and
# /usr/lib than not at all ...
#	if (LIBCOUNT == 0) {
#		eerror("Could not read from /etc/ld.so.conf!")
#		exit 1
#	}

	LIBCOUNT += 2

	# Get line from gcc's output containing CHOST
	pipe = "gcc -v 2>&1 | egrep '^Reading specs' 2>/dev/null"

	if ((!((pipe) | getline TMP_CHOST)) || (TMP_CHOST == "")) {
		close(pipe)

		# If we fail to get the CHOST, see if we can get the CHOST
		# portage thinks we are using ...
		pipe = "/usr/bin/portageq envvar 'CHOST'"
		assert(((pipe) | getline CHOST), "(" pipe ") | getline CHOST")
	} else {
		# Check pre gcc-3.4.x versions
		CHOST = gensub("^.+lib/gcc-lib/([^/]+)/[0-9]+.+$", "\\1", 1, TMP_CHOST)

		if (CHOST == TMP_CHOST || CHOST == "") {
			# Check gcc-3.4.x or later
			CHOST = gensub("^.+lib/gcc/([^/]+)/[0-9]+.+$", "\\1", 1, TMP_CHOST);

			if (CHOST == TMP_CHOST || CHOST == "")
				CHOST = ""
			else
				HAVE_GCC34 = 1
		}
	}
	
	close(pipe)

	if (CHOST == "") {
		eerror("Could not get gcc's CHOST!")
		exit 1
	}

	if (OLDCHOST != "")
		if (OLDCHOST == CHOST)
			OLDCHOST = ""

	GCCLIBPREFIX_OLD = "/usr/lib/gcc-lib/"
	GCCLIBPREFIX_NEW = "/usr/lib/gcc/"
	
	if (HAVE_GCC34)
		GCCLIBPREFIX = GCCLIBPREFIX_NEW
	else
		GCCLIBPREFIX = GCCLIBPREFIX_OLD
	
	GCCLIB = GCCLIBPREFIX CHOST
	
	if (OLDCHOST != "") {
		OLDGCCLIB1 = GCCLIBPREFIX_OLD OLDCHOST
		OLDGCCLIB2 = GCCLIBPREFIX_NEW OLDCHOST
	}

	# Get current gcc's version
	pipe = "gcc -dumpversion"
	assert(((pipe) | getline NEWVER), "(" pipe ") | getline NEWVER)")
	close(pipe)

	if (NEWVER == "") {
		eerror("Could not get gcc's version!")
		exit 1
	}

	# Nothing to do ?
	if ((OLDVER == NEWVER) && (OLDCHOST == ""))
		exit 0
	
	for (x = 1;x <= LIBCOUNT;x++) {

		# Do nothing if the target dir is gcc's internal library path
		if (DIRLIST[x] ~ GCCLIBPREFIX_OLD ||
		    DIRLIST[x] ~ GCCLIBPREFIX_NEW)
			continue

		einfo("  Scanning " DIRLIST[x] "...")

		pipe = "find " DIRLIST[x] "/ -name '*.la' 2>/dev/null"
		while (((pipe) | getline la_files) > 0) {

			# Do nothing if the .la file is located in gcc's internal lib path
			if (la_files ~ GCCLIBPREFIX_OLD ||
			    la_files ~ GCCLIBPREFIX_NEW)
				continue

			CHANGED = 0
			CHOST_CHANGED = 0

			# See if we need to fix the .la file
			while ((getline la_data < (la_files)) > 0) {

				if (OLDCHOST != "") {
				
					if ((gsub(OLDGCCLIB1 "[/[:space:]]+",
					          GCCLIB, la_data) > 0) ||
					    (gsub(OLDGCCLIB2 "[/[:space:]]+",
					          GCCLIB, la_data) > 0)) {
					
						CHANGED = 1
						CHOST_CHANGED = 1
					}
				}

				if (OLDVER != NEWVER) {
				
					if ((gsub(GCCLIBPREFIX_OLD CHOST "/" OLDVER "[/[:space:]]*",
					          GCCLIB "/" NEWVER, la_data) > 0) ||
					    (gsub(GCCLIBPREFIX_NEW CHOST "/" OLDVER "[/[:space:]]*",
						      GCCLIB "/" NEWVER, la_data) > 0))
						CHANGED = 1
				}
			}

			close(la_files)

			# Do the actual changes in a second loop, as we can then
			# verify that CHOST_CHANGED among things is correct ...
			if (CHANGED) {

				ewarnn("    FIXING: " la_files " ... ")

				if (CHANGED)
					printn("[")

				# Clear the temp file (removing rather than '>foo' is better
				# out of a security point of view?)
				dosystem("rm -f " la_files ".new")

				while ((getline la_data < (la_files)) > 0) {

					if (OLDCHOST != "") {
					
						tmpstr = gensub(OLDGCCLIB1 "([/[:space:]]+)",
						                GCCLIB "\\1", "g", la_data)
						tmpstr = gensub(OLDGCCLIB2 "([/[:space:]]+)",
						                GCCLIB "\\1", "g", tmpstr)
						
						if (la_data != tmpstr) {
							printn("c")
							la_data = tmpstr
						}

						if (CHOST_CHANGED > 0) {
						
							# We try to be careful about CHOST changes outside
							# the gcc library path (meaning we cannot match it
							# via /GCCLIBPREFIX CHOST/) ...

							# Catch:
							#
							#  dependency_libs=' -L/usr/CHOST/{bin,lib}'
							#
							gsub("-L/usr/" OLDCHOST "/",
							     "-L/usr/" CHOST "/", la_data)
							# Catch:
							#
							#  dependency_libs=' -L/usr/lib/gcc-lib/CHOST/VER/../../../../CHOST/lib'
							#
							la_data = gensub("(" GCCLIB "/[^[:space:]]+)/" OLDCHOST "/",
							              "\\1/" CHOST "/", "g", la_data)
						}
					}

					if (OLDVER != NEWVER) {
					
						tmpstr = gensub(GCCLIBPREFIX_OLD CHOST "/" OLDVER "([/[:space:]]*)",
						                GCCLIB "/" NEWVER "\\1", "g", la_data)
						tmpstr = gensub(GCCLIBPREFIX_NEW CHOST "/" OLDVER "([/[:space:]]*)",
						                GCCLIB "/" NEWVER "\\1", "g", tmpstr)
						
						
						if (la_data != tmpstr) {
							# Catch:
							#
							#  dependency_libs=' -L/usr/lib/gcc-lib/../../CHOST/lib'
							#
							# in cases where we have gcc34
							tmpstr = gensub(GCCLIBPREFIX_OLD "(../../" CHOST "/lib)",
							                GCCLIBPREFIX "\\1", "g", tmpstr)
							tmpstr = gensub(GCCLIBPREFIX_NEW "(../../" CHOST "/lib)",
							                GCCLIBPREFIX "\\1", "g", tmpstr)

							printn("v")
							la_data = tmpstr
						}
					}

					print la_data >> (la_files ".new")
				}

				if (CHANGED)
					print "]"

				close(la_files)
				close(la_files ".new")

				assert(dosystem("mv -f " la_files ".new " la_files),
				       "dosystem(\"mv -f " la_files ".new " la_files "\")")
			}
		}

		close(pipe)
	}
}


# vim:ts=4
