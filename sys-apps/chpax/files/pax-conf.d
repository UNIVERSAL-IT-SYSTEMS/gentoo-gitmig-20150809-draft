####################################################################
#         Copyright 1999-2003 Gentoo Technologies, Inc.            #
# Distributed under the terms of the GNU General Public License v2 #
####################################################################
#
# p	do not enforce paging based non-executable pages
# e	do not emulate trampolines
# r	do not randomize mmap() base [ELF only]
# m	do not restrict mprotect()
# s	do not enforce segmentation based non-executable pages
# x	do not randomize ET_EXEC base [ELF only]

PAGEEXEC_EXEMPT="/usr/X11R6/bin/XFree86 /usr/lib/wine/bin/wine /opt/blackdown-jdk-*/jre/bin/[a-z]*"
TRAMPOLINE_EXEMPT=""
MPROTECT_EXEMPT="/opt/blackdown-jdk-*/jre/bin/[a-z]*"
RANDMMAP_EXEMPT=""
SEGMEXEC_EXEMPT="/usr/X11R6/bin/xinit /usr/X11R6/bin/XFree86 /opt/blackdown-jdk-*/jre/bin/[a-z]* /usr/bin/xmms /usr/bin/mplayer /usr/bin/blender /usr/bin/gxine /usr/bin/totem /usr/bin/acme"
RANDEXEC_EXEMPT=""

# when zero flag mask is set to "yes" it will remove all pax flags from all files on reboot/stop
ZERO_FLAG_MASK=no
