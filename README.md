# Welcome to my version of Pong
Created with LÖVE and Lua, this is an arcade-style, two-player game.

## Downloads
Download the application and play this game on your computer from the respective links below for your operating system. Other downloads are coming soon... Until then, you can download [LÖVE](https://love2d.org/) and this codebase and try it out on your own. Refer to running the application below.

[Windows (64-bit)](https://storage.googleapis.com/www.adityaone.com/pong.exe)

## Code walkthrough
This game uses *push.lua* from *https://github.com/ulydev/push* to handle resolution. It helps create the arcade-style, retro look, handles scaling in different display resolutions, and maintains the 16:9 aspect ratio.

The game also makes use of *https://github.com/vrld/hump/blob/master/class.lua* for convenient integration of Object Oriented Programming.

*Ball.lua* and *Paddle.lua* are classes for managing instances of it in *main.lua*, which is the entry-point to the application.

## Running the application
### Prerequisitex
LÖVE must be installed. Use the installer from <https://love2d.org/>

***
### For Winows
Drag and drop *main.lua* onto *love.exe* or its shortcut. Or use the following command from the command prompt or powershell
    
    "C:\Program Files\LOVE\love.exe" "C:\games\mygame"
    "C:\Program Files\LOVE\love.exe" "C:\games\packagedgame.love"
You can also create a shortcut or alias

### For Mac OSX
On Mac OS X, a folder or .love file can be dropped onto the love application bundle. On the Mac Terminal (command line), you can use love like this (assuming it's installed to the Applications directory):
    
    open -n -a love "~/path/to/mygame"

### For Linux
If LÖVE is installed system-wide, you can double-click *.love* files from your file-manager. Otherwise, you the following commands by specifying the path to the project directory or the exact file.
    
    love /home/path/to/gamedir/
    love /home/path/to/packagedgame.love
