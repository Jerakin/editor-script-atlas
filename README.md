# Atlas

## Install
You can use the these editor scripts in your own project by adding this project as a [Defold library dependency](https://www.defold.com/manuals/libraries/). Open your game.project file and in the dependencies field under project add:  
https://github.com/Jerakin/editor-script-atlas/archive/master.zip

### macOS
You need to make your python installation visible to Defolds Java VM, you need to put your path modifications in
`$HOME/.bash_profile`. This is because I `source $HOME/.bash_profile` and I opted do it this way instead of
`export PATH="$PATH:/usr/local/bin"` because if you are using `pyenv` and `pyenv-virtualenv` it would not pick up on that.

### Dependencies
You also need to make sure you have python 3 and [deftree](https://github.com/Jerakin/DefTree) installed.  
You can easily install deftree with  
`pip install deftree`

## Editor Script
This adds scripts that add extra functionality for creating new atlases and adding images to already existing atlases.
To add a  images go an already created atlas selected the images you want to add and then select the atlas you want to add them too.

## Something went wrong
If you want some more information of what is happening create a file in the root of your project called `python_log.txt`
the script checks for that file and output any logging to it. 