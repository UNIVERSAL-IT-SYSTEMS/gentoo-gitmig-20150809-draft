#! /usr/bin/python2
# vim: sw=4
#Script by j@falooley.org (Jason Lunz) in the contrib section of pure-ftp

    import getopt
    import pure_ftpwho
    import sys
    from string import capitalize, lower

    def range_idx(list, first = 1, cmp_func = cmp):
	for i in range(first+1, len(list)):
	    if cmp_func(list[first], list[i]):
		return i
	return len(list)
	    
    def dcmp(a, b, key):
	if a.has_key(key):
	    if b.has_key(key):
		return cmp(a[key], b[key])
	    else:
		return 1
	else:
	    if b.has_key(key):
		return -1
	    else:
		return 0

    def multisort(dicts, keys):
	if not keys:
	    return dicts
	dicts.sort(lambda x, y, key=keys[0]: dcmp(x, y, key))
	ret = []
	first = last = 0
	while last < len(dicts):
	    last = range_idx(dicts, first, lambda x, y, k=keys[0]: dcmp(x, y, k))
	    add = multisort(dicts[first:last], keys[1:])
	    if(add):
		ret.extend(add)
	    first = last
	return ret

    def col_heading(key):
	headings = {'pid' : 'PID'}
	if headings.has_key(key):
	    return headings[key]
	else:
	    return capitalize(lower(key))

    def size_abbrev(num, order=-1):
	abbr = ['b', 'K', 'M', 'G', 'T']
	if order == -1:
	    q = 1
	    for i in range(len(abbr)):
		p = pow(1024, i+1)
		if num < p:
		    return (float(num)/q, abbr[i], i)
		q = p
	else:
	    return (float(num)/pow(1024, order), abbr[order], order)

    def celltext(dict, type):
	sizes = ['current_size', 'total_size', 'percentage', 'bandwidth']
	align = ''
	ret = ''
	if type == 'stats':
	    align = ' align="right"'
	    if filter(lambda k, d=dict: d.has_key(k), sizes):
		bw, abbr, order = size_abbrev(dict['bandwidth'])
		if order == 0:
		    format = '%d'
		else:
		    format = '%.1f'
		sf = format + '/' + format
		sf += '&nbsp;%s&nbsp;(%d%%&nbsp;-&nbsp;' + format
		sf += '&nbsp;%s/s)'
		ret = sf % (size_abbrev(dict['current_size'], order)[0],
		    size_abbrev(dict['total_size'], order)[0],
		    abbr, dict['percentage'], bw, abbr)
	elif not dict.has_key(type):
	    ret = '&nbsp;'
	elif type in sizes:
	    ret = size_abbrev(dict[type])
	elif type == 'time':
	    align = ' align="right"'
	    str = ''
	    minutes, seconds = divmod(dict[type], 60)
	    hours, minutes = divmod(minutes, 60)
	    days, hours = divmod(hours, 24)
	    if(days):
		str += '%dd' % days
	    if(hours):
		str += '%02d:' % hours
	    ret = str + '%02d:%02d' % (minutes, seconds)
	else:
	    ret = dict[type]
	return '<td%s>%s</td>' % (align, ret)
	    
    def html(dicts, order, headings, stream, totals):
	sorted = multisort(dicts, order)
	stream.write('''<!DOCTYPE html PUBLIC "-//W3C/DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
    <html>
    <title>Pure-FTPd server status</title>
    <body bgcolor="#ffffff" text="#000000">
    ''')
	if(totals):
	    stream.write('<table cellspacing="4" border="2" cellpadding="4">')
	    stream.write('<tr><th>Account</th><th>Total Bandwidth</th></tr>')
	    for k in totals.keys():
		stream.write('<tr><td>%s</td>' % k)
		stream.write('<td>%d&nbsp;%s/s</td></tr>\n' % size_abbrev(totals[k])[:2])
	    stream.write('</table><BR>\n')
	stream.write('<div align="center">')
	stream.write('<table width="100%" cellspacing="4" border="2" cellpadding="4">')
	for k in headings:
	    stream.write('<th>%s</th>' % col_heading(k))
	stream.write('\n')
	for d in sorted:
	    stream.write('<tr valign="middle">\n')
	    for k in headings:
		stream.write('%s' % celltext(d, k))
	    stream.write('\n</tr>\n')
	stream.write('</table></div></body></html>\n')

    def arg_expand(list, opts):
	optmap = {
	    'A':'account',
	    'B':'bandwidth',
	    'C':'current_size',
	    'F':'file',
	    'H':'host',
	    'L':'localhost',
	    'O':'localport',
	    'P':'percentage',
	    'D':'pid',
	    'R':'resume',
	    'S':'state',
	    'T':'time',
	    'X':'stats',
	    'Z':'total_size' }
	for l in opts:
	    if optmap.has_key(l):
		list.append(optmap[l])
	    else:
		print 'unrecognized column %s' % l
		sys.exit(1)

    def usage():
	print '''usage: html_ftpwho.py [options]
    -c <orderstr>  columns to output	(default "AXTSHF")
    -o <orderstr>  sort order		(default "SABT")
    -t             show totals per account

    <orderstr> is a string of letters, each representing a client attribute:
	A - account
	B - bandwidth
	C - current_size
	F - file
	H - host
	L - localhost
	O - localport
	P - percentage
	D - pid
	R - resume
	S - state
	T - time
	X - stats
	Z - total_size
    '''
	sys.exit(1)

    try:
	optlist, args = getopt.getopt(sys.argv[1:], 'hc:o:t')
    except getopt.error, msg:
	print msg
	usage()

    ord_arg = ''
    col_arg = ''
    show_totals = 0
    for opt in optlist:
	if '-c' == opt[0]:
	    col_arg += opt[1]
	elif '-h' == opt[0]:
	    usage()
	elif '-o' == opt[0]:
	    ord_arg += opt[1]
	elif '-t' == opt[0]:
	    show_totals = 1
	else:
	    print 'unrecognized option "%s"' % opt[0]
	    usage()

    if not ord_arg:
	ord_arg = 'SABT'
    if not col_arg:
	col_arg = 'AXTSHF'
    order = []
    columns = []
    arg_expand(order, ord_arg)
    arg_expand(columns, col_arg)

    cl = pure_ftpwho.clients()
    totals = {}
    if show_totals:
	for c in cl:
	    if c.has_key('bandwidth'):
		try:
		    totals[c['account']] += c['bandwidth']
		except KeyError:
		    totals[c['account']] = c['bandwidth']

    html(cl, order, columns, sys.stdout, totals)

