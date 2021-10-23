import os
os.add_dll_directory(r'C:\Program Files\STMicroelectronics\STM32Cube\STM32CubeProgrammer\api\lib')  # Path to DLLs. https://stackoverflow.com/a/67437837/101252
import CubeProgrammer_API 

CubeProgrammer_API.init()

x = CubeProgrammer_API.checkDeviceConnection()
print(f'checkDeviceConnection: {x}')

list = CubeProgrammer_API.getStLinkList()
print(f'list: {list}')

if (len(list) == 1):
	x = CubeProgrammer_API.connectStLink()  # 0)
	print('connect ok' if x == 0 else f'connect error {x}')
	
	x = CubeProgrammer_API.checkDeviceConnection()
	print(f'checkDeviceConnection: {x}')

	genInfo = CubeProgrammer_API.getDeviceGeneralInf()
	print(f'genInfo: {genInfo}')

	resetFlag = CubeProgrammer_API.reset(0)

	if resetFlag != 0:
		CubeProgrammer_API.disconnect()
		quit()

	isVerify = 1  # add verification step
	isSkipErase = 0  # no skip erase
	filePath = r'C:\Users\james.frederick\src\uctq_Sandbox\E102878-Qx\QuadRfDriverFirmware\Debug\QuadRfDriverFirmware.elf'
	downloadFileFlag = CubeProgrammer_API.downloadFile(filePath)  #, 0x08000000, isSkipErase, isVerify, "")
	if downloadFileFlag != 0:
		CubeProgrammer_API.disconnect()
		quit()

	size = 64
	startAddress = 0x08000000
	data = CubeProgrammer_API.readMemory(address=startAddress, size=size)

	print(f'data: {data}')

	print(f'\nReading 32-bit memory content')
	print(f'  Size          : {size} Bytes')
	print(f'  Address:      : 0x{startAddress:08X}')

	i = 0

	while i < size:
		col = 0
		print(f'\n0x{startAddress + i:08X} :', end="")
		while (col < 4) and (i < size):
			print(f' {data[i+3]:02X}{data[i+2]:02X}{data[i+1]:02X}{data[i]:02X} ', end="")
			col += 1
			i += 4
	print()

	# Run application
	executeFlag = CubeProgrammer_API.execute(0x08000000)
	if executeFlag != 0:
		CubeProgrammer_API.disconnect()
		quit()

	CubeProgrammer_API.disconnect()


# input("Press Enter to continue...") # pause to see result