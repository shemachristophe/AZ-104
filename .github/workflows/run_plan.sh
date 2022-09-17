#! /usr/bin/env bash

function get_terraform_plan_return_message(){
  set +e
  #exitCode='$(terraform plan -detailed-exitcode)'
  #terraform plan -detailed-exitcode -out changes.json
  #terraform plan -detailed-exitcode -out plan.tfplan &> plan.out
  terraform plan -detailed-exitcode -out plan.tfplan 1>stdout 2>err.txt | sed 's/Error: Terraform exited with code 2./State Change Detected! Terraform exited with code 2/'
  #echo 'err' &2
  read stdout
  #sed -i 's/Error: Terraform exited with code 2./State Change Detected! Terraform exited with code 2/' stdout
  exitCode=$?
  cat stdout
  #echo'_------------------_'
  #cat stderr
  echo 'exitCode is: ' $exitCode
  echo '$? is: ' $?
  #exitCode=$?
  
  
  
  if terraform show plan.out | grep -q " 0 to add, 0 to change, 0 to destroy"; then 
  echo "##[section]No changes, terraform apply will not run";

  # Check if resources destroyed. If no, don't require approval
  elif terraform show plan.out | grep -q "to change, 0 to destroy"; then 
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
