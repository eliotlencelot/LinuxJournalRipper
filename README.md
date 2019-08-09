# LinuxJournalRipper
## Why?
**On August 7, 2019 Linux Journal shut its doors for good.** The website is partially unprotected (no paywall now for the HTML version of Linux Journal, but still paywalled for PDF/ePub/Mobi) but **the website will be also shut down in a near future.** This is an *emergency script make to download the 131 first (and old) issues of Linux Journal in PDF !*

The generated PDF are portable, lightweight and without any advertisment.

## What does this script?
This script :
1) goes on the Linux Journal main archive page https://secure2.linuxjournal.com/ljarchive/LJ/tocindex.html
2) download the list of Linux Journal issues.
3) goes on each issue and download the list of articles of this issue.
4) download each article and create a unique PDF per issue.
5) put the whole thing in a "Linux Journal" folder with logs in a "Logbooks" folder.

## Which systems can run this script?
This emergency script run in macOS, FreeBSD and most GNU/Linux distribution. It should also run in Cygwin.
Took half a night on an Intel Core 2 Duo processor.

# How to dump every issue of the Linux Journal :

## Everything in the better quality possible
1) Download issues from n°301 (2019-08) to n°132 (2005-04) in official publication PDF here : https://drive.google.com/open?id=1FuU1N7tGNb-gDfrs5In_sqyPCwZ6FE2p (2274 MB if only n°301 to n°132, 3344 MB else)
2) Run the script to get n°131 (2005-03) to n°1 (1994-04) in generated PDF. (287 MB)

## Everything in good quality with the script
Other issues (>= 132) are available online in much better quality, into the grey part of the internet (see previous subsection), hence they have not disappear for now. The script is still able do download them, you could modify this script to download everything from 1994 up to August 2019, it will be long, but it's possible, just edit the source code.
To do so, you must suppress these lines of codes:
```bash
#Suppress numerous line until we have only from issue 1 to 131
#We have PDF in better quality for issues >=132.
tail -n +171 url_of_issues.txt > tmp.txt
mv tmp.txt url_of_issues.txt
```

# Installation
This script should run well under macOS, FreeBSD and GNU/Linux.

1) Install the dependencies by copy/pasting the following snippet of code into a Terminal.
2) Download the whole project or just the folder associated to your OS.
3) Run the `LJ-ripper.sh` script in a shell as usual

## Dependencies
*TODO : Change imagemagick to the new cpdf*

- For macOS : run this script in a Terminal to ensure you have everything for the program to run.
Any macOS or BSD users might smoothly run this script if (s)he has the following programs : lynx, weasyprint, imagemagick and the GNU version of head (ghead).
```bash
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
```bash
apt-get update
apt-get install lynx
sudo apt-get install imagemagick
sudo apt-get install build-essential python3-dev python3-pip python3-setuptools python3-wheel python3-cffi libcairo2 libpango-1.0-0 libpangocairo-1.0-0 libgdk-pixbuf2.0-0 libffi-dev shared-mime-info
pip3 install WeasyPrint
```
- Fedora :
```bash
sudo yum install redhat-rpm-config python-devel python-pip python-setuptools python-wheel python-cffi libffi-devel cairo pango gdk-pixbuf2 lynx
yum install ImageMagick
pip3 install WeasyPrint
```
- ArchLinux :
```bash
sudo pacman -S python-pip python-setuptools python-wheel cairo pango gdk-pixbuf2 libffi pkg-config lynx imagemagick
pip3 install WeasyPrint
```
- Gentoo :
```bash
emerge pip setuptools wheel cairo pango gdk-pixbuf cffi lynx imagemagick
pip3 install WeasyPrint
```

## Download the script
- You could do a `git clone` on your computer.
- You could simply push the *mater download* in the internet interface of GitHub button to get a zip with all the project, including the Mac OS X and Linux folder.

## Usage
1) Open a Terminal and run the script with `./LJ-ripper.sh`

The script will run as soon as it is launched without asking you anything at anytime. Please run this on a directory with enough free space (1.5 GB, I think).
Numerous temporary files will be written (> 2700 temporary files).

eliotlencelot, 2019.
