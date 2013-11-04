#!/usr/bin/perl -w
# simulation DNA
#  using a random number generator to randomly select bases to simulation in intergenic region;
# useage : write a shell;
# number=0
#until [ $number -ge 1000 ]; do
 #    perl Pick_random_intergenic.pl dmel-2L-chromosome-r5.47.fasta all.gene.infor.500.flanking output.$number
  #  number=$((number + 1))
#done
use strict;
use warnings;

open IN,"$ARGV[0]" || die"$!";＃input chromosome sequences
open Exc,"$ARGV[1]" || die"$!"; ＃ excluded location, including gene, gene flanking and repeat sequeences
open OUT,">$ARGV[2]" || die"$!";
$/=">";
<IN>;
while(<IN>) {	
    		chomp;
      		my @lines = split /\n/,$_;
       		my $id = $lines[0];
      		my  $DNA = join "",@lines[1..$#lines]; # from line1 to the last line, if not,they will add name length

		my $i; # $i is a common name for a counter variable, short for "integer"
		my $simulation;

# Seed the random number generator
# time|$$ combines the current time with the current process id

    	srand(time|$$);
    	
		my %hash_gene;
		my %hash_chr;
		my %hash_chr_left;
		my @infor;
		my %infor;
		my %hash_chr_right;
		$/ = "\n";
		while(<Exc>){
		chomp;
		my @infor=split;
		$hash_gene{$infor[0]} = $infor[0];
		$hash_chr{$infor[0]}= $infor[1];
		$hash_chr_left{$infor[0]} = $infor[2];
		$hash_chr_right{$infor[0]}= $infor[3];
	}

		for ($i=0 ; $i < 300; $i++) {
    			$simulation = simulation($DNA);
  #  print OUT "$simulation\n";
	}	
	    	
		exit;

		sub simulation {
		my $position;
		my $new;
		my %position;

		my($DNA) = @_;
    
   
		$position = randomposition($DNA);
		my $mark = 0;
		foreach my $key (keys %hash_gene) { 
		
						if (($position+800) >= $hash_chr_left{$key} && $position <= $hash_chr_right{$key})      {$mark++;}   ## here if there's no genes includes this site, $mark remains 0#       }

						 }
		my $count = 0;
		 if($mark == 0 ) {

        		 $new = substr ($DNA,$position,800); $count++;
        	if (length $new == 800 && $count <= 48) {
          		print OUT ">\t$position\t800\n$new\n"; }
        		}

   		}
    		
	   $/ = ">";
	    }

sub randomposition {

my($string) = @_;

return int rand length $string;
    
}
