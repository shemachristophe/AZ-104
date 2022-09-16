#! /usr/bin/env bash

function get_terraform_plan_return_message(){
  terraform plan -detailed-exitcode
  echo $?
  exitCode=$?
  
  if [ $exitCode -eq 2 ]; then
    echo 'Changes Detected!'
  elif [ $exitCode -eq 1 ]; then
    echo 'Error Detected!'
  else
    echo 'No Changes Detected!'
  fi
}


function name_func(){
  1+1
  echo $?
  exitCode=$?
  if [ $exitCode -eq 2 ]; then
    echo 'Changes Detected!'
  elif [ $exitCode -eq 1 ]; then
    echo 'Error Detected!'
  else
    echo 'No Changes Detected!'
  fi
}
