#!/bin/bash
inputfile=""
output=$HOME/.ssh/config
key_default="CTF.key"

# Options
while [ True ]; do
if [ "$1" = "--help" -o "$1" = "-h" ]; then
    cat README.md
    shift 1
elif [ "$1" = "--inputfile" -o "$1" = "-i" ]; then
    inputfile=$2
    shift 2
elif [ "$1" = "--key" -o "$1" = "-k" ]; then
    key=$2
    shift 2
elif [ -z $1 ]; then
  break
else
    echo "Unrecognized option: '$1'"
    echo "See the output of '--help' or '-h' for a summary of options."
    exit 1
fi
done

# Verify -i option
if [[ -z $inputfile ]]; then
  echo "you must add the option: -i <inputfile>"
  echo "inputfile form : <IP@>:<username>"
  echo "                 <IP@>:<username>:<hostname>"
  exit 1
fi


mkdir -p $HOME/.ssh
chmod 0700 $HOME/.ssh

# Gen ssh key
if [ -z "$key"]; then
  key=$key_default
  ssh-keygen -t rsa -b 4096 -f ~/.ssh/$key -C "CTF"
fi

# Create ssh config file
i=1
machineName_default="m"
while IFS=':' read -r hostName user machineName; do
  if [ -z "$machineName"]; then
    machineName=$machineName_default$i
  fi
  # Fill the ssh config file
  echo "Host $machineName" >> $output
  echo "  HostName $hostName" >> $output
  echo "  User $user" >> $output

  if [ "$key" -eq "$key_default"]; then
    key=$key.pub
  fi
  ssh-copy-id -i $HOME/.ssh/$key $machineName

  i=$((i+1))
done < "$inputfile"

cat $output
