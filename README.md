# SSH Config

[TOC]


## Introduction
This repository is used to automatically configure your ssh configuration file for a CTF :
`$HOME/.ssh/config`. You only need te create an input file with `-i` option like bellow.



## Options

-h/--help : `cat` this file.



-i/-inputfile <inputfile> : the input file containing information on ssh configuration. The format is: `<IP@>:<username>` or `<IP@>:<username>:<hostname>` for each line.



-k/--key <keyFilename> : if you already have a `keyfile.key.pub` in `$HOME/.ssh/` you can use it with this option. You only need to specify the name of the file.
:warning: **ONLY USE YOUR PUBLIC KEY :** `.key.pub`**, DON'T USE YOUR PRIVATE KEY TO CONFIGURE YOUR SSH** :warning:



## Exemples

```bash
bash sshConfig.sh -i inputfile.txt
bash sshConfig.sh -i inputfile.txt -k mykey.key.pub
```

After, if you didn't specify the <hostname> in the input file, you can connect via ssh with the command below :
```bash
ssh m1
ssh m2
#etc
```
or the <hostname> you specify :
```bash
ssh <hostname>
```
