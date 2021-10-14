import os
os.add_dll_directory(r'C:\Program Files\STMicroelectronics\STM32Cube\STM32CubeProgrammer\api\lib')  # Path to DLLs. https://stackoverflow.com/a/67437837/101252

import CubeProgrammer_API 

x = CubeProgrammer_API.checkDeviceConnection2()

print(f'checkDeviceConnection: {x}')

list = CubeProgrammer_API.getStLinkList2()
print(list)

input("Press Enter to continue...") # pause to see result