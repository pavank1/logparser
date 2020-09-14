#!/bin/bash
cd /Infa/ejxml/applog/acs/`/bin/date -d "$(date +%Y%m%d) -1 days" +%d%m%Y`
##cd /Infa/ejxml/applog/10012012

##cat administration.csv > /Infa/ejxml/applog/load/acs/administration.csv
cat admin*.csv > /Infa/ejxml/applog/load/acs/administration.csv
##cat failedattempts.csv > /Infa/ejxml/applog/load/acs/failedattempts.csv
cat fail*.csv > /Infa/ejxml/applog/load/acs/failedattempts.csv
##cat passedauthentications.csv > /Infa/ejxml/applog/load/acs/passedauthentications.csv
cat pass*.csv > /Infa/ejxml/applog/load/acs/passedauthentications.csv
##cat accounting.csv > /Infa/ejxml/applog/load/acs/accounting.csv
cat acc*.csv > /Infa/ejxml/applog/load/acs/accounting.csv
##cat acsadministrationaudit.csv > /Infa/ejxml/applog/load/acs/acsadministrationaudit.csv
cat acs*.csv > /Infa/ejxml/applog/load/acs/acsadministrationaudit.csv

