/**
* \file Example1.cpp
* This example allows to execute some operations to the internal STM32 Flash memory. \n
* 1.	Detect connected ST-LINK and display them. \n
* 2.	Loop on each ST-LINK probes and execute the following operations: \n
* 			-	Mass erase.
* 			-	Single word edition (-w32).
* 			-	Read 64 bytes from 0x08000000.
* 			-	Sector erase.
* 			-	Read 64 bytes from 0x08000000 .
*			-	System Reset. \n
*.
*Go to the source code : \ref STLINK_Example1
* \example STLINK_Example1
* This example allows to execute some operations to the internal STM32 Flash memory. \n
* 1.	Detect connected ST-LINK and display them. \n
* 2.	Loop on each St-LINK probes and execute the following operations: \n
* 			-	Mass erase.
* 			-	Single word edition (-w32).
* 			-	Read 64 bytes from 0x08000000.
* 			-	Sector erase.
* 			-	Read 64 bytes from 0x08000000 .
*			-	System Reset. \n
* \code{.cpp}
**/

#include <stdio.h> 
#include <iostream>
#include "DisplayManager.h"

#include <CubeProgrammer_API.h>                
#pragma comment(lib, "CubeProgrammer_API.lib") 
// Prerequisites for CubeProgrammer_API compile & link:
//   - Include path needs $(ProjectDir)..\api\include or 
//   - Lib path needs $(ProjectDir)..\api\lib
// Prerequisites for CubeProgrammer_API debug/execution:
//   - debuger environment needs: PATH=C:\Program Files\STMicroelectronics\STM32Cube\STM32CubeProgrammer\api\lib;%PATH% 

extern unsigned int verbosityLevel;

int Example1(void) {

    logMessage(Title, "\n+++ Example 1 +++\n\n");

    debugConnectParameters* stLinkList;
    debugConnectParameters debugParameters;
    generalInf* genInfo;

    int getStlinkListNb = getStLinkList(&stLinkList, 0);

    if (getStlinkListNb == 0)
    {
        logMessage(Error, "No STLINK available\n");
        return 0;
    }
    else {
        logMessage(Title, "\n-------- Connected ST-LINK Probes List --------");
        for (int i = 0; i < getStlinkListNb; i++)
        {
            logMessage(Normal, "\nST-LINK Probe %d :\n", i);
            logMessage(Info, "   ST-LINK SN   : %s \n", stLinkList[i].serialNumber);
            logMessage(Info, "   ST-LINK FW   : %s \n", stLinkList[i].firmwareVersion);
        }
        logMessage(Title, "-----------------------------------------------\n\n");
    }

    for (int index = 0; index < getStlinkListNb; index++) {

        logMessage(Title, "\n--------------------- ");
        logMessage(Title, "\n ST-LINK Probe : %d ", index);
        logMessage(Title, "\n--------------------- \n\n");

        debugParameters = stLinkList[index];
        debugParameters.connectionMode = HOTPLUG_MODE; // UNDER_RESET_MODE;
        debugParameters.shared = 0;

        /* Target connect */
        int connectStlinkFlag = connectStLink(debugParameters);
        if (connectStlinkFlag != 0) {
            logMessage(Error, "Establishing connection with the device failed\n");
            disconnect();
            continue;
        }
        else {
            logMessage(GreenInfo, "\n--- Device %d Connected --- \n", index);
        }

        /* Display device informations */
        genInfo = getDeviceGeneralInf();
        logMessage(Normal, "\nDevice name : %s ", genInfo->name);
        logMessage(Normal, "\nDevice type : %s ", genInfo->type);
        logMessage(Normal, "\nDevice CPU  : %s \n", genInfo->cpu);

        /* Reading 64 bytes from 0x08000000 */
        unsigned char* dataStruct = 0;
        int size = 64;
        int startAddress = 0x08000000;

        int readMemoryFlag = readMemory(startAddress, &dataStruct, size);
        if (readMemoryFlag != 0)
        {
            disconnect();
            continue;
        }

        logMessage(Normal, "\nReading 32-bit memory content\n");
        logMessage(Normal, "  Size          : %d Bytes\n", size);
        logMessage(Normal, "  Address:      : 0x%08X\n", startAddress);

        int i = 0, col = 0;

        while ((i < size))
        {
            col = 0;
            logMessage(Normal, "\n0x%08X :", startAddress + i);
            while ((col < 4) && (i < size))
            {
                logMessage(Info, " %08X ", *(unsigned int*)(dataStruct + i));
                col++;
                i += 4;
            }

        }
        logMessage(Normal, "\n");

        /* Process successfully Done */
        disconnect();
    }

    deleteInterfaceList();
    return 1;

}

int main()
{
    int x = checkDeviceConnection();

    int ret = 0;
    const char* loaderPath = "C:/Program Files/STMicroelectronics/STM32Cube/STM32CubeProgrammer/api/lib/"; // reference directory that has ExternalLoader and FlashLoader.
    displayCallBacks vsLogMsg;

    /* Set device loaders path that contains FlashLoader and ExternalLoader folders*/
    setLoadersPath(loaderPath);

    /* Set the progress bar and message display functions callbacks */
    vsLogMsg.logMessage = DisplayMessage;
    vsLogMsg.initProgressBar = InitPBar;
    vsLogMsg.loadBar = lBar;
    setDisplayCallbacks(vsLogMsg);

    /* Set DLL verbosity level */
    setVerbosityLevel(verbosityLevel = VERBOSITY_LEVEL_1);

    ret = Example1();
    //ret = Example2();
    //ret = Example3();
    //ret = Example_WB();
    //ret = I2C_Example();
    //ret = CAN_Example();
    //ret = SPI_Example();
    //ret = UART_Example();
    //ret = USB_Example();
    //ret = USB_Example_WB();
    //ret = TSV_Flashing();

    std::cout << "\n" << "Press enter to continue...";
    std::cin.get();
    return ret;
}


/** \endcode **/
