#!/usr/bin/perl
use strict;
open A,$ARGV[0];
open B,$ARGV[1];
while (my $a=<A>) {
	chomp($a);
	$a=~s/@/>/;
	my $b=<A>; chomp($b);
	my $c=<A>; chomp($c);
	my $d=<A>; chomp($d);
	print "$a\n$b\n";

}
