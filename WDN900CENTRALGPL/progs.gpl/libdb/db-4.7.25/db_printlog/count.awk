# $Id: count.awk,v 1.1.1.1 2009/10/09 03:02:13 jack Exp $
#
# Print out the number of log records for transactions that we
# encountered.

/^\[/{
	if ($5 != 0)
		print $5
}
