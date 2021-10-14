# Executes 'python setup.py build_ext --inplace'

import subprocess
cmd = 'python setup.py build_ext --inplace'
x = subprocess.run(cmd.split())
print('ok' if 0 == x.returncode else 'fail') 
input("Press Enter to continue...") # pause to see result when launched from FileExplorer.