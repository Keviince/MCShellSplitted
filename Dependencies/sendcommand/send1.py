from __future__ import print_function
import argparse
import socket
import rcon
import os

parser = argparse.ArgumentParser()
parser.add_argument("port", type=int)
parser.add_argument("password")
args = parser.parse_args()

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.connect(("127.0.0.1", args.port))

dir = os.getcwd()
inputtxt = dir + "/input.txt"
intxt = open(inputtxt,'r')
outputtxt = dir + "/output.txt"
outtxt = open(outputtxt,'w')
after = str(os.stat(inputtxt).st_mtime)

try:
    result = rcon.login(sock, args.password)
    if not result:
        print("Incorrect rcon password")
    while True:
        before = str(os.stat(inputtxt).st_mtime)
        if before != after:
            intxt.seek(0)
            request = str.strip(intxt.readline())
            response = rcon.command(sock, request)
            print(request)
            print(response)
#			outtxt = open(outputtxt,'w')
            outtxt.truncate(0)
            outtxt.write(response)
            outtxt.flush()
            after = str(os.stat(inputtxt).st_mtime)
finally:
    sock.close()
    outtxt.close()
    intxt.close()
