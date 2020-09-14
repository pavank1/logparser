#!/usr/bin/perl -w
#=================================================================================================
#Script Name : logparser_fort.pl
#Purpose : Parse the key/value data and convert it to csv file with positional column name
#Usage : logparser_fort.pl -I <log file name> -O <output file> -C <conf file>
#Dependency : None, - conf file containing all key fields in order will be passed using -C parameter
#Author : Pavan Kumar
#Date Creation :2nd Nov., 2011
#Last Modified : 3rd Nov., 2011
#Change History : 
#=================================================================================================


use Getopt::Std;
getopt('IOC');           # I,O,C are valid switches

my $CONFLOC = '/Infa/ejxml/applog/script';

open(SEQ1,">$opt_O") or die "Can't open output file : $!\n"; ##open for write
open(SEQ, "$opt_I") or die "Can't open input file log : $!\n";  ##open for read
open(RC,"$opt_C") or die "Can't open input config file  : $!\n"; ##open for write
##open(RC, "/Infa/ejxml/applog/script/field_type.conf") or die "Can't open input file RC : $!\n";  ##open for read

my $line = "";
my $PreviousLine ="";
my $linefound = 0;
my $linenum = 0;
my $linenumchange = 0;
my $linefoundb = 0;
my $wherevalue = "";
my $wherefound = 0;
my $whereline = "";
my $cline=0;
my $dline = "";
my $char1=",";
my $pos = -1;
my $counter=1;
my @fields;
my $column='';
my $lastmached='itime=';
my $lastmatched1='';
my $column1='';
my $nextmatch='';
my $start=0;
my @linesplit;
my %mapval;
my @field_value;
my $i;
my $j=0;
my $value = "";
my $time_epoch = 0;

while ($line  = <RC> ) {
##	print "Line "."$line\n"; #	
        $fields[$cline] = $line;
	$cline++;
}
close(RC);
$line='';
while ($line = <SEQ> ) {
	@linesplit = split(/,/, $line);  ##split the line on ,
	foreach $i (@linesplit) {
		$i =~ s/^"//g;
		$i =~ s/"$//g;
##		print "id-value "."$i\n";
		@field_value = split(/=/,$i);
		$mapval{$field_value[0]} = $field_value[1];
		if ($field_value[0] =~m/itime/m ) { $time_epoch = $field_value[1];print scalar localtime($time_epoch).",\n";}
		##print "Field Value ". "$field_value[0]\n";
##		print "Map Value ". "$mapval{$field_value[0]}\n";
		@field_value = ();
	}			
	print "=================================\n";
	print SEQ1 scalar localtime($time_epoch).",";
	foreach $column (@fields) {
		chomp($column);
##		print "Column "."$column\n";
		$j++;
		if ($j==1) { ##print "Final One "."$mapval{$column}\n"; 
			print SEQ1 "$mapval{$column}"; }
		else { ##print ",Final "."$mapval{$column}\n"; 
			$value = $mapval{$column};
			chomp($value);
			print SEQ1 ","."$value"; }
		} 
	print SEQ1 "\n";
	$j=0;
	%mapval = ();
	@linesplit = ();
	@field_value = ();

		} 



close(SEQ1);
close(RC);
close(SEQ);
