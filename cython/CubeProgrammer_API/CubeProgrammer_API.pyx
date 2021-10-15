cdef extern from "stddef.h":
	ctypedef void wchar_t
	
cdef extern from "./api/include/CubeProgrammer_API.h":
	
	enum debugPort:
		pass
		
	enum debugConnectMode:
		pass
		
	enum debugResetMode:
		pass
		
	struct frequencies:
		pass
		
	# https://cython.readthedocs.io/en/latest/src/userguide/external_C_code.html#styles-of-struct-union-and-enum-declaration
	cdef struct debugConnectParameters:
		debugPort dbgPort                  # Select the type of debug interface #debugPort.
		int index                          # Select one of the debug ports connected.
		char serialNumber[33]              # ST-LINK serial number.
		char firmwareVersion[20]           # Firmware version.
		char targetVoltage[5]              # Operate voltage.
		int accessPortNumber               # Number of available access port.
		int accessPort                     # Select access port controller.
		debugConnectMode connectionMode    # Select the debug CONNECT mode #debugConnectMode.
		debugResetMode resetMode           # Select the debug RESET mode #debugResetMode.
		int isOldFirmware                  # Check Old ST-LINK firmware version.
		frequencies freq                   # Supported frequencies #frequencies.
		int frequency                      # Select specific frequency.
		int isBridge                       # Indicates if it's Bridge device or not.
		int shared                         # Select connection type, if it's shared, use ST-LINK Server.
		char board[100]                    # board Name
		int DBG_Sleep 
		
	cdef struct displayCallBacks:
		void (*initProgressBar)()                               # Add a progress bar. */
		void (*logMessage)(int msgType,  const wchar_t* str)    # Display internal messages according to verbosity level. */
		void (*loadBar)(int x, int n)                           # Display the loading of read/write process. */

	int checkDeviceConnection()
	int getStLinkList(debugConnectParameters** stLinkList, int shared)
	void setDisplayCallbacks(displayCallBacks c)
	void setLoadersPath(const char* path)
	
cdef void InitPBar():
	pass
	
cdef void DisplayMessage(int msgType,  const wchar_t* str):
	pass
	
cdef void lBar(int x, int n):
	pass
	
cdef displayCallBacks vsLogMsg	
cdef char* loaderPath = "C:/Program Files/STMicroelectronics/STM32Cube/STM32CubeProgrammer/api/lib/" # reference directory that has ExternalLoader and FlashLoader.
	
def init():
	setLoadersPath(loaderPath)

	vsLogMsg.logMessage = DisplayMessage
	vsLogMsg.initProgressBar = InitPBar
	vsLogMsg.loadBar = lBar
	setDisplayCallbacks(vsLogMsg)
	
def checkDeviceConnection2():
	return checkDeviceConnection()

cdef debugConnectParameters * stLinkList = <debugConnectParameters *>0
	
def getStLinkList2():
	print('getStLinkList2')
	cdef int qty
	print(f'stLinkList, before: {<unsigned long>stLinkList:X}')
	qty	= getStLinkList(&stLinkList, 0)
	print(f'stLinkList, after: {<unsigned long>stLinkList:X}')
	print(f'qty={qty}')
	list = []
	for i in range(qty):
		list.append(stLinkList[i])
	return list
	
	