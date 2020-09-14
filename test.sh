#!/bin/bash
##cd /Infa/ejxml/applog/`/bin/date -d "$(date +%Y%m%d) -1 days" +%d%m%Y`
cd /Infa/ejxml/applog/10012012
##/bin/cat app* >> /Infa/ejxml/applog/load/pluapplog.log
/bin/cat app* >> /Infa/ejxml/applog/10012012/pluapplog.log
/bin/cat sys* >> /plusyslog.log
/bin/cat sec* >> pluseclog.log

/Infa/ejxml/applog/script/logparser_app.pl -I pluapplog.log -O /Infa/ejxml/applog/load/pluapplog.csv
/Infa/ejxml/applog/script/logparser.pl -I plusyslog.log -O /Infa/ejxml/applog/load/plusyslog.csv
/Infa/ejxml/applog/script/logparser.pl -I pluseclog.log -O /Infa/ejxml/applog/load/pluseclog.csv

