#!/bin/bash
file="nvocriglist.txt"
echo "------------RIGS MANAGEMENT SCRIPT------------"
echo "----------------------------------------------"
echo " "
echo "Please choose your option : "
echo "1. Reboot the rigs"
echo "2. Kill the mining screen"
echo "3. Modify a text file (ie : 1bash)"
echo "4. Other command"
echo "----------------------------------------------"

read choice

#---------------------------------1
if (($choice == 1))
then
 echo "Please enter your password : "
 read -s password

 while IFS= read -r line
  do
   echo "$line"
   sshpass -p $password ssh -n m1@$line sudo reboot now
 done <"$file"

#---------------------------------2
elif (($choice == 2))
then
 echo "Please enter your password : "
 read -s password

 while IFS= read -r line
  do
   echo "$line - trying to stop the screen..."
   sshpass -p $password ssh -n m1@$line 'screen -S miner -X quit'
   echo "$line - screen killed!"
 done <"$file"

#---------------------------------3
elif (($choice == 3))
then
 echo "Please enter your password : "
 read -s password
# echo "Please enter the full filename to search, for example /home/m1/1bash"
# read filen
 echo "Please enter the text to search, for example in the 1bash COIN="ZEN""
 read searchtext
 echo "Please enter the text that will replace the text found, for example COIN="ETH""
 read replacetext

 while IFS= read -r line
  do
   sshpass -p $password ssh -n m1@$line 'sed -i 's/$searchtext/$replacetext/' 1bash'
  done <"$file"

#---------------------------------4
elif (($choice == 4))
then
 echo "Please enter your password : "
 read -s password
 echo "Please enter your command : "
 read cm

 while IFS= read -r line
  do
   echo "$line - trying to execute the command..."
   sshpass -p $password ssh -n m1@$line $cm
   echo "$line - command done!"
  done <"$file"

#---------------------------------x
else
 echo "wrong choice"
fi
