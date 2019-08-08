#!/bin/bash

# Linux Journal Emergency Downloader in PDF
# -----------------------------------------
# This program will scrape the LJ HTML archive and create PDF of it.
# For now it only scrape a given issue of LJ.
# Fun note : this 'Linux Magazine' ripper has not been written in GNU/Linux environment,
#            because of hollidays, I have only my parents iMac.

# Version : 1 Emergency (aka Data Horder quick shit)
#TODO : GNU/Linux user must replace ghead by head

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



# 1 : Pretty Text :
# -----------------
clear
echo "Linux Journal Emergency Downloader in PDF"
echo "-----------------------------------------"
echo ""
echo "This script will create temporary files : numerous .txt and numerous .PDF"
echo "" #Dépendencies : lynx, (ghead for BSD systems), weasyprint.



# 2 : Downloading URL of all issues available on secure2.linuxjournal.com/ljarchive/LJ/tocindex.html
# --------------------------------------------------------------------------------------------------
#Downloading the list in a file
URL_ARCHIVE="https://secure2.linuxjournal.com/ljarchive/LJ/tocindex.html"
lynx -dump -listonly -nonumbers -hiddenlinks=ignore $URL_ARCHIVE > url_of_issues.txt
echo "A file called : 'url_of_issues.txt' has been created !"
echo ""

#Suppress the two first lines : no interest
tail -n +3 url_of_issues.txt > tmp.txt
mv tmp.txt url_of_issues.txt

#Suppress the two last lines : no interest
if [ "$(uname)" == "Darwin" ]; then
  ghead -n -2 url_of_issues.txt > tmp.txt	   
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  head -n -2 url_of_issues.txt > tmp.txt
fi
mv tmp.txt url_of_issues.txt

#Suppress numerous line until we have only from issue 1 to 131
#We have PDF in better quality for issues >=132.
tail -n +171 url_of_issues.txt > tmp.txt
mv tmp.txt url_of_issues.txt




# 3 : For each issue downloading URL of all article available 
# ------------------------------------------------------------
#url will be like : https://secure2.linuxjournal.com/ljarchive/LJ/002/toc002.html

#Creating a folder for resulting PDF
mkdir "Linux Journal"
mkdir "Logbooks"
echo ""

#Downloading each article of an issue and creating one final PDF.
COUNT_A=1
while read LINE_A; do
  echo "We are in this folder : $LINE_A"
  TMP_A="${LINE_A#https://secure2.linuxjournal.com/ljarchive/LJ/*}"
  INDEX="${TMP_A%/*}"
  echo ""
  echo "--------------------------------------------------"
  echo " We are downloading issue $INDEX of Linux Journal…"
  echo ""
  weasyprint $LINE_A 0-$INDEX.pdf
  lynx -dump -listonly -nonumbers "$LINE_A" >> url_article_$INDEX.txt
  
  #Suppress the first line : no interest
  tail -n +2 url_article_$INDEX.txt > tmp.txt
  mv tmp.txt url_article_$INDEX.txt
  
  #Suppress the two last lines : no interest
  if [ "$(uname)" == "Darwin" ]; then
  	echo "Mac"
    ghead -n -2 url_article_$INDEX.txt > tmp.txt	   
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  	echo "Linux"
    head -n -2 url_article_$INDEX.txt > tmp.txt
  fi
  
  #Here we do most of the job for every article in each issue:
  COUNT_B=1
  while read LINE_B; do
    # Downloading every article in PDF
    echo " We are downloading this article : $LINE_B from issue $INDEX"
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
    
    COUNT_B=`expr $COUNT_B + 1`
  done < "url_article_$INDEX.txt"
  
  # Concatenate PDF into one but with respect to the alphabetical order of your OS.
  convert *.pdf "Linux Journal - $INDEX.pdf"
    
  # Cleaning temporary PDFs
  mv "Linux Journal - $INDEX.pdf" "Linux Journal/Linux Journal - $INDEX.pdf"
  rm *.pdf
  
  # End of the work for this issue : PDF has been moved and rename, now move the log and increment.
  mv "url_article_$INDEX.txt" "Logbooks/url_article_$INDEX.txt"
  COUNT_A=`expr $COUNT_A + 1`
done < "url_of_issues.txt"

echo "Et voilà!"
