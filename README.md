# PyCubeProgrammer_API
This is a Python wrapper for STM32 CubeProgrammer_API. It uses Cython, resulting in a .pyd python-DLL file that is imported by a user's Python program.

[![](https://mermaid.ink/img/eyJjb2RlIjoiZ3JhcGggVEQ7XG5cdFx0c3ViZ3JhcGggV2luZG93c1xuXHRcdFx0dXNlclB5dGhvblt1c2VyIFB5dGhvbl0gLS0-IFB5Q3ViZVByb2dyYW1tZXJfQVBJW0N1YmVQcm9ncmFtbWVyX0FQSS5weWQ8YnI-dGhpbiBQeXRob24gd3JhcHBlcl07XG4gICAgICBQeUN1YmVQcm9ncmFtbWVyX0FQSSAtLT4gQ3ViZVByb2dyYW1tZXJfQVBJO1xuICAgICAgQ3ViZVByb2dyYW1tZXJfQVBJW0N1YmVQcm9ncmFtbWVyX0FQSTxicj5ETExzIGFuZCBkcml2ZXJzXVxuXHRcdGVuZFxuXG4gICAgQ3ViZVByb2dyYW1tZXJfQVBJIC0tPnxVU0J8IFNUTGlua1tTVC1MaW5rIGRvbmdsZV1cblx0ICBTVExpbmsgLS0-fFNXRCBvciBKVEFHfCBTVE0zMltTVE0zMiBNaWNyb0NvbnRyb2xsZXJdXG4gICAgaHR0cHM6Ly93d3cuc3QuY29tL2VuL2RldmVsb3BtZW50LXRvb2xzL3N0bTMyY3ViZXByb2cuaHRtbCAtLS0tPnxkb3dubG9hZC9pbnN0YWxsfCBDdWJlUHJvZ3JhbW1lcl9BUElcbiAgICBodHRwczovL2dpdGh1Yi5jb20vamltZnJlZC9QeUN1YmVQcm9ncmFtbWVyX0FQSSAtLS0-fGRvd25sb2FkL2NvcHl8IFB5Q3ViZVByb2dyYW1tZXJfQVBJIiwibWVybWFpZCI6eyJ0aGVtZSI6ImRlZmF1bHQifSwidXBkYXRlRWRpdG9yIjpmYWxzZSwiYXV0b1N5bmMiOnRydWUsInVwZGF0ZURpYWdyYW0iOmZhbHNlfQ)](https://mermaid-js.github.io/mermaid-live-editor/edit/#eyJjb2RlIjoiZ3JhcGggVEQ7XG5cdFx0c3ViZ3JhcGggV2luZG93c1xuXHRcdFx0dXNlclB5dGhvblt1c2VyIFB5dGhvbl0gLS0-IFB5Q3ViZVByb2dyYW1tZXJfQVBJW0N1YmVQcm9ncmFtbWVyX0FQSS5weWQ8YnI-dGhpbiBQeXRob24gd3JhcHBlcl07XG4gICAgICBQeUN1YmVQcm9ncmFtbWVyX0FQSSAtLT4gQ3ViZVByb2dyYW1tZXJfQVBJO1xuICAgICAgQ3ViZVByb2dyYW1tZXJfQVBJW0N1YmVQcm9ncmFtbWVyX0FQSTxicj5ETExzIGFuZCBkcml2ZXJzXVxuXHRcdGVuZFxuXG4gICAgQ3ViZVByb2dyYW1tZXJfQVBJIC0tPnxVU0J8IFNUTGlua1tTVC1MaW5rIGRvbmdsZV1cblx0ICBTVExpbmsgLS0-fFNXRCBvciBKVEFHfCBTVE0zMltTVE0zMiBNaWNyb0NvbnRyb2xsZXJdXG4gICAgaHR0cHM6Ly93d3cuc3QuY29tL2VuL2RldmVsb3BtZW50LXRvb2xzL3N0bTMyY3ViZXByb2cuaHRtbCAtLS0tPnxkb3dubG9hZC9pbnN0YWxsfCBDdWJlUHJvZ3JhbW1lcl9BUElcbiAgICBodHRwczovL2dpdGh1Yi5jb20vamltZnJlZC9QeUN1YmVQcm9ncmFtbWVyX0FQSSAtLS0-fGRvd25sb2FkL2NvcHl8IFB5Q3ViZVByb2dyYW1tZXJfQVBJIiwibWVybWFpZCI6IntcbiAgXCJ0aGVtZVwiOiBcImRlZmF1bHRcIlxufSIsInVwZGF0ZUVkaXRvciI6ZmFsc2UsImF1dG9TeW5jIjp0cnVlLCJ1cGRhdGVEaWFncmFtIjpmYWxzZX0)

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



