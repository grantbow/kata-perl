#!/usr/bin/perl

use Test::More tests => 2;

use Minesweeper;

my $result = Minesweeper::Process_grid("data/simple.txt");
my $target = "2 2 1 0 0 0 0 
X X 1 0 0 0 0 
X 3 1 0 0 0 0 
1 1 0 0 0 0 0 
0 0 0 0 0 0 0 
0 0 0 0 0 0 0 
0 0 0 0 0 0 0 
";

ok(defined($result));
is($result, $target, " data/simple.txt result");

