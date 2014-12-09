#!/usr/bin/python

#used to call external commands
import subprocess

#used for regular expressions
import re

#get the unsorted list
port_list = []
port_list = subprocess.check_call(["bash", "used_port_returner.sh"]