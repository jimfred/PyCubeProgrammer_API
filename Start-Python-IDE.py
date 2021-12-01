#!"python.exe"
'''
Start app asynchronously and briefly display a message.
'duration_sec' will linger so that CMD window can be read for debug purposes. 
'''

import subprocess
import time
import glob
import os

def find_app(app_path_name_pattern: str):
	apps = glob.glob(app_path_name_pattern)
	qty = len(apps)
	if 1 == qty:
		return apps[0]
	raise NameError(f'Found {qty}, {apps} but expected just 1') 
	
	
app = find_app('C:/Program Files/JetBrains/**/bin/pycharm64.exe')
duration_sec=9

print(f'Start {app}\nhere {os.getcwd()}')
subprocess.Popen([app, "./"])

for i in range(duration_sec, 0, -1):
	print(f'{i}', end='\r'); 
	time.sleep(1)
	

