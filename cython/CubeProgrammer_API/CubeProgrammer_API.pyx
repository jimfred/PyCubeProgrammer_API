cdef extern from "stddef.h":
    ctypedef void wchar_t

# from ctypes import c_wchar

from cpython.ref cimport PyObject
cdef extern from "Python.h":
    PyObject* PyUnicode_FromWideChar(wchar_t *w, Py_ssize_t size)
    wchar_t* PyUnicode_AsWideCharString(object, Py_ssize_t*) except NULL


# Tell Cython what C constructs we wish to use from this C header file
cdef extern from "./api/include/CubeProgrammer_API.h":

    cdef enum cubeProgrammerError:
        CUBEPROGRAMMER_NO_ERROR = 0, # Success (no error)
        CUBEPROGRAMMER_ERROR_NOT_CONNECTED = -1, # Device not connected
        CUBEPROGRAMMER_ERROR_NO_DEVICE = -2, # Device not found
        CUBEPROGRAMMER_ERROR_CONNECTION = -3, # Device connection error
        CUBEPROGRAMMER_ERROR_NO_FILE = -4, # No such file
        CUBEPROGRAMMER_ERROR_NOT_SUPPORTED = -5, # Operation not supported or unimplemented on this interface
        CUBEPROGRAMMER_ERROR_INTERFACE_NOT_SUPPORTED = -6, # Interface not supported or unimplemented on this plateform
        CUBEPROGRAMMER_ERROR_NO_MEM = -7, # Insufficient memory
        CUBEPROGRAMMER_ERROR_WRONG_PARAM = -8, # Wrong parameters
        CUBEPROGRAMMER_ERROR_READ_MEM = -9, # Memory read failure
        CUBEPROGRAMMER_ERROR_WRITE_MEM = -10, # Memory write failure
        CUBEPROGRAMMER_ERROR_ERASE_MEM = -11, # Memory erase failure
        CUBEPROGRAMMER_ERROR_UNSUPPORTED_FILE_FORMAT = -12, # File format not supported for this kind of device
        CUBEPROGRAMMER_ERROR_REFRESH_REQUIRED = -13, # Refresh required
        CUBEPROGRAMMER_ERROR_NO_SECURITY = -14, # Refresh required
        CUBEPROGRAMMER_ERROR_CHANGE_FREQ = -15, # Changing frequency problem
        CUBEPROGRAMMER_ERROR_RDP_ENABLED = -16, # RDP Enabled error
        CUBEPROGRAMMER_ERROR_OTHER = -99, # Other error

    cdef enum debugConnectMode:
        NORMAL_MODE = 0,        # Connect with normal mode, the target is reset then halted while the type of reset is selected using the [debugResetMode].
        HOTPLUG_MODE,           # Connect with hotplug mode,  this option allows the user to connect to the target without halt or reset.
        UNDER_RESET_MODE,       # Connect with under reset mode, option allows the user to connect to the target using a reset vector catch before executing any instruction.
        POWER_DOWN_MODE,        # Connect with power down mode.
        PRE_RESET_MODE          # Connect with pre reset mode.

    cdef enum debugPort:
        JTAG = 0,
        SWD = 1,
        
    cdef enum debugResetMode:
        SOFTWARE_RESET,         # Apply a reset by the software.
        HARDWARE_RESET,         # Apply a reset by the hardware.
        CORE_RESET              # Apply a reset by the internal core peripheral.
        
    cdef struct frequencies:
        unsigned int jtagFreq[12]           #  JTAG frequency.
        unsigned int jtagFreqNumber         #  Get JTAG supported frequencies.
        unsigned int swdFreq[12]            #  SWD frequency.
        unsigned int swdFreqNumber          #  Get SWD supported frequencies.
        
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

    # define C typedefs for 3 callback functions.
    ctypedef void (*PCCbInitProgressBar)()
    ctypedef void (*PCCbLogMessage)(int msgType,  const wchar_t* str)
    ctypedef void (*PCCbLoadBar)(int x, int n)

    cdef struct displayCallBacks:
        PCCbInitProgressBar initProgressBar                          # Add a progress bar.
        PCCbLogMessage      logMessage                               # Display internal messages according to verbosity level.
        PCCbLoadBar         loadBar                                  # Display the loading of read/write process.
        
    cdef struct generalInf:
        unsigned short deviceId;  # Device ID.
        int  flashSize;           # Flash memory size.
        int  bootloaderVersion;   # Bootloader version
        char type[4];             # Device MCU or MPU.
        char cpu[20];             # Cortex CPU.
        char name[100];           # Device name.
        char series[100];         # Device serie.
        char description[150];    # Take notice.
        char revisionId[100];     # Revision ID.
        char board[100];          # Board Rpn.

    int api_checkDeviceConnection "checkDeviceConnection" ()
    int api_getStLinkList "getStLinkList" (debugConnectParameters** stLinkList, int shared)
    int api_connectStLink "connectStLink" (debugConnectParameters debugParameters)
    int api_readMemory "readMemory" (unsigned int address, unsigned char** data, unsigned int size)
    void api_disconnect "disconnect" ()
    generalInf * api_getDeviceGeneralInf "getDeviceGeneralInf" ()
    int api_downloadFile "downloadFile" (const wchar_t* filePath, unsigned int address, unsigned int skipErase, unsigned int verify, const wchar_t* binPath)
    int api_execute "execute" (unsigned int address)
    int api_reset "reset" (debugResetMode rstMode)
    
    void api_setDisplayCallbacks "setDisplayCallbacks" (displayCallBacks c)
    void api_setLoadersPath "setLoadersPath" (const char* path)


cdef class CubeProgrammer_API:

    def __init__(self):
        cdef const char* path = "./"
        api_setLoadersPath(path)

        global display_cb_struct
        api_setDisplayCallbacks(display_cb_struct)

    def setDisplayCallbacks(self, initProgressBar, logMessage, loadBar):
        global py_cb_InitProgressBar, py_cb_LogMessage, py_cb_LoadBar

        py_cb_InitProgressBar = initProgressBar
        py_cb_LogMessage = logMessage
        py_cb_LoadBar = loadBar

    def setLoadersPath(self, path):
        str = f'setLoadersPath({path})'
        c_cb_LogMessage(4, PyUnicode_AsWideCharString(str, NULL))
        cdef bytes x = path.encode()
        api_setLoadersPath(x)

    def checkDeviceConnection(self):
        return api_checkDeviceConnection()

    def getStLinkList(self):
        global stLinkList
        global stLinkListLen
        stLinkListLen = api_getStLinkList(&stLinkList, 0)
        print(f'len: {stLinkListLen}')
        return [stLinkList[i] for i in range(stLinkListLen)]

    def connectStLink(self, unsigned int index=0) -> int :
        global stLinkListLen
        if index >= stLinkListLen:
            return -1
        if 0 == stLinkList[index].accessPortNumber:  # assume this is an indication that the ST-Link is disconnected from the target.
            return -1
        cdef int err = api_connectStLink(stLinkList[index])
        print(f'connectStLink: {err}')
        return err

    def readMemory(self, unsigned int address, unsigned int size) -> bytearray:
        cdef unsigned char * data
        cdef int err = api_readMemory(address, &data, size)
        if err:
            return None
        bytes = bytearray()
        for i in range(size):
            bytes.append(data[i])
        return bytes

    def disconnect(self):
        api_disconnect()

    def getDeviceGeneralInf(self):
        cdef generalInf * p_general_inf = <generalInf *>0
        p_general_inf = api_getDeviceGeneralInf()
        return p_general_inf[0]

    def downloadFile(self, filePath, unsigned int address=0x08000000, unsigned int skipErase=0, unsigned int verify=1, binPath=''):
        cdef wchar_t* wfilePath = PyUnicode_AsWideCharString(filePath, NULL)
        cdef wchar_t* wbinPath = PyUnicode_AsWideCharString(binPath, NULL)
        print(f'downloadFile, filePath: {filePath}, address: {address}, skipErase: {skipErase}, verify: {verify}')
        return api_downloadFile(wfilePath, address, skipErase, verify, wbinPath)

    def reset(self, debugResetMode rstMode):
        return api_reset(rstMode)

    def execute(self, unsigned int address=0x08000000):
        return api_execute(address)

@staticmethod
cdef void c_cb_InitProgressBar():
    global py_cb_InitProgressBar
    if py_cb_InitProgressBar is not None:
        (<object>py_cb_InitProgressBar)()
    else:
        str = f'InitProgressBar'
        size = len(str)
        c_cb_LogMessage(4, PyUnicode_AsWideCharString(str, &size))

# C variant of LogMessage will call the Python variant if it's been set.
@staticmethod
cdef void c_cb_LogMessage(int msgType,  const wchar_t* str):
    s = <object>PyUnicode_FromWideChar(str, -1)  # https://stackoverflow.com/a/16526775/101252
    global py_cb_LogMessage
    if py_cb_LogMessage is not None:
        (<object>py_cb_LogMessage)(msgType, s)
    else:
        print(f'msgType: {msgType}, {s}')

@staticmethod
cdef void c_cb_LoadBar(int x, int n):
    global py_cb_LoadBar
    if py_cb_LoadBar is not None:
        (<object>py_cb_LoadBar)(x, n)
    else:
        str = f'lBar, x: {x}, n: {n} {(x * 100) / n:.2f}%'
        size = len(str)
        c_cb_LogMessage(4, PyUnicode_AsWideCharString(str, &size))


# Globals
cdef displayCallBacks display_cb_struct = displayCallBacks(logMessage = c_cb_LogMessage, initProgressBar = c_cb_InitProgressBar, loadBar = c_cb_LoadBar)
cdef debugConnectParameters * stLinkList = <debugConnectParameters *>0
cdef int stLinkListLen
cdef object py_cb_InitProgressBar = None
cdef object py_cb_LogMessage = None
cdef object py_cb_LoadBar = None



