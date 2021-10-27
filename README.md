# PyCubeProgrammer_API
This is a Python wrapper for STM32 CubeProgrammer_API. It uses Cython, resulting in a .pyd python-DLL file that is imported by a user's Python program.

The STM32 CubeProgrammer_API is a C-library, created by ST for ST-Link access to micro-controllers for the purpose of flash downloads or general memory access. The CubeProgrammer is required, including its drivers, and can be downloaded from st.com and installed.

This has been tested on Windows and although CubeProgrammer is available for other OS's.

Two examples are included:
- TestHotPlug.py - a console app that gracefully recovers from a hot-plug of either end of an ST-Link (USB end or the SWD end).
- runme.py - based loosely on C examples included in the CubeProgrammer_API.


