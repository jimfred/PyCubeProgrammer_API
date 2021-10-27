
import time

api_dll_and_loader_path = 'C:/Program Files/STMicroelectronics/STM32Cube/STM32CubeProgrammer/api/lib/'  # Directory containing DLLs, ExternalLoader and FlashLoader.
import os  # noqa: E402
os.add_dll_directory(api_dll_and_loader_path)  # Path to DLLs before importing CubeProgrammer_API. https://stackoverflow.com/a/67437837/101252
# noinspection PyUnresolvedReferences
import CubeProgrammer_API  # noqa: E402

api = CubeProgrammer_API.CubeProgrammer_API()

api.setLoadersPath(api_dll_and_loader_path)
api.set_default_log_message_verbosity(0)


class ConnectMgr:
    stlink_connected: bool
    device_connected: bool
    stlink_list: []
    stlink_qty: int

    def __init__(self):
        self.stlink_connected = False
        self.device_connected = False
        self.stlink_list = None
        self.stlink_qty = 0

    def update(self):

        self.device_connected = 1 == api.checkDeviceConnection()

        if not self.device_connected:
            api.disconnect()
            self.stlink_list = None
            self.stlink_qty = 0
            self.stlink_connected = False

        if self.stlink_list is None:
            self.stlink_list = api.getStLinkList()
            self.stlink_qty = len(self.stlink_list)
            self.stlink_connected = self.stlink_qty > 0

        if self.stlink_qty == 1 and not self.device_connected:
            api.connectStLink()

        self.device_connected = 1 == api.checkDeviceConnection()


connection = ConnectMgr()

while True:
    time.sleep(1)

    connection.update()

    print(f'stlink_qty={connection.stlink_qty}, stlink_connected={connection.stlink_connected}, device_connected={connection.device_connected}')

