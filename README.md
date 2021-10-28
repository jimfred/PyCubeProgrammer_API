# PyCubeProgrammer_API
This is a Python wrapper for STM32 CubeProgrammer_API. It uses Cython, resulting in a .pyd python-DLL file that is imported by a user's Python program.

<!--
mermaid
  graph TD;
		subgraph Windows
			userPython[user Python] - -> PyCubeProgrammer_API[PyCubeProgrammer_API];
			PyCubeProgrammer_API - -> CubeProgrammer_API;
	  CubeProgrammer_API - -> ST-LinkDrivers[ST-Link Drivers];
		end
      ST-LinkDrivers - ->|USB| STLink
	  STLink - ->|SWD| STM32[STM32 MicroController]
-->

The STM32 CubeProgrammer_API is a C-library, created by ST for ST-Link access to micro-controllers for the purpose of flash downloads or general memory access. The CubeProgrammer is required, including its drivers, and can be downloaded from st.com and installed.

This has been tested on Windows and although CubeProgrammer is available for other OS's. The main focus so far is USB-to-SWD access.

Two examples are included:
- TestHotPlug.py - a console app that gracefully recovers from a hot-plug of either end of an ST-Link (USB end or the SWD end).
- runme.py - based loosely on C examples included in the CubeProgrammer_API.

## Installation
copy CubeProgrammer_API.cp39-win_amd64.pyd locally. It's assumed that CubeProgrammer has been installed (`C:/Program Files/STMicroelectronics/STM32Cube/STM32CubeProgrammer/api/lib/`) and has all the necessary DLLs required by the CubeProgrammer_API .pyd file. See the top of the examples for code to reference the location of those DLLs.

## Development
- setup.py and run_setup.py are used to compile the Cython .pyx file to a .dll with the .pyd extension.
- CppExample is a Visual Studio project that uses the CubeProgrammer_API, used only to isolate C-vs-Python issues.
- CubeProgrammer_API.cpp is a temporary intermediate file used by Cython to generate the .pyd file.

## Other similar projects: 
- pyOCD
- PyStLink
- OpenOcd



