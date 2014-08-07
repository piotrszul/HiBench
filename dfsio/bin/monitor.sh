#!/bin/bash

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
PIDS=""

for i in {3..6}
do 
	(ssh root@hadoop1-0$i-cdc.it.csiro.au dstat -Nlo,eth0,ib2,total -Dsdb,sdc,sdd,sde,total 5 > ../dstat/dstat-0${i}_$TIMESTAMP.log) & 
	PIDS="$PIDS $!"	
done

echo $PIDS

bash $@

kill $PIDS


