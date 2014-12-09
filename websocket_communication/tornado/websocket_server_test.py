"""
Websocket Server for diagnosing websocket connectivity issues.
Author: Vincent Steffens
Date: 18 September 2014

Return values:
        -1: Improper arguments
        -2: Port requested is reserved for the system. (1023 and below are reserved)
"""

#used for Tornado
from tornado.options import define, options, parse_command_line
import tornado.websocket
import tornado.ioloop
import tornado.web

#used for program agruments and exiting
import sys


#Check for valid arguments
if len(sys.argv) > 2:
        print "Usage:"
	print "$ <program name> <port numbered 1024 or greater>"
        print "OR"
        print "$ <program name>"
        sys.exit(-1)

if len(sys.argv) == 2:
        #Verify argument is integer (handled by int())
        requested_port = int(sys.argv[1])

        #Verify requested port is not reserved for the system
        if requested_port < 1024:
                print "Input error: Attempt to use system port. Please choose a port numbered 1024 or greater. 8884 is default."
                sys.exit(-2)
else:
        requested_port = 8884

print "Selected port: %d" % requested_port
