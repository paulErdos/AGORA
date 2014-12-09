#returns sorted list of used ports

#get list of ports and processes, filter out everything but used 
#port numbers, sort and remove duplicates
netstat -an | egrep -v 'Proto|unix|Active' | sed 's/.*[:]\([0-9]*\)[ ].*[:].*/\1/' | sort -un
