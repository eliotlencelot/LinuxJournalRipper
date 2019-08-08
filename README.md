# LinuxJournalRipper
**On August 7, 2019 Linux Journal shut its doors for good.** The website is partially unprotected (no paywall now for the HTML version of Linux Journal, but still paywalled for PDF/ePub/Mobi) but **the website will be also shut down in a near future.** This is an *emergency script make to download the 131 first (and old) issues of Linux Journal in PDF !*

Other issues are available online, in grey part of the internet, hence they have not disappear for now. The script is also able to download everything up to August 2019, it will be long, but it's possible, just edit the source code.

# What does this script?
This script :
1) goes on the Linux Journal main archive page https://secure2.linuxjournal.com/ljarchive/LJ/tocindex.html
2) download the list of Linux Journal issues.
3) goes on each issue and download the list of articles of this issue.
4) download each article and create a unique PDF per issue.
5) put the whole thing in a "Linux Journal" folder with logs in a "Logbooks" folder.

# Dependencies
This script should run well under macOS, FreeBSD and GNU/Linux.

For macOS : run this script in a Terminal to ensure you have everything for the program to run.
Any macOS or BSD users might smoothly run this script if (s)he has the following programs : lynx, weasyprint, imagemagick and the GNU version of head (ghead).
```
if test ! $(which brew)
then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew update

brew install coreutils
brew install python3 cairo pango gdk-pixbuf libffi imagemagick lynx
pip3 install WeasyPrint

brew update
brew upgrade python3 cairo pango gdk-pixbuf libffi imagemagick lynx

echo "Everything should be installed."
```

For Linux users : run these commands in a Terminal.
Any GNU/Linux users might smoothly run this script if (s)he has the following programs : lynx, weasyprint and imagemagick.

- Debian based (Debian 9.0 Stretch or newer, Ubuntu 16.04 Xenial or newer) :
```
apt-get update
apt-get install lynx
sudo apt-get install build-essential python3-dev python3-pip python3-setuptools python3-wheel python3-cffi libcairo2 libpango-1.0-0 libpangocairo-1.0-0 libgdk-pixbuf2.0-0 libffi-dev shared-mime-info
pip3 install WeasyPrint
```
- Fedora :
```
sudo yum install redhat-rpm-config python-devel python-pip python-setuptools python-wheel python-cffi libffi-devel cairo pango gdk-pixbuf2
pip3 install WeasyPrint
```
- ArchLinux :
```
sudo pacman -S python-pip python-setuptools python-wheel cairo pango gdk-pixbuf2 libffi pkg-config
pip3 install WeasyPrint
```
- Gentoo :
```
emerge pip setuptools wheel cairo pango gdk-pixbuf cffi
pip3 install WeasyPrint
```





# Usage
Just run the script in the terminal `./LJ-ripper.sh`
Please run this on a directory with enough free space (1.5 GB, I think).
Numerous temporary files will be written (> 2700 temporary files).

eliotlencelot, 2019.
