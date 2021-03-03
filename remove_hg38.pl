#!/usr/bin/perl

use strict;
use warnings;

# 使用するモジュールと関数
use File::Copy qw/copy move/;



my @chrs = (1..22, "M", "X", "Y");

# Create tmporary file for each chromsome
for my $chrs (@chrs){
	my $tmpfile{$chrs} = $ARGV[0] . "chr" . $chr . ".tmp$$";
	open my $tmpfh, ">", $tmpfile
		or die qq/Cannot open $tmpfile : $!/;
}

$showTitle =1;
for(my $i=1; my $l=<STDIN>; $i++){
	if( $l =~ /^#chr/ ) {
		print $l if $showTitle;
		$showTitle = 0;
		next;
	}



}



my $tmpfile = "remove_hg38_tmp$$";


$infile =~ /(.+)\.txt/;
my $outfile = $1 . ".hg38-remove.txt";


my $count = 0;
while(<$infh>){
	my $inline = $_;

	if ($inline =~ /^#chr/){
		print $tmpfh $inline;
		next;
	}

	chomp($inline);
	my @inarray = split(/\t/, $inline, 3);

	if($inarray[0] eq "." || $inarray[1] eq "."){next;}

	print STDERR "Read\t$inarray[0]\t$inarray[1]\n" if($count % 100000 == 0);

	my $outline = join("\t", @inarray);
	print $tmpfh "$outline\n";
	$count ++;
}

close($infh);
close($tmpfh);

move $tmpfile, $outfile 
	or die qq/Cannot move $tmpfh to $outfile :$1/;