# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/elisp-common.eclass,v 1.1 2003/09/21 01:40:41 mkennedy Exp $
#
# Author Matthew Kennedy <mkennedy@gentoo.org>
#
# This is not an eclass, but it does provide emacs-related
# installation utilities.

ECLASS=elisp-common
INHERITED="$INHERITED $ECLASS"

SITELISP=/usr/share/emacs/site-lisp

elisp-install() {
	local subdir=$1
	dodir ${SITELISP}/${subdir}
	insinto ${SITELISP}/${subdir}
	shift
	doins $@
}

elisp-site-file-install() {
	local sitefile=$1
	pushd ${S}
	cp ${sitefile} .
	D=${S}/ dosed "s:@SITELISP@:${SITELISP}/${PN}:g" $(basename ${sitefile})
	insinto ${SITELISP}
	doins ${S}/$(basename ${sitefile})
	popd
}

elisp-site-regen() {
	einfo "Regenerating ${SITELISP}/site-start.el..."
	einfo ""
	cat <<EOF >${SITELISP}/site-start.el
;;; DO NOT EDIT THIS FILE -- IT IS GENERATED AUTOMATICALLY BY PORTAGE
;;; -----------------------------------------------------------------

EOF
	ls ${SITELISP}/[0-9][0-9]* |sort -n |grep -vE '~$' | \
	while read sf 
	do
		einfo "  Adding $sf..."  
		# Great for debugging, too noisy and slow for users though
# 		echo "(message \"Loading $sf...\")" >>${SITELISP}/site-start.el
		cat $sf >>${SITELISP}/site-start.el
	done
	einfo ""
}

# Local Variables: ***
# mode: shell-script ***
# tab-width: 4 ***
# indent-tabs-mode: t ***
# End: ***
