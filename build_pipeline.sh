#!/usr/bin/bash


# set your dbNSP version and path to dbNSFP_sort.pl
if [ $# -ne 2 ]; then
	echo "set 2 command line arguments, (first: dbNSP version, second: fullpath to dbNSFP_sort.pl)" 1>&2
	exit 1
fi
version=$1
perl_path=$2
chr_array=({1..22} X Y M)

# check existing the uncompressed dbnsfp datasets 
file_flag=0
for chr in ${chr_array[@]}; do
	if [ ! -e ./dbNSFP${version}_variant.chr${chr} ]; then
		echo "not exist uncompressed dbNSFP datasets in current directory. Download .zip file, unzip and decompress the dataset." 1>&2
		exit 1
	fi
done


# the hg38 position convert to hg19. 
	# if you want to use hg18 position, change 2 aurgumemt of perl script (dbNSFP_sort.pl).
	# check snpsift documentation (https://pcingola.github.io/SnpEff/ss_dbnsfp/) for details.
for chr in ${chr_array[@]}; do
	cat dbNSFP${version}_variant.chr${chr} | perl $perl_path 7 8 > dbNSFP${version}_variant.chr${chr}_hg19
done
echo "finish $perl_path"
	# for file in dbNSFP${version}_variant.chr* ; do
	# 	cat ${file} | perl perl_$path 7 8 > ${file}_hg19.txt
	# done

# each dataset separate by chromosome
cat dbNSFP${version}_variant.chr*_hg19 | perl separate_chr.pl
echo "finish separate_chr.pl"

# each dataset sort by position (it would take some time)
for chr in ${chr_array[@]}; do
	sort -t$'\t' -n -k 2,2 separate_chr${chr} >separate_chr${chr}_sorted
	echo "sorted chr${chr}"
done

	# for file in separate_chr* ; do
	# 	sort -t$'\t' -n -k 2,2 ${file} > ${file}_sorted
	# 	echo 
	# done

# concatate header infomation and each chrmosome sorted files, then standard output.
cat header.txt
for chr in ${chr_array[@]}; do
	cat separate_chr${chr}_sorted
done

