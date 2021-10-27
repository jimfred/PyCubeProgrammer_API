
import time

api_dll_and_loader_path = 'C:/Program Files/STMicroelectronics/STM32Cube/STM32CubeProgrammer/api/lib/'  # Directory containing DLLs, ExternalLoader and FlashLoader.
import os  # noqa: E402
os.add_dll_directory(api_dll_and_loader_path)  # Path to DLLs before importing CubeProgrammer_API. https://stackoverflow.com/a/67437837/101252
# noinspection PyUnresolvedReferences
import CubeProgrammer_API  # noqa: E402

api = CubeProgrammer_API.CubeProgrammer_API()

api.setLoadersPath(api_dll_and_loader_path)
api.set_default_log_message_verbosity(0)

while True:
    time.sleep(1)

    api.connection_update()

    print(f'stlink qty={len(api.stlink_list)}, stlink_connected={api.stlink_connected}, device_connected={api.device_connected}')


