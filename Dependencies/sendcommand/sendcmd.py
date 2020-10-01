import pyinotify
import argparse
import os
import time
import eventlet

parser = argparse.ArgumentParser()
parser.add_argument("rawdir")
#parser.add_argument("command")
args = parser.parse_args()

dir = args.rawdir + "/out"
outputtxt = dir + "/output.txt"
outtxt = open(outputtxt,'r')

class MyEvent(pyinotify.ProcessEvent):
	def process_IN_MODIFY(self,event):
		outtxt.seek(0)
		print(str.strip(outtxt.readline()))
		outtxt.close()
		exit()
def main(outputtxt):
	vm = pyinotify.WatchManager()
	vm.add_watch(outputtxt,pyinotify.IN_MODIFY)
	event = MyEvent()
	notifier = pyinotify.Notifier(vm,event)	
	eventlet.monkey_patch()
	with eventlet.Timeout(1,False):
		print("12223")
		notifier.loop()
	print("123")
main(outputtxt)
