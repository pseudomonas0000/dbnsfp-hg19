# dbnsfp-hg19

Create by pseudomonas0000
Date: 20021/3/5

## What's can we do with this building?
This script can use a command 'snpsift -dbnsfp' by hg19/GRCh37 genome position with a little memory.
Althout a [snpsift documentation](https://pcingola.github.io/SnpEff/ss_dbnsfp/) show a script converting hg38 to hg19 postion, the script must have enough memory.
This script was created with the problem of insufficient memory in mind.

## Environmet
* user/bin/bash
* user/bin/perl
* bgzip and tabix, snpsift
Tested　on macOS Catalina (10.15.7).

## Procedure
First, you need to download the dbNSFP you want to use for annotation ([dbNSFP site](https://sites.google.com/site/jpopgen/dbNSFP)).
Then, you uncompress the '.zip' file. 
__Note: Please the uncompress '.zip' file in this repository directory.__
You also need 'dbNSFP_sort.pl' script ([you can find it here](https://raw.githubusercontent.com/pcingola/SnpEff/master/scripts_build/dbNSFP_sort.pl)) on snpsift documentation.

Finally, run the 'build_pipeline.sh' script for the build.
Two command line aurgument required and an output is standard output.
* First: dbNSFP version (e.g. 4.0c)
* Second: full path to 'the dbNSFP_sort.pl' script.
As shown below:
'''console
bash build_pipeline.sh 4.0c ./dbNSFP_sort.pl > dbNSFP4.0c_hgp19
'''

For 'snpsift dbnsfp' command, compress and indexing.
'''
bgzip dbNSFP4.0c_hgp19
tabix -s 1 -b 2 -e 2 dbNSFP4.0c_hgp19.gz
'''

