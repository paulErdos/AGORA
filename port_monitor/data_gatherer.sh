#!/bin/bash
################################################################################
# Author: Vincent Steffens                                                     #
# Date  : 23 September 2014                                                    #
# Email: vsteffen@gmail.com, vincesteffens@gmail.com                           #
#                                                                              #
# The purpose of this file is to gather port usage information for NERSC's     #
# Edison supercomputer. The resulting information is intended to be used to    #
# select infrequently-used ports before starting a server.                     #
#                                                                              #
# Usage:                                                                       #
# $ bash port_usage_data_gatherer.sh                                           #
#                                                                              #
# Output wil be sent to usage_by_time.txt and ports_seen.txt                   #
#                                                                              #
# Return Values:                                                               #
# 0: ports_seen.txt exists in this directory; user chose not to overwrite.     #
#                                                                              #
################################################################################

#See if a file called usage_by_time.txt already exists
array=(`ls | grep 'usage_by_time.txt'`); 

if [[ ${#array[@]} != 0 ]]
then echo "File named \"usage_by_time.txt\" already exists in this \
directory. Overwrite or append?"
read decision

while [[ $decision != "overwrite" ]] && [[ $decision != "append" ]]; 
do echo "Please enter \"overwrite\" or \"append\"." ; 
read decision; 
done

if [[ $decision == "overwrite" ]]
then echo "" > usage_by_time.txt
fi
fi

#See if a file called ports_seen.txt already exists
array=(`ls | grep 'ports_seen.txt'`);   

if [[ ${#array[@]} != 0 ]]
then echo "File named \"ports_seen.txt\" already exists in this \
directory. Overwrite?"
read decision

while [[ $decision != "yes" ]] && [[ $decision != "no" ]]; 
do echo "Please enter \"yes\" or \"no\"." ;
read decision;
done

if [[ $decision == "yes" ]]
then echo "" > ports_seen.txt
else
exit 0
fi
fi

echo "Gathering data... "

#Gather data and do so until the user says stop.
while true
do
   #Get updated list of ports and add them to the list
   ports_seen_occupied=("${ports_seen_occupied[@]}" `netstat -an | \
   egrep -v 'Proto|unix|Active' | sed 's/.*[:]\([0-9]*\)[ ].*[:].*/\1/'`);

   #Sort and remove duplicates
   ports_seen_occupied=(`printf '%s\n' "${ports_seen_occupied[@]}" | sort -un`);

   #Send to file
   echo ${ports_seen_occupied[@]} >> ports_seen.txt

   #Record ports and time
   printf '%s,  %s\n' "`date`" "`echo ${#ports_seen_occupied[@]}`" >> usage_by_time.txt

   #Sleep and repeat
   sleep 1m
done

#egg freckles
