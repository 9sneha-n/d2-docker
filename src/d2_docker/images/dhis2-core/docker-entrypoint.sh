#!/bin/bash
set -e

WARFILE=/usr/local/tomcat/webapps/ROOT.war
TOMCATDIR=/usr/local/tomcat
DHIS2HOME=/DHIS2_home
DATA_DIR="/data/"

if [ "$(id -u)" = "0" ]; then
    if [ -f $WARFILE ]; then
        unzip $WARFILE -d $TOMCATDIR/webapps/ROOT
        rm $WARFILE
    fi
    
    chown -R tomcat:tomcat $DATA_DIR $TOMCATDIR
    chmod -R u+rwX,g+rX,o-rwx $DATA_DIR $TOMCATDIR
    chown -R tomcat:tomcat \
    $DATA_DIR \
    $TOMCATDIR/temp \
    $TOMCATDIR/work \
    $TOMCATDIR/logs
    
    chown -R tomcat:tomcat $DHIS2HOME
    exec su-exec tomcat "$0" "$@"
fi

exec "$@"
