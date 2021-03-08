# dbnsfp-hg19

Create by pseudomonas0000<br>
Date: 20021/3/5

## What's can you do with this building?
This script can use a command `snpsift -dbnsfp` by hg19/GRCh37 genome position with a little memory.<br>
Althout a [snpsift documentation](https://pcingola.github.io/SnpEff/ss_dbnsfp/) show a script converting hg38 to hg19 postion, the script would often stop due to lack of memory.<br>
I provided a script that was created with the problem of insufficient memory in mind.

## Environmet
* user/bin/bash
* user/bin/perl
* bgzip and tabix, snpsift
Tested　on macOS Catalina (10.15.7).

## Procedure
First, you need to download the dbNSFP you want to use for annotation ([dbNSFP site](https://sites.google.com/site/jpopgen/dbNSFP)).
Then, you uncompress the `.zip` file. <br>
__Note: Please the uncompress `.zip` file in this repository directory.__<br>
You also need `dbNSFP_sort.pl` script ([you can find it here](https://raw.githubusercontent.com/pcingola/SnpEff/master/scripts_build/dbNSFP_sort.pl)) on snpsift documentation.<br>

Next, run the `build_pipeline.sh` script for the build.<br>
Two command line aurgument required and an output is standard output.<br>
* First: dbNSFP version (e.g. 4.0c)
* Second: full path to `the dbNSFP_sort.pl` script.
As shown below:<br>
```console
bash build_pipeline.sh 4.0c ./dbNSFP_sort.pl > dbNSFP4.0c_hgp19
```

Finally for using `snpsift dbnsfp` command, we have to compress and indexing.
```console
bgzip dbNSFP4.0c_hgp19
tabix -s 1 -b 2 -e 2 dbNSFP4.0c_hgp19.gz
```


