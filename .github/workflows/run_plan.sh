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
  getPlanText=$(grep "Plan" 'planMsg.txt')
  valResult=$(echo "$getPlanText")
  
  echo "-----------valResult start-------------"
  echo "$valResult"
  echo "-----------valResult end-------------"
  semoString=$(echo $demoString | sed "s/, /,/g")
  
  echo "-----------semoString start-------------"
  echo "$semoString"
  echo "-----------semoString end-------------"
  
  
  #IFS=',' read -a tfArr <<< "$semoString"  
  IFS='(, )' read -a tfArr <<< "$$valResult"
  
  echo "yooo: ${tfArr[0]}"
  toAdd=$(echo ${tfArr[0]} | sed 's/[^0-9]*//g') ;
  toChange=$(echo ${tfArr[1]} | sed 's/[^0-9]*//g') ;
  toDestroy=$(echo ${tfArr[2]} | sed 's/[^0-9]*//g') ;
  
  echo "toAdd variable:$toAdd"
  echo "toChange variable:$toChange"
  echo "toDestroy variable:$toDestroy"
  
  if [ $toAdd -eq 0 ] && [ $toChange -eq 0 ] && [ $toDestroy -eq 0 ]; then
    echo -e "${BGreen}No Change detected!"
  else
    echo "Zion: $valResult"
    #echo -e "${BBlue}State Change detected!"
  fi
}


function get_terraform_plan_return_messages(){
  set +e
  #exitCode='$(terraform plan -detailed-exitcode)'
  #terraform plan -detailed-exitcode -out changes.json
  #terraform plan -detailed-exitcode -out plan.tfplan &> plan.out
  #terraform plan -detailed-exitcode -out plan.out 1>stdout 2>err.txt 
  #terraform plan -out plan.out >plan.msg 2>&1 
  terraform plan
  #echo 'err' &2
  #read $plan.txt
  #sed -i 's/Error: Terraform exited with code 2./State Change Detected! Terraform exited with code 2/' plan.txt
  demoString="Plan: 0 to add, 1 to change, 0 to destroy."
  IFS=', ' 
  read -a tfArr <<< "$demoString"
  #OLD="Error: Terraform exited with code 2."
  #NEW="State Change Detected! Terraform exited with code 2."
  #sed -i "s/$OLD/$NEW/g" 'plan.msg'
  echo 'To Add:' ${tfArr[0]} 
  echo 'To Change:' ${tfArr[1]} 
  echo 'To Destroy:' ${tfArr[2]} 
  exitCode=$?
  #echo 'Printing plan.msg............'
  #cat 'plan.msg'
  #cat stdout
  #terraform show -json 
  #echo'_------------------_'
  #cat stderr
  echo 'exitCode is: ' $exitCode
  echo '$? is: ' $?
  #exitCode=$?
  
  
  
  if terraform show greatPlan | grep -q " 0 to add, 0 to change, 0 to destroy"; then 
  echo "##[section]No changes, terraform apply will not run";

  # Check if resources destroyed. If no, don't require approval
  elif terraform show greatPlan | grep -q "to change, 0 to destroy"; then 
    echo "##[section]Approval not required";
    echo "##[section]Automatic terraform apply triggered";
    echo "##vso[task.setvariable variable=approvalRequired;isOutput=true]false"

  # Check if resources destroyed. If yes, require approvals
  else 
    //echo "::set-output name=stdout::$(cat ./err.txt)"
    //cat err
    #echo "::set-output name=exitcode::$exitCode"
    echo "##[section]Terraform apply requires manual approval";
    echo "##vso[task.setvariable variable=approvalRequired;isOutput=true]true"
  fi
}


function name_func(){
  a=1
  b=1
  sum=$(($a+$b))
  echo $sum
  exitCode=$sum
  if [ $exitCode -eq 2 ]; then
    echo 'Changes Detected!'
  elif [ $exitCode -eq 1 ]; then
    echo 'Error Detected!'
  else
    echo 'No Changes Detected!'
  fi
}
