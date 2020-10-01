from watchdog.observers import Observer
from watchdog.events import *
import argparse
import socket
import rcon
import time
import os

parser = argparse.ArgumentParser()
parser.add_argument("port", type=int)
parser.add_argument("password")
parser.add_argument("rawdir")
args = parser.parse_args()

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.connect(("127.0.0.1", args.port))
result = rcon.login(sock, args.password)
if not result:
	print("Incorrect rcon password")
	exit()

dir = args.rawdir + "/tmp"
inputtxt = dir + "/input.txt"
intxt = open(inputtxt,'r')
outputtxt = args.rawdir + "/output.txt"

class FileEventHandler(FileSystemEventHandler):
	def __init__(self):
		FileSystemEventHandler.__init__(self)
	def on_modified(self, event):
		print("file modified:{0}".format(event.src_path))
		intxt.seek(0)
		request = str.strip(intxt.readline())
		print(request)
		response = rcon.command(sock, request)
		print(response)
		os.system('echo "' + response + '" > ' + outputtxt)	
 
observer = Observer()
event_handler = FileEventHandler()
observer.schedule(event_handler,dir,True)
observer.start()
try:
	while True:
		time.sleep(1)
except KeyboardInterrupt:
	observer.stop()
	sock.close()
	intxt.close()
observer.join()
