# PyCubeProgrammer_API

Use your Python app to create a customized live-watch window for your firmware by talking over SWD.

This is a Python wrapper for STM32 CubeProgrammer_API. It uses Cython, resulting in a .pyd python-DLL file that is imported by a user's Python program.

[![](https://mermaid.ink/img/eyJjb2RlIjoiZ3JhcGggVEQ7XG5cdFx0Y2xhc3NEZWYgR3JlZW5GaWxsIGZpbGw6IzdmNztcbiAgICBzdWJncmFwaCBXaW5kb3dzXG5cdFx0XHR1c2VyUHl0aG9uW3VzZXIgUHl0aG9uXSAtLT4gUHlDdWJlUHJvZ3JhbW1lcl9BUElbQ3ViZVByb2dyYW1tZXJfQVBJLnB5ZDxicj50aGluIFB5dGhvbiB3cmFwcGVyXTo6OkdyZWVuRmlsbDtcbiAgICAgIFB5Q3ViZVByb2dyYW1tZXJfQVBJIC0tPiBDdWJlUHJvZ3JhbW1lcl9BUEk7XG4gICAgICBDdWJlUHJvZ3JhbW1lcl9BUElbQ3ViZVByb2dyYW1tZXJfQVBJPGJyPkRMTHMgYW5kIGRyaXZlcnNdXG5cdFx0ZW5kXG5cbiAgICBDdWJlUHJvZ3JhbW1lcl9BUEkgLS0-fFVTQnwgU1RMaW5rW1NULUxpbmsgZG9uZ2xlXVxuXHQgIFNUTGluayAtLT58U1dEIG9yIEpUQUd8IFNUTTMyW1NUTTMyIE1pY3JvQ29udHJvbGxlcl1cbiAgICBodHRwczovL3d3dy5zdC5jb20vZW4vZGV2ZWxvcG1lbnQtdG9vbHMvc3RtMzJjdWJlcHJvZy5odG1sIC0tLS0-fGRvd25sb2FkL2luc3RhbGx8IEN1YmVQcm9ncmFtbWVyX0FQSVxuICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9qaW1mcmVkL1B5Q3ViZVByb2dyYW1tZXJfQVBJIC0tLS0-fGRvd25sb2FkL2NvcHl8IFB5Q3ViZVByb2dyYW1tZXJfQVBJIiwibWVybWFpZCI6eyJ0aGVtZSI6ImRlZmF1bHQifSwidXBkYXRlRWRpdG9yIjpmYWxzZSwiYXV0b1N5bmMiOnRydWUsInVwZGF0ZURpYWdyYW0iOmZhbHNlfQ)](https://mermaid-js.github.io/mermaid-live-editor/edit/#eyJjb2RlIjoiZ3JhcGggVEQ7XG5cdFx0Y2xhc3NEZWYgR3JlZW5GaWxsIGZpbGw6IzdmNztcbiAgICBzdWJncmFwaCBXaW5kb3dzXG5cdFx0XHR1c2VyUHl0aG9uW3VzZXIgUHl0aG9uXSAtLT4gUHlDdWJlUHJvZ3JhbW1lcl9BUElbQ3ViZVByb2dyYW1tZXJfQVBJLnB5ZDxicj50aGluIFB5dGhvbiB3cmFwcGVyXTo6OkdyZWVuRmlsbDtcbiAgICAgIFB5Q3ViZVByb2dyYW1tZXJfQVBJIC0tPiBDdWJlUHJvZ3JhbW1lcl9BUEk7XG4gICAgICBDdWJlUHJvZ3JhbW1lcl9BUElbQ3ViZVByb2dyYW1tZXJfQVBJPGJyPkRMTHMgYW5kIGRyaXZlcnNdXG5cdFx0ZW5kXG5cbiAgICBDdWJlUHJvZ3JhbW1lcl9BUEkgLS0-fFVTQnwgU1RMaW5rW1NULUxpbmsgZG9uZ2xlXVxuXHQgIFNUTGluayAtLT58U1dEIG9yIEpUQUd8IFNUTTMyW1NUTTMyIE1pY3JvQ29udHJvbGxlcl1cbiAgICBodHRwczovL3d3dy5zdC5jb20vZW4vZGV2ZWxvcG1lbnQtdG9vbHMvc3RtMzJjdWJlcHJvZy5odG1sIC0tLS0-fGRvd25sb2FkL2luc3RhbGx8IEN1YmVQcm9ncmFtbWVyX0FQSVxuICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9qaW1mcmVkL1B5Q3ViZVByb2dyYW1tZXJfQVBJIC0tLS0-fGRvd25sb2FkL2NvcHl8IFB5Q3ViZVByb2dyYW1tZXJfQVBJIiwibWVybWFpZCI6IntcbiAgXCJ0aGVtZVwiOiBcImRlZmF1bHRcIlxufSIsInVwZGF0ZUVkaXRvciI6ZmFsc2UsImF1dG9TeW5jIjp0cnVlLCJ1cGRhdGVEaWFncmFtIjpmYWxzZX0)

The STM32 CubeProgrammer_API is a C-library, created by ST for ST-Link access to micro-controllers for the purpose of flash downloads or general memory access. The CubeProgrammer is required, including its drivers, and can be downloaded from st.com and installed.

This has been tested on Windows and although CubeProgrammer is available for other OS's. The main focus so far is USB-to-SWD access.

Two examples are included:
- TestHotPlug.py - a console app that gracefully recovers from a hot-plug of either end of an ST-Link (USB end or the SWD end).
- runme.py - based loosely on C examples included in the CubeProgrammer_API.

## Installation
copy CubeProgrammer_API.cp39-win_amd64.pyd locally. It's assumed that CubeProgrammer has been installed (`C:/Program Files/STMicroelectronics/STM32Cube/STM32CubeProgrammer/api/lib/`) and has all the necessary DLLs required by the CubeProgrammer_API .pyd file. See the top of the examples for code to reference the location of those DLLs.

## Usage
In a Python application, reference the API's DLLs with a statement like...<br>
```os.add_dll_directory('C:/Program Files/STMicroelectronics/STM32Cube/STM32CubeProgrammer/api/lib/')```
<br>The `os` will, of course need an `import os`

Then import the .PYD extension like this...
`import CubeProgrammer_API`
The import needs to be done after the `add_dll_directory()`.

This Cython/Python wrapper performs default initialization that the C-API omitted such as initialization of callbacks. This default initialization will prevent faults/exceptions that halt/crash the application without diagnostic information.


## Development
- setup.py and run_setup.py are used to compile the Cython .pyx file to a .dll with the .pyd extension.
- CppExample is a Visual Studio project that uses the CubeProgrammer_API, used only to isolate C-vs-Python issues.
- CubeProgrammer_API.cpp is a temporary intermediate file used by Cython to generate the .pyd file.

## Other similar projects: 
- pyOCD
- PyStLink
- OpenOcd

Although there are several other libraries that provide debug interfaces to ARM micro-controllers, some with Python bindings, this PyCubeProgrammer_API is intended to leverage ST's support for driver installation and support for new chip variants.



