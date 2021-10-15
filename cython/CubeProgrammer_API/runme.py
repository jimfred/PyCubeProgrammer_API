import os
os.add_dll_directory(r'C:\Program Files\STMicroelectronics\STM32Cube\STM32CubeProgrammer\api\lib')  # Path to DLLs. https://stackoverflow.com/a/67437837/101252

import CubeProgrammer_API 

CubeProgrammer_API.init()

x = CubeProgrammer_API.checkDeviceConnection()
print(f'checkDeviceConnection: {x}')

list = CubeProgrammer_API.getStLinkList()
print(list)

if (len(list) == 1):
	x = CubeProgrammer_API.connectStLink()
	print('connect ok' if x == 0 else f'connect error {x}')
	
	x = CubeProgrammer_API.checkDeviceConnection()
	print(f'checkDeviceConnection: {x}')

	genInfo = CubeProgrammer_API.getDeviceGeneralInf()
	print(genInfo)
	CubeProgrammer_API.disconnect()


input("Press Enter to continue...") # pause to see result