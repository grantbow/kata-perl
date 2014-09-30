package Minesweeper;

use strict;
use warnings;

sub Process_grid{

=head1 Process_grid
        input: a file containing
            grid size on the first line: #x#
            bomb locations on subsequent lines: #,#
        returns: string of grid, space separated locations
            X is a bomb
            # is adjacent bombs
=cut
    
    my $input = shift; # "data/simple.txt"
    open my $info, $input or die 'Could not open file.';
    my $eachline = <$info>;
    chomp $eachline;

    my ($xsize, $ysize) = split('x', $eachline);
    my %board;
    my $x;
    my $y;
    my $bx;
    my $by;

        #board = [[]] * (ysize+1)
        # initialize board
        #   for i in range(ysize):
        #   board[i] = [0] * (xsize+1)

    while (my $line = <$info>) {
        chomp $line; # pesky newlines
        my ($bx, $by) = split(',', $line);
        #$bx = int $bx;
        #$by = int $by;
        #print "bx $bx by $by\n";
        # defined() is the only way to tell undefined from a 0 integer!

        if (defined($by) && ($bx <= $xsize) && ($by <= $ysize)) {
            $board{$bx, $by} = 'X';
        }
        #$value = exists $matrix{"$x,$y,$z"} ? $matrix{"$x,$y,$z"} : 0;
        #if (bx <= xsize) & (by <= ysize):
        #    board[bx][by] = "X"
    }
    #print %board;
    #print "\n";
    my $grid = '';

    for(my $j=0;$j<$ysize;$j++) { 
        for(my $i=0;$i<$xsize;$i++){ 
#   for y in range(ysize):
#       for x in range(xsize):
#           if not (board[x][y] == "X"):
        #$value = exists $matrix{"$x,$y,$z"} ? $matrix{"$x,$y,$z"} : 0;
            #print "$i, $j, $board{$i, $j} \n";
            if (exists $board{$i, $j} ) {
                $grid = $grid . 'X ';
            } else {
                # xxx test
                #$grid = $grid . '0 ';
                #print "xsize $xsize, ysize $ysize, i $i, j $j\n";
                my $z =  Minesweeper::adjacent(\%board, $xsize, $ysize, $i, $j);
                $grid = $grid . int($z) . ' ';
            }
#               board[x][y] = adjacent(board,bx,by,x,y)
#           if (x == xsize-1):
#               grid += str(board[x][y])
#           else:
#               grid += str(board[x][y]) + " "
#       if not (y == ysize):
#           grid += "\n"
        }
        $grid = $grid . "\n";
    }
    #print $grid; # string of grid

#   my $grid = "2 2 1 0 0 0 0
#X X 1 0 0 0 0
#X 3 1 0 0 0 0
#1 1 0 0 0 0 0
#0 0 0 0 0 0 0
#0 0 0 0 0 0 0
#0 0 0 0 0 0 0";

    close $input;
    return $grid; # string of grid
}


sub adjacent {
    #board, bx, by, x, y
    my $param = shift;
    my %aboard = %$param;
    my $abx = int shift;
    my $aby = int shift;
    my $ax = int shift;
    my $ay = int shift;

    my $count = 0; # counter
    # edge detection setup
    my $top = 0;
    my $bot = 0;
    my $left = 0;
    my $right = 0;
    # check edges
    if ($ay > 0) { $top=1; }
    if ($ay < $aby - 1) { $bot=1; }
    if ($ax > 0) { $left=1; }
    if ($ax < $abx - 1) { $right=1; }
    #print "t $top b $bot l $left r $right\n";
    # add adjacent bomb locations
    if ($top) {
        if (defined $aboard{$ax, $ay-1}) {
            $count += 1;
        }
        if ($left) {
            if (defined $aboard{$ax-1, $ay-1}) {
                $count += 1;
            }
        }
        if ($right) {
            if (defined $aboard{$ax+1, $ay-1}) {
                $count += 1;
            }
        }
    }
    if (($left) && (defined $aboard{$ax-1, $ay})) {
        $count += 1;
    }
    #print "right ab $aboard{$ax+1, $ay} \n";
    if (($right) && (defined $aboard{$ax+1, $ay})) {
        $count += 1;
    }
    if ($bot) {
        #print "bot ab $aboard{$ax, $ay+1} \n";
        if (defined $aboard{$ax, $ay+1}) {
            $count += 1;
        }
        if ($left) {
            #print "bot left ab $aboard{$ax-1, $ay+1} \n";
            if (defined $aboard{$ax-1, $ay+1}) {
                $count += 1;
            }
        }
        if ($right) {
            #print "bot right ab $aboard{$ax+1, $ay+1} \n";
            if (defined $aboard{$ax+1, $ay+1}) {
                $count += 1;
            }
        }
    }
    return $count;
}

1;

