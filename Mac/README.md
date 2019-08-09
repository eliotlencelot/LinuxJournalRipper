# LinuxJournalRipper
TL;DR : Download this folder on your Mac, open a Terminal and type `./LJ-ripper-mac.sh`and download every old issues of the Linux Journal into PDF.

# Installation on macOS
Here are more information for newbies.

1) Download these files in a folder.
2) Open the Terminal in this folder (basic use of the tutorial available online, search for `use terminal mac`)
3) Copy/paste the following script in it (it will install the dependencies) :
```bash
if test ! $(which brew)
then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew update

brew install coreutils
brew install python3 cairo pango gdk-pixbuf libffi lynx
pip3 install WeasyPrint

brew update
brew upgrade python3 cairo pango gdk-pixbuf libffi lynx

echo "Everything should be installed."
```
4) Run my script by typing `LJ-ripper-mac.sh` in a shell as usual.
5) Quit the Terminal

The script will run as soon as it is launched without asking you anything at anytime. Please run this on a directory with enough free space (around 500 MB).
Numerous temporary files will be written (> 2700 temporary files).

eliotlencelot, 2019.
