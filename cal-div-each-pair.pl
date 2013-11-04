#!/usr/bin/perl
#use strict;
#use warnings;

#use in perl >5.10
#2L      194308  T       G       CD;NS;AC=2      0       0       0       0       0       0
#2L      194487  C       A       CD;NS;AC=1      0       0       0       0       0       0
#2L      194538  A       C       CD;NS;AC=6      0       0       0       0       0       0
#2L      194568  G       A       CD;NS;AC=23     0       0       0       0       0       1

open SNP, $ARGV[0]||die; #read snp file
open Gene,$ARGV[1]||die; #read gene location file
open OUT1, ">$ARGV[2]" ||die; #div.upstream.exp.lines
open OUT2, ">$ARGV[3]" ||die; #div.upstream.between.exp.lines.and.non.exp.lines
open OUT3, ">$ARGV[4]" ||die; #div.upstream.non.exp.lines
my %hash;
while (<SNP>) {
	chomp;
	my @infor=split;
	#double hash;
	$hash{"$infor[0]\t$infor[1]"}{"R304"}=$infor[5];
	$hash{"$infor[0]\t$infor[1]"}{"R307"}=$infor[6];
	$hash{"$infor[0]\t$infor[1]"}{"R357"}=$infor[7];
	$hash{"$infor[0]\t$infor[1]"}{"R360"}=$infor[8];
	$hash{"$infor[0]\t$infor[1]"}{"R399"}=$infor[9];
	$hash{"$infor[0]\t$infor[1]"}{"R517"}=$infor[10];
}
close SNP;


my $d;
#2L      120000  130000  strainD strainE
while (<Gene>) {
my @infor=split;
my $div;
my @list1 = ('R304','R307','R357','R360','R399','R517');
my @list2 = ('R304','R307','R357','R360','R399','R517');
my @list3 = ($infor[3],$infor[4],$infor[5],$infor[6]);
	for (my $i=0;$i<=5;$i++) {
	for (my $j=0;$j<=5;$j++) {
	
		if ($list1[$i] ne $list2[$j] && $i<$j) {
		$div=0;
    		for (my $q=$infor[1]-500;$q<=$infor[1];$q++) {
				if (exists $hash{"$infor[0]\t$q"}) {	
		    	#print "$list1[$i]\t$list2[$j]\n";
				my ($div_num)=div("$infor[0]\t$q",$list1[$i],$list2[$j]);
				$div+=$div_num;
	    		}
			}
			if ($list1[$i] ~~ @list3 and $list2[$j] ~~ @list3){
    		print OUT1 "$infor[0]\t$infor[1]\t$infor[2]\t$list1[$i]\t$list2[$j]\t$div\n";
   			}
   			if (($list1[$i] ~~ @list3 and $list2[$j] !~ @list3) or ($list1[$i] !~ @list3 and $list2[$j] ~~ @list3) ){
    		print OUT2 "$infor[0]\t$infor[1]\t$infor[2]\t$list1[$i]\t$list2[$j]\t$div\n";
    		}
    		if ($list1[$i] !~ @list3 and $list2[$j] !~ @list3) {
    		print OUT3 "$infor[0]\t$infor[1]\t$infor[2]\t$list1[$i]\t$list2[$j]\t$div\n";
       		}
		
		}	
	}
	}
}


##the function of calculating div of two sequences
sub div{
	my ($pos,$strain1,$strain2)= @_;
	my $div_num  ;
	if ($hash{$pos}{$strain1} ne $hash{$pos}{$strain2}) {$div_num=1;}
	if ($hash{$pos}{$strain1} eq $hash{$pos}{$strain2}) {$div_num=0;}
	#print $pop1_p;
return ($div_num);
}

