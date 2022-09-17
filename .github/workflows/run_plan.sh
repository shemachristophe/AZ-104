#! /usr/bin/env bash

function get_terraform_plan_return_message(){
  #exitCode='$(terraform plan -detailed-exitcode)'
  terraform plan -detailed-exitcode -o=changes.json
  #exitCode=$?
  #echo 'exitCode is: ' $exitCode
  echo '$? is: ' $?
  #exitCode=$?
  
  if [ $? -eq 2 ]; then
    echo 'Changes Detected!'
    exit 0
  elif [ $? -eq 1 ]; then
    echo 'Error Detected!'
    exit 0
  else
    echo 'No Changes Detected!'
    exit 0
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
