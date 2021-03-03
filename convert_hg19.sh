#!/usr/bin/bash

# for file in dbNSFP4.0c_variant.chr*; do
# 	cat ${file} | perl dbNSFP4.0c_sort.pl > ${file}_convert-hg19
# done



version="4.0c"
cat dbNSFP${version}_variant.chr* | perl remove_hg38.pl dbNSFP${version}_variant.chr


# ワンライナー
# ls dbscSNV1.1.chr* | xargs -I {} bgzip {}


