## Setup

### Mac
1. Download SDK https://play.date/dev/
2. Setup bash profile with the directory you prefer to store the sdk
```
export PATH="$PATH:/Users/<your-username>/PlaydateSDK/bin"

export PLAYDATE_SDK_PATH=/Users/<your-username>/PlaydateSDK
```
3. Run `$ run.sh` to execute latest build on the simulator
4. An error will show that it cannot find the sdk. 
   1. This requires you to update the config file found in ~/.Playdate/config with the path to the sdk
   2. Run `$ run.sh` again

### Windows
1. Download SDK https://play.date/dev/
2. Follow the guide here: https://sdk.play.date/1.10.0/Inside%20Playdate%20with%20C.html#_building_on_windows_using_cmake
3. Install Visual Studio: https://visualstudio.microsoft.com/vs/features/cplusplus/
4. Install Arm toolchain via installer `.exe` (specially `gcc-arm-none-eabi`): https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/downloads-1
   1. Make sure to tick "Add path to environment variable" at the end of the installer!
5. Install Cmake via installer `.exe`: https://cmake.org/download/
   1. Ensure `PATH` variable is updated while installing!
6. Setup environment variables
   1. Press `start button`
   2. Search for `Edit the System Environment Variables`
   3. Select the bottom button `Environment Variables`
   4. In the bottom "System Variables" area click the `New...` button 
   5. Add `PLAYDATE_SDK_PATH` as the name with the value being the path to your installed sdk (mine was `C:\Users\<username>\Documents\PlaydateSDK`)
   6. Then update `PATH`'s value to contain `C:\Users\<username>\Documents\PlaydateSDK\bin` (the `bin` folder contains command line utils)
7. Enable powershell scripting: https://superuser.com/a/106363
8. Run `\.run.ps1` via powershell