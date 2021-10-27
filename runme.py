
api_dll_and_loader_path = 'C:/Program Files/STMicroelectronics/STM32Cube/STM32CubeProgrammer/api/lib/'  # Directory containing DLLs, ExternalLoader and FlashLoader.
import os  # noqa: E402
os.add_dll_directory(api_dll_and_loader_path)  # Path to DLLs before importing CubeProgrammer_API. https://stackoverflow.com/a/67437837/101252
# noinspection PyUnresolvedReferences
import CubeProgrammer_API  # noqa: E402


def init_progress_bar():
	print(f'InitProgressBar')


def log_message(msgType : int,  str):
	if msgType < 22:
		# print(f'{msgType}, {str}')
		print(f'{str}')


def load_bar(curr_progress: int, total: int):
	print(f'{100 * curr_progress / total}%')


api = CubeProgrammer_API.CubeProgrammer_API()

api.setDisplayCallbacks(
	initProgressBar=init_progress_bar,
	logMessage=log_message,
	loadBar=load_bar)

api.setLoadersPath(api_dll_and_loader_path)


def check_connection():
	x = api.checkDeviceConnection()
	str = 'Connected' if 1==x else 'Not connected'
	print(f'checkDeviceConnection: {str}')


check_connection()

list = api.getStLinkList()
print(f'list: {list}')

if len(list) == 1:
	x = api.connectStLink()
	if x < 0:
		api.disconnect()
		quit()

	check_connection()

	genInfo = api.getDeviceGeneralInf()
	print(f'genInfo: {genInfo}')

	resetFlag = api.reset(0)

	if resetFlag != 0:
		api.disconnect()
		quit()

	if False:  # switch to enable downloads.
		isVerify = 1  # add verification step
		isSkipErase = 0  # no skip erase
		filePath = r'C:\Users\james.frederick\src\uctq_Sandbox\E102878-Qx\QuadRfDriverFirmware\Debug\QuadRfDriverFirmware.elf'
		downloadFileFlag = api.downloadFile(filePath)  #, 0x08000000, isSkipErase, isVerify, "")
		if downloadFileFlag != 0:
			api.disconnect()
			quit()

	size = 64
	startAddress = 0x08000000
	data = api.readMemory(address=startAddress, size=size)

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
	executeFlag = api.execute()
	if executeFlag != 0:
		api.disconnect()
		quit()

	api.disconnect()


# input("Press Enter to continue...") # pause to see result