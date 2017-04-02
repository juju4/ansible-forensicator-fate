#!/usr/bin/perl -w
## from https://digital-forensics.sans.org/blog/2010/02/22/extracting-known-bad-hashset-from-nsrl/
# Extracts known good and known bad hashsets from NSRL
# uso: nsrlext.pl -n <nsrl files comma separated> -p <nsrl prod files comma separated> -g <known good txt> -b <known bad txt> [-h]
#
# -n :nsrl files comma separated. Ex: -n c:\nsrl\RDA_225_A\NSRLFile.txt,c:\nsrl\RDA_225_B\NSRLFile.txt
# -p :nsrl prod files comma separated. Ex: -p c:\nsrl\RDA_225_A\NSRLProd.txt,c:\nsrl\RDA_225_B\NSRLProd.txt
# -g :known good txt filename. Ex: -g good.txt
# -b :known bad txt filename. Ex: -b bad.txt
# -h :help
#
#
use Getopt::Std;

my $ver="0.1";

#opcoes
%args = ( );
getopts("hn:p:g:b:", \%args);

#help
if ($args{h}) {
    &cabecalho;
    print <<DETALHE ;
    uso: nsrlext.pl -n nsrl_files_comma_separated -p nsrl_prod_files_comma_separated [-g known_good_txt] [-b known_bad_txt] [-h]

    -n :nsrl files comma separated. Ex: -n c:\\nsrl\\RDA_225_A\\NSRLFile.txt,c:\\nsrl\\RDA_225_B\\NSRLFile.txt
    -p :nsrl prod files comma separated. Ex: -p c:\\nsrl\\RDA_225_A\\NSRLProd.txt,c:\\nsrl\\RDA_225_B\\NSRLProd.txt
    -g :known good txt filename. Ex: -g good.txt
    -b :known bad txt filename. Ex: -b bad.txt
    -h :help

DETALHE
    exit;
}

die "Enter the NSRL hashset file list (comma delimited)\n" unless ($args{n});
die "Enter the NSRL product file list (comma delimited)\n" unless ($args{p});

die "Enter known good and/or known bad output filenames\n" unless (($args{g}) || ($args{b}));

my %hack;

&cabecalho;

#Prod files
my @prod = split(/,/, $args{p});

foreach $item (@prod) {
    open(PRODUCT, "< $item");

    while (<PRODUCT>) {
        chomp;
        my @line = split(/,/, $_);

        #create a hash of hacker tool codes
        $hack{$line[0]} = $item if ($line[6] =~ /Hacker Tool/);
    }

    close(PRODUCT);
}

#hashset files
my @hset = split(/,/, $args{n});

open(BAD, "> $args{b}") if ($args{b});
## add header line for bad. required for hfind
print BAD '"SHA-1","MD5","CRC32","FileName","FileSize","ProductCode","OpSystemCode","SpecialCode"';

open(GOOD, "> $args{g}") if ($args{g});

my $i=0;

foreach $item (@hset) {
    open(NSRL, "< $item");

    while (<NSRL>) {

        #stdout feedback
        print ">" if (($i % 10000) == 0);

        my @line = split(/,/, $_);

        if ($hack{$line[5]}) {
            #is a hacker tool
            print BAD $_ if ($args{b});
        }
        else {
            print GOOD $_ if ($args{g});
        }

        $i++;
        }

        close(NSRL);
    }

    print "\nDone !\n";

    close(BAD)  if ($args{b});
    close(GOOD) if ($args{g});

### Sub rotinas  ####

sub cabecalho {
    print <<CABEC;

    nsrlext.pl v$ver
    Extracts known good and known bad hashsets from NSRL
    Tony Rodrigues
    dartagnham at gmail dot com
--------------------------------------------------------------------------

CABEC

}

#-----EOF-------

