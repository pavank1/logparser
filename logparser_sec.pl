#!/usr/bin/perl -w
#=================================================================================================
#Script Name : logparser.pl
#Purpose : Data spread in multiple line in one single line
#Usage : gpqp.pl -I <log file name> -O <output file>
#Dependency : None
#Author : Pavan Kumar
#Date Creation : 13th Oct, 2011
#Last Modified : 14th Oct, 2011
#Change History : 
#=================================================================================================

use Getopt::Std;
getopt('IOH');           # I,O,H are valid switches

my $CONFLOC = '/app/gpadmin/pk/script';

open(SEQ, "$opt_I") or die "Can't open input file log : $!\n";  ##open for read
open(SEQ1,">$opt_O") or die "Can't open output file in gp_data : $!\n"; ##open for write

my $line = "";
my $PreviousLine ="";
my $linefound = 0;
my $linenum = 0;
my $linenumchange = 0;
my $linefoundb = 0;
my $wherevalue = "";
my $wherefound = 0;
my $whereline = "";
my $cline="";
my $dline = "";
my $char1=",";
my $pos = -1;
my $counter=1;

LINE: while ($line = <SEQ> ) {
	if ( $line =~m/AM\,|PM\,/m ) { 
        	if ($linefound == 1 ) { print SEQ1 "$PreviousLine\r\n"; $PreviousLine =''; }
        	if ($linenum > 0 ) { print SEQ1 "$PreviousLine\r\n"; $linenum = 0;$PreviousLine =''; }
		$line =~ s/\r//g;  ## remove return character	
	while ($counter < 9 ) {  ## get the postition of 9th ","
		$pos = index($line,$char1,$pos);
		##print "POS -found at position"."$pos\n";
		$pos++;
		$counter++;
	}

        $cline = substr($line,0,$pos);  ## get the line text before 8th ","
        $dline = substr($line,$pos); ## get the line text after 8th ","
  	##print "Dline - "."$dline\n";
	$dline =~ s/,//g;  ## remove "," 
##	print "DDline - "."$dline\n";
	$pos=-1;
	$counter=1;
       	$PreviousLine = $cline.$dline; 
##	print "In AM - Previous line $PreviousLine";
       	$linenum = 0;
       	$linefound = 1;
        }
	else {
		if ( $line !~m/AM\,|PM\,/m )   { ##&& ($linenum > 0 ) {
			$linefound=0;
			if ($linenum == 0 ) { chomp($PreviousLine)}
			$linenum++;
			$line = join(", ",split ",", $line);
			chomp($line);
			$line =~ s/\n+/\n/g; ## remove blank line
			$line =~ s/^\s+//g;  ## remove leading space
			$line =~ s/\s+$//g;  ## remove trailing space
			$line =~ s/\,//g;  ## remove "," 
	##	1 while	$line =~ s/,//g;  ## remove "," 
			##$line = join(" ",split ",", $line);
			##next LINE unless length($line);
			$PreviousLine = "$PreviousLine".' '.$line;
##			print "In nonAM PreviousLine - $PreviousLine";
		}
	}
			
}

close(SEQ1);

close(SEQ);
