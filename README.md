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
2. Setup cmake 
   1. Standalone: https://sdk.play.date/1.10.0/Inside%20Playdate%20with%20C.html#_building_on_windows_using_cmake
   2. Clion: https://sdk.play.date/1.10.0/Inside%20Playdate%20with%20C.html#_clioncmake