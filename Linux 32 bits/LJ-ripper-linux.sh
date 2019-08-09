#!/bin/bash
start=`date +%s`



# Copyright 2019 eliotlencelot
# 
# Redistribution and use in source and binary forms,
# with or without modification,
# are permitted provided that the following conditions are met:
# 
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation and/or
#    other materials provided with the distribution.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
# IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
# TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
# EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.



# -----------------------------------------
# Linux Journal Emergency Ripper (in PDF)
# -----------------------------------------
# This program will scrape the LJ HTML public archive and create PDF for each issues.
# Ironic        : This 'Linux Magazine' ripper has not been written in GNU/Linux environment,
#                 because of hollidays, I have only my parents iMac.
# Into the code : This script is mostly build around two while loop, the outer loop is
#				  called the A loop and the inner loop is called the B loop.
#				  The variables of the A|B loop are called VAR_A|B.
#                 The A outer loop : opens each links in the main page (at $URL_ARCHIVE),
#									 goes to the B loop, merges PDF into one.
#                 The B inner loop : opens each links from the A loop,
#									 then download each URL into PDF.
#                 Temporary .txt files are just A|B URL. Saved as logs.
#				  Temporary .pdf files are article waiting to be merged. Deleted after use.

# Version : 2 Linux
# Using head and ../cpdf



# 1 : Introduction :
# ------------------
pretty_print () {
  clear
  printf -- "\033[32m-------------------------------------------\033[0m\n";
  printf -- "\033[32m| Linux Journal (Emergency) Ripper in PDF |\033[0m\n";
  printf -- "\033[32m-------------------------------------------\033[0m\n";
  printf -- "\n";
  printf -- "\033[32m  Made by eliotlencelot, in 2019.\033[0m\n";
  printf -- "\n";
}

waiting () {
i=0
sp='/-\|'
n=${#sp}
printf ' '
sleep 0.1
while true; do
    printf '\b%s' "${sp:i++%n:1}"
    sleep 0.1
done
}

#Argument --help
if [ ${#@} -ne 0 ] && [ "${@#"--help"}" = "" ]; then
  pretty_print
  printf -- '\033[33mHelp file : ./LJ-ripper.sh           : launch the script.\033[0m\n';
  printf -- '\033[33m            ./LJ-ripper.sh --help    : show this message.\033[0m\n';
  printf -- '\033[33m            ./LJ-ripper.sh --version : show the version.\033[0m\n\n';
  exit 0;
fi;

#Argument --version (Linux version)
if [ ${#@} -ne 0 ] && [ "${@#"--version"}" = "" ]; then
  pretty_print
  printf -- '\033[33mVersion : 1 Linux\033[0m\n\n';
  exit 0;
fi;

##Verify if ghead is present (Mac Only)
# _=$(command -v ghead);
# if [ "$?" != "0" ]; then
#   pretty_print
#   printf -- "\033[31m ghead is not installed.\033[0m\n";
#   printf -- '\033[31m Error : 100\033[0m\n';
#   printf -- "\033[33m Advice : Run \033[0m brew install coreutils \033[33m in Terminal \033[0m\n";
#   exit 100;
# fi;

#Verify if lynx is present (Linux version)
_=$(command -v lynx);
if [ "$?" != "0" ]; then
  pretty_print
  printf -- "\033[31m lynx is not installed.\033[0m\n";
  printf -- '\033[31m Error : 101\033[0m\n';
  printf -- "\033[33m Advice : Install the\033[0m lynx\033[33m package \033[0m\n";
  exit 101;
fi;

#Verify if WeasyPrint is present (Linux version)
_=$(command -v weasyprint);
if [ "$?" != "0" ]; then
  pretty_print
  printf -- "\033[31m WeasyPrint is not installed.\033[0m\n";
  printf -- '\033[31m Error : 102\033[0m\n';
  printf -- "\033[33m Advice : Install\033[0m python3 cairo pango gdk-pixbuf libffi\033[33m packages \033[0m\n";
  printf -- "\033[33m Advice : Run \033[0m pip3 install WeasyPrint \033[33m in Terminal \033[0m\n";
  exit 102;
fi;

#Textual introduction
clear
pretty_print
printf -- "\033[33mThis script will create many temporary files : >= 2700 .txt and .pdf.\033[0m\n";
printf -- "\033[33mThis script will download many MB    : depending on the code from 290 MB to 1500 MB.\033[0m\n";
printf -- "\033[33mThis script will automatically start : do not press any key during usage.\033[0m\n";
printf -- "\033[33mThis script could show some ERRORS   : normal, the website (css) is already down.\033[0m\n";
printf -- "\033[33mThis script took long time to run    : Half a night in an Intel Core 2 Duo.\033[0m\n\n";



# 2 : Downloading URL of all issues available on secure2.linuxjournal.com/ljarchive/LJ/tocindex.html
# --------------------------------------------------------------------------------------------------
#Creating folders for resulting files
if [ -d "./Results" ] 
then
  #Directory exists
  cd "Results"
else
  #Directory does not exists.
  mkdir "Results"
  printf -- "\033[32m Succes!     : 'Results' directory has been created!\033[0m\n";
  cd "Results"
fi

if [ -d "./Linux Journal" ] 
then
  #Directory exists
  echo ""
else
  #Directory does not exists.
  mkdir "Linux Journal"
  printf -- "\033[32m Succes!     : 'Linux Journal' directory has been created!\033[0m\n";
fi

if [ -d "./Logbooks" ] 
then
  #Directory exists
  echo ""
else
  #Directory does not exists.
  mkdir "Logbooks"
  printf -- "\033[32m Succes!     : 'Logbooks' directory has been created!\033[0m\n";
fi

#Downloading the list in a file
printf -- "\n\033[33m Looking for : Issues of Linux Journal…\033[0m\n";
URL_ARCHIVE="https://secure2.linuxjournal.com/ljarchive/LJ/tocindex.html"
lynx -dump -listonly -nonumbers -hiddenlinks=ignore $URL_ARCHIVE > url_of_issues.txt
printf -- "\033[32m Succes!     : 'url_of_issues.txt' has been created!\033[0m\n";

#Suppress the two first lines : no interest
tail -n +3 url_of_issues.txt > tmp.txt
mv tmp.txt url_of_issues.txt

#Suppress the two last line : no interest (Linux version)
head -n -2 url_of_issues.txt > tmp.txt
mv tmp.txt url_of_issues.txt

#Suppress 170 lines : we only want issue 1 to 131
#Internet have richer PDF for issues >=132.
tail -n +171 url_of_issues.txt > tmp.txt
mv tmp.txt url_of_issues.txt



# 3 : For each issue downloading URL of all article available 
# ------------------------------------------------------------
#url will be like : https://secure2.linuxjournal.com/ljarchive/LJ/002/toc002.html

#Downloading each article of an issue and creating one final PDF.
COUNT_A=1
while read LINE_A; do
  #printf -- "\033[31m We are in this folder : $LINE_A…\033[0m\n";
  TMP_A="${LINE_A#https://secure2.linuxjournal.com/ljarchive/LJ/*}"
  INDEX="${TMP_A%/*}"
  echo ""
  echo " --------------------------------------------------"
  printf -- "\033[33m Downloading : issue n° $INDEX of Linux Journal…\033[0m\n\n";
  printf -- "\033[33m Downloading : table of content for issue $INDEX …\033[0m\n";
  weasyprint $LINE_A 0-$INDEX.pdf
  printf -- "\033[32m Succes!     : table of content downloaded!\033[0m\n\n";
  lynx -dump -listonly -nonumbers "$LINE_A" >> url_article_$INDEX.txt
  
  #Suppress the first line : no interest
  tail -n +2 url_article_$INDEX.txt > tmp.txt
  mv tmp.txt url_article_$INDEX.txt

  #Suppress the two last lines : no interest  (Linux version)
  head -n -2 url_article_$INDEX.txt > tmp.txt
  mv tmp.txt url_article_$INDEX.txt
  
  #Here we do most of the job for every article in each issue:
  COUNT_B=1
  while read LINE_B; do
    # Downloading every article in PDF
    printf -- "\033[33m Downloading : article $COUNT_B for issue $INDEX …\033[0m\n";
    echo "$COUNT_B"
    if [ "$COUNT_B" -lt 10 ] ; then
      weasyprint "$LINE_B" "$COUNT_B-$INDEX.pdf"
    else
      if [ "$COUNT_B" -lt 20 ] ; then
        weasyprint "$LINE_B" "A$COUNT_B-$INDEX.pdf"
      else
        weasyprint "$LINE_B" "B$COUNT_B-$INDEX.pdf"
      fi
    fi
    
    printf -- "\033[32m Succes!     : article $COUNT_B downloaded!\033[0m\n\n";
    COUNT_B=`expr $COUNT_B + 1`
  done < "url_article_$INDEX.txt"
  
  # Concatenate PDF into one but with respect to the alphabetical order of your OS.
  printf -- "\033[33m Merging PDF : creating PDF for issue $INDEX …\033[0m\n";
  ../cpdf *.pdf -o "Linux Journal - $INDEX.pdf" #better than convert *.pdf "Linux Journal - $INDEX.pdf"
    
  # Cleaning temporary PDFs
  mv "Linux Journal - $INDEX.pdf" "Linux Journal/Linux Journal - $INDEX.pdf"
  rm *.pdf
  
  # End of the work for this issue : PDF has been moved and rename, now move the log and increment.
  mv "url_article_$INDEX.txt" "Logbooks/url_article_$INDEX.txt"
  COUNT_A=`expr $COUNT_A + 1`

  printf -- "\033[32m Succes!     : issue n° $INDEX downloaded in one pretty PDF!\033[0m\n";
  echo " --------------------------------------------------"
done < "url_of_issues.txt"



end=`date +%s`
runtime=$((end-start))

echo ""
echo "Et voilà!"
echo "It has taken $runtime seconds"
printf -- '\n';
exit 0;