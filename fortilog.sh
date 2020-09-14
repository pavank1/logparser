#!/bin/bash
PROGNAME=$(basename $0)

function error_exit
{
#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------
	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	exit 1
}
function clean_up {

	# Perform program exit housekeeping
	rm /Infa/ejxml/applog/load/forti/*.log
	exit
}

trap clean_up SIGHUP SIGINT SIGTERM


/bin/rem /Infa/ejxml/applog/load/forti/*.log
/bin/rem /Infa/ejxml/applog/load/forti/*.csv
cd /Infa/ejxml/applog/forti/`/bin/date -d "$(date +%Y%m%d) -1 days" +%d%m%Y`
if [ "$?" = "0" ]; then
	/bin/cat e* > /Infa/ejxml/applog/load/forti/events.log
	/bin/cat E* >> /Infa/ejxml/applog/load/forti/events.log
	/bin/cat a* > /Infa/ejxml/applog/load/forti/antivirus.log
	/bin/cat A* >> /Infa/ejxml/applog/load/forti/antivirus.log

	/bin/cat i* > /Infa/ejxml/applog/load/forti/ips.log
	/bin/cat I* >> /Infa/ejxml/applog/load/forti/ips.log

	/Infa/ejxml/applog/script/logparser_fort.pl -I /Infa/ejxml/applog/load/forti/events.log -O /Infa/ejxml/applog/load/forti/events.csv -C /Infa/ejxml/applog/script/field_type_events.conf
	/Infa/ejxml/applog/script/logparser_fort.pl -I /Infa/ejxml/applog/load/forti/ips.log -O /Infa/ejxml/applog/load/forti/ips.csv -C /Infa/ejxml/applog/script/field_type_ips.conf
	/Infa/ejxml/applog/script/logparser_fort.pl -I /Infa/ejxml/applog/load/forti/antivirus.log -O /Infa/ejxml/applog/load/forti/antivirus.csv -C /Infa/ejxml/applog/script/field_type_antiv.conf	

else
	error_exit "$LINENO: Cannot change directory! Aborting" 1>&2
fi

