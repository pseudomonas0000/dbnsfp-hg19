#!/usr/bin/bash

# Download dbNSFP
	# v4.1が最新版のようだが、X11が必要のよう？だったため、v4.0cをダウンロードする　urlはdbNSFPサイトで要確認
	# fieldsが多くファイルサイズが大きいため、v4.0じゃなくてもいいかもしれない (ただし、バグに注意)
	# wgetでsoftgentics.ftpからダウンロード 一回目ログイン認証で失敗した 推定21GB、信大回線(300-500KB/s)で14時間 begin 11:40-01:30
wget ftp://dbnsfp:dbnsfp@dbnsfp.softgenetics.com/dbNSFP4.0c.zip

	# ダウンロード同様時間がかかるため、スクリプトにしておいても良いかも
	# Files:
		# dbNSFP4.0c_variant.chr<#>.gz      - gzipped dbNSFP variant database files by chromosomes
		# dbNSFP4.0_gene.gz                 - gzipped dbNSFP gene database file
		# dbNSFP4.0_gene.complete.gz        - gzipped dbNSFP gene database file with complete interaction columns
		# dbscSNV1.1.chr<#>                 - scSNV database v1.1 files by chromosomes
		# dbNSFP4.0c.readme.txt             - this file
		# search_dbNSFP40c.class            - companion Java program for searching dbNSFP4.0c
		# search_dbNSFP40c.java             - the source code of the java program
		# LICENSE.txt                       - the license for using the source code
		# search_dbNSFP40c.readme.pdf       - README file for search_dbNSFP40c.class
		# tryhg19.in                        - an example input file with hg19 genome positions
		# tryhg18.in                        - an example input file with hg18 genome positions
		# tryhg38.in                        - an example input file with hg38 genome positions
		# try.vcf                           - an example of vcf input file

# unzip and uncompress ワンライナー
unzip dbNSFP4.0c.zip;ls -1 *chr*gz |xargs -I {} bgzip -d -@ 4 {}

	unzip dbNSFP4.0c.zip

	# bgzip uncompress 1時間かからない
	bash bgzip-uncompress.sh

# Building dbNSFP for hg19 using dbNSFP 3.X
cat dbNSFP${version}_variant.chr* | perl dbNSFP_sort.pl 7 8 > dbNSFP${version}_hg19.txt
# 途中でperlスクリプトが終了した Killed: 9 どうやらメモリ不足で勝手にプロセスが終了したっぽい (macOS メモリ8G)
# メモリ64Gで再挑戦する

# snpsift dbnsfpコマンドがどのようにアノテーションされるのか確認する
	# chr1のみの dbNSFP.txtファイルを作成し、実行してみる
	bgzip dbNSFP4.0c_hg19_chr1.txt -@ 4
	tabix -s 1 -b 2 -e 2 dbNSFP4.0c_hg19_chr1.txt.gz

	# エラー Failed to parse TBX_GENERIC, was wrong -p [type] used?
	# おそらくchrやpositionに"."があるためと考えた
# perlスクリプトでchr列とposition列に"."のある行を削除して、compress and index.
# 必要なfieldsだけ選択してアノテーション	

perl remove-hg38.pl dbNSFP4.0c_hg19_chr1.txt
bgzip -@ 4 dbNSFP4.0c_hg19_chr1.hg38-remove.txt
tabix -s 1 -b 2 -e 2 dbNSFP4.0c_hg19_chr1.hg38-remove.txt.gz

snpsift dbnsfp -db dbNSFP4.0c_hg19_chr1.hg38-remove.txt.gz ./test/8.3kjpn.hctd.vcf \
-f aaref,aaalt,genename,cds_strand,aapos,SIFT_score,SIFT_converted_rankscore,SIFT_pred,SIFT4G_score,\
LRT_score,LRT_converted_rankscore,LRT_pred,LRT_Omega,MutationTaster_score,MutationTaster_converted_rankscore,\
MutationTaster_pred,MutationTaster_model,MutationTaster_AAE,MutationAssessor_score,MutationAssessor_rankscore,MutationAssessor_pred,\
FATHMM_score,FATHMM_converted_rankscore,FATHMM_pred,PROVEAN_score,PROVEAN_converted_rankscore,PROVEAN_pred,\
MetaSVM_score,MetaSVM_rankscore,MetaSVM_pred,MetaLR_score,MetaLR_rankscore,MetaLR_pred,M-CAP_score,M-CAP_rankscore,M-CAP_pred,\
fathmm-MKL_coding_score,fathmm-MKL_coding_rankscore,fathmm-MKL_coding_pred,fathmm-MKL_coding_group,GERP++_NR,GERP++_RS,GERP++_RS_rankscore,\
phyloP100way_vertebrate,phyloP100way_vertebrate_rankscore,phyloP30way_mammalian,phyloP30way_mammalian_rankscore,\
phastCons100way_vertebrate,phastCons100way_vertebrate_rankscore,phastCons30way_mammalian,phastCons30way_mammalian_rankscore,\
SiPhy_29way_pi,SiPhy_29way_logOdds,SiPhy_29way_logOdds_rankscore,Interpro_domain \
>test-dbnsfp-anotated.vcf