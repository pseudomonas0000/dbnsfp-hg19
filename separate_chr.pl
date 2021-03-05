#!/usr/bin/perl

use strict;
use warnings;

# use module
use File::Copy qw/copy move/;

# create and open the temporary flies of each chromosome dataset for writing
open my $fh1, ">", "tmp_chr1";
open my $fh2, ">", "tmp_chr2";
open my $fh3, ">", "tmp_chr3";
open my $fh4, ">", "tmp_chr4";
open my $fh5, ">", "tmp_chr5";
open my $fh6, ">", "tmp_chr6";
open my $fh7, ">", "tmp_chr7";
open my $fh8, ">", "tmp_chr8";
open my $fh9, ">", "tmp_chr9";
open my $fhM, ">", "tmp_chrM";
open my $fhX, ">", "tmp_chrX";
open my $fhY, ">", "tmp_chrY";
open my $fh10, ">", "tmp_chr10";
open my $fh11, ">", "tmp_chr11";
open my $fh12, ">", "tmp_chr12";
open my $fh13, ">", "tmp_chr13";
open my $fh14, ">", "tmp_chr14";
open my $fh15, ">", "tmp_chr15";
open my $fh16, ">", "tmp_chr16";
open my $fh17, ">", "tmp_chr17";
open my $fh18, ">", "tmp_chr18";
open my $fh19, ">", "tmp_chr19";
open my $fh20, ">", "tmp_chr20";
open my $fh21, ">", "tmp_chr21";
open my $fh22, ">", "tmp_chr22";

# standard input from cat command
for(my $i=1; my $inline=<STDIN>; $i++){
	
	chomp($inline);
	my @inarray = split(/\t/, $inline, 3);

	print STDERR "Read\t$inarray[0]\t$inarray[1]\tSTDIN Row:$i\n" if($i % 500000 == 0);
	
	if($inarray[0] eq "#chr" ||  $inarray[0] eq "." || $inarray[1] eq "."){next;}
	
	if($inarray[0] =~ /[0-9]+/){
			
			if($inarray[0] == 1){
				print $fh1 "$inline\n";
			}elsif($inarray[0] == 2){
				print $fh2 "$inline\n";
			}elsif($inarray[0] == 3){
				print $fh3 "$inline\n";
			}elsif($inarray[0] == 4){
				print $fh4 "$inline\n";
			}elsif($inarray[0] == 5){
				print $fh5 "$inline\n";
			}elsif($inarray[0] == 6){
				print $fh6 "$inline\n";
			}elsif($inarray[0] == 7){
				print $fh7 "$inline\n";
			}elsif($inarray[0] == 8){
				print $fh8 "$inline\n";
			}elsif($inarray[0] == 9){
				print $fh9 "$inline\n";
			}elsif($inarray[0] == 10){
				print $fh10 "$inline\n";
			}elsif($inarray[0] == 11){
				print $fh11 "$inline\n";
			}elsif($inarray[0] == 12){
				print $fh12 "$inline\n";
			}elsif($inarray[0] == 13){
				print $fh13 "$inline\n";
			}elsif($inarray[0] == 14){
				print $fh14 "$inline\n";
			}elsif($inarray[0] == 15){
				print $fh15 "$inline\n";
			}elsif($inarray[0] == 16){
				print $fh16 "$inline\n";
			}elsif($inarray[0] == 17){
				print $fh17 "$inline\n";
			}elsif($inarray[0] == 18){
				print $fh18 "$inline\n";
			}elsif($inarray[0] == 19){
				print $fh19 "$inline\n";
			}elsif($inarray[0] == 20){
				print $fh20 "$inline\n";
			}elsif($inarray[0] == 21){
				print $fh21 "$inline\n";
			}elsif($inarray[0] == 22){
				print $fh22 "$inline\n";
			}
		next;
		}

	if($inarray[0] eq "M"){
		print $fhM "$inline\n";
	}elsif($inarray[0] eq "X"){
		print $fhX "$inline\n";
	}elsif($inarray[0] eq "Y"){
		print $fhY "$inline\n";
	}

}

# close temporary files
close($fh1);
close($fh2);
close($fh3);
close($fh4);
close($fh5);
close($fh6);
close($fh7);
close($fh8);
close($fh9);
close($fhM);
close($fhX);
close($fhY);
close($fh10);
close($fh11);
close($fh12);
close($fh13);
close($fh14);
close($fh15);
close($fh16);
close($fh17);
close($fh18);
close($fh19);
close($fh20);
close($fh21);
close($fh22);

# rename temporary files 
move "tmp_chr1", "separate_chr1";
move "tmp_chr2", "separate_chr2";
move "tmp_chr3", "separate_chr3";
move "tmp_chr4", "separate_chr4";
move "tmp_chr5", "separate_chr5";
move "tmp_chr6", "separate_chr6";
move "tmp_chr7", "separate_chr7";
move "tmp_chr8", "separate_chr8";
move "tmp_chr9", "separate_chr9";
move "tmp_chrM", "separate_chrM";
move "tmp_chrX", "separate_chrX";
move "tmp_chrY", "separate_chrY";
move "tmp_chr10", "separate_chr10";
move "tmp_chr11", "separate_chr11";
move "tmp_chr12", "separate_chr12";
move "tmp_chr13", "separate_chr13";
move "tmp_chr14", "separate_chr14";
move "tmp_chr15", "separate_chr15";
move "tmp_chr16", "separate_chr16";
move "tmp_chr17", "separate_chr17";
move "tmp_chr18", "separate_chr18";
move "tmp_chr19", "separate_chr19";
move "tmp_chr20", "separate_chr20";
move "tmp_chr21", "separate_chr21";
move "tmp_chr22", "separate_chr22";

