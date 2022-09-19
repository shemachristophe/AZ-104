#! /usr/bin/env bash

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

function get_terraform_plan_return_message(){
  terraform plan > 'planMsg.txt'
  #$runTFCmd>'planMsg.txt'
  cat 'planMsg.txt'
  #getPlanText=$(grep "Plan" 'planMsg.txt')
  
  #semoString=$(echo "$getPlanText" | sed "s/, /,/g" )
  
  #echo "-----------semoString start-------------"
  #echo "$semoString"
  #echo "-----------semoString end-------------"
  
  
  #IFS=',' read -a tfArr <<< "$semoString"  
  IFS=',' read -a tfArr <<< "$semoString"
  
  #${string//[^0-9]/ }
  #echo "${STRING//[^0-9]/}"
  #echo 'foo = 1700;' | sed -n -E -e 's/^foo = ([0-9]+).*/\1/p'
  
  
  #toAdd=$(echo "${tfArr[0]}" | sed 's/[^0-9]*//g');
  #toChange=$(echo "${tfArr[1]}" | sed 's/[^0-9]*//g');
  #toDestroy=$(echo "${tfArr[2]}" | sed 's/[^0-9]*//g');
  
  #toAdd=$(echo "${tfArr[0]}" | grep -o -E '[0-9]+');
  #toChange=$(echo "${tfArr[1]}" | grep -o -E '[0-9]+');
  #toDestroy=$(echo "${tfArr[2]}" | grep -o -E '[0-9]+');
  
  #echo "toAdd variable: $toAdd"
  #echo "toChange variable: $toChange"
  #echo "toDestroy variable: $toDestroy"
  
  noStateChange="No changes"
  #isPlanChanged=$(grep "$noStateChange" 'planMsg.txt')
  echo "isPlanChanged $isPlanChanged"
  #if [ -z "$isPlanChanged" ]
  #then
        #echo -e "${BBlue}State Change detected!"
  #else
        #echo -e "${BGreen}hello"
  #fi
  
  #if [ "$toAdd" -eq 0 ] && [ "$toChange" -eq 0 ] && [ "$toDestroy" -eq 0 ]; then
    #echo -e "${BGreen}No Change detected!"
  #else
    #echo -e "${BBlue}State Change detected!"
  #fi
}
