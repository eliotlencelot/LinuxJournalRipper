# LinuxJournalRipper
TL;DR : These scripts are made for Mac or Linux. They can download every old issues of the Linux Journal into PDF. To download old issues locally just run a command like `./LJ-ripper-....sh`.

(c) eliotlencelot, 2019.

## What is LinuxJournalRipper
It is a script available for Mac and Linux that download the 131 first issues of the Linux Journal in PDF.
### Why?
**On August 7, 2019 Linux Journal shut its doors for good.** The website is *partially unprotected* (no paywall now for the HTML version of Linux Journal, but still paywalled for PDF/ePub/Mobi) but **the website will be also shut down in a near future.** This is an *emergency script make to download the 131 first (and old) issues of Linux Journal in PDF !*

The generated PDF are portable, lightweight and without any advertisment (contrary to a scanned file from that era).

### What does this script do?
This (emergency) script :
1) goes on the Linux Journal main archive page https://secure2.linuxjournal.com/ljarchive/LJ/tocindex.html
2) download the list of Linux Journal issues.
3) goes on each issue sub-website and download the list of articles of this issue.
4) download each article.
5) create a unique PDF per issue.
5) put the whole thing in a "Linux Journal" folder with logs in a "Logbooks" folder and cleanly quit.

### Which systems can run this script?
This (emergency) script run in :
- Apple macOS : Intel Mac, see the `Mac` folder for more information.
- FreeBSD : x86 or AMD64, see the `Mac` folder for more information.
- GNU/Linux : x86, see the `Linux 32 bits` folder for more information ; AMD64 see the `Linux 64 bits` folder for more information ;  other architechture as long as the dependecies exist ;
- Microsoft Windows : Should work with Cygwin or WSL as long as the dependecies exist.

### How much time did it took?
Took half a night on an old Intel Core 2 Duo processor with a gigabit connexion.

## License of my script
### My script are BSD-2:
My script use BSD-2 "Simplified" license, see the LICENSE file.
### Dependencies licences:
- GNU Core Utilities, lynx, WeasyPrint and if needed ImageMagick are all free and open-source tools. I did not modify their source code. Their license is respectively GPLv3, GPLv2, BSD-3 "Revised" and Apache. See their website for more information.
- CPDF is open-source but not FLOSS : code is accessible online, there are no fees for personal use, but there are fees for commercial use. [License for CPDF is available here.](https://github.com/coherentgraphics/cpdf-binaries/blob/master/LICENSE) It does also add a watermark.

It is possible to replace the CPDF by ImageMagick a project under Apache license, but the quality will be lessened, by either :
- replacing the `../cpdf *.pdf -o "Linux Journal - $INDEX.pdf"`command by `convert *.pdf "Linux Journal - $INDEX.pdf"` in the `LJ-ripper-[sth].sh`script for your plateform
- or on Linux, by using the script from `Linux others`.

## How to dump every issue of the Linux Journal :

### Everything in the better quality possible
1) Download issues from n°301 (2019-08) to n°132 (2005-04) in official publication PDF here : https://drive.google.com/open?id=1FuU1N7tGNb-gDfrs5In_sqyPCwZ6FE2p (2274 MB if only n°301 to n°132, 3344 MB else)
2) Run the script to get n°131 (2005-03) to n°1 (1994-04) in generated PDF. (287 MB)

### Everything in good quality with the script
Other issues (>= 132) are available online in much better quality, into the grey part of the internet (see previous subsection), hence they have not disappear for now. The script is still able do download them, you could modify this script to download everything from 1994 up to August 2019, it will be long, but it's possible, just edit the source code.
To do so, you must suppress these lines of codes:
```bash
#Suppress numerous line until we have only from issue 1 to 131
#We have PDF in better quality for issues >=132.
tail -n +171 url_of_issues.txt > tmp.txt
mv tmp.txt url_of_issues.txt
```

## Installation and Usage
### Main steps
This script should run well under macOS, FreeBSD and GNU/Linux.

1) Install the dependencies by copy/pasting the following snippet of code into a Terminal.
2) Download the whole project or just the folder associated to your OS.
3) Run in a shell as usual : `./LJ-ripper-[sth].sh` (replace \[sth\] by the right word).

### 1) Dependencies
*TODO : Change imagemagick to the new cpdf*

Installing dependencies means ensure you have everything needeed for the program to run.

#### macOS
- Open the Terminal
- Run this script in a Terminal 

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

#### GNU/Linux
- Open a Terminal.
- Run the corresponding script (here after) in a Terminal.

##### Debian based (Debian 9.0 Stretch or newer, Ubuntu 16.04 Xenial or newer) :
```bash
apt-get update
apt-get install lynx
sudo apt-get install imagemagick
sudo apt-get install build-essential python3-dev python3-pip python3-setuptools python3-wheel python3-cffi libcairo2 libpango-1.0-0 libpangocairo-1.0-0 libgdk-pixbuf2.0-0 libffi-dev shared-mime-info
pip3 install WeasyPrint
```
##### Fedora :
```bash
sudo yum install redhat-rpm-config python-devel python-pip python-setuptools python-wheel python-cffi libffi-devel cairo pango gdk-pixbuf2 lynx
yum install ImageMagick
pip3 install WeasyPrint
```
##### ArchLinux :
```bash
sudo pacman -S python-pip python-setuptools python-wheel cairo pango gdk-pixbuf2 libffi pkg-config lynx
sudo pacman -S imagemagick
pip3 install WeasyPrint
```
##### Gentoo :
```bash
emerge pip setuptools wheel cairo pango gdk-pixbuf cffi lynx imagemagick
pip3 install WeasyPrint
```

#### Windows 10
It *may be possible* to launch the `Linux others` script in Linux on Windows 10.
You need to have Windows 10, on a 64 bit processor, build 16215 or later.
- To find your PC's architecture and Windows build number, open **Settings > System > About** Look for the **OS Build** and **System Type** fields.
- Follow this [Windows Subsystem for Linux Installation Guide for Windows 10](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
- Do not forget to [initializing the newly installed distro](https://docs.microsoft.com/en-us/windows/wsl/initialize-distro)
- Follow 2) and 3) normally. For 2) choose`LJ-ripper-OtherArch.sh` in the `Linux others` folder.

[Troubleshooting Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/troubleshooting)

### 2) Download the project
- You could do a `git clone` on your computer.
- You could simply push the *Clone or download* button in the internet interface of GitHub button to get a zip with all the project, including the Mac OS X and Linux folder.

### 3) Usage
- Open a Terminal and run the script with somting like : `./LJ-ripper-[sth].sh` (replace \[sth\] by the right word).

The script will run as soon as it is launched without asking you anything at anytime. *TODO : Change this behavior* Please run this on a directory with enough free space (1.5 GB, I think).
Numerous temporary files will be written (> 2700 temporary files).

## Licence
Copyright 2019 eliotlencelot

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
