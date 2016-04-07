#!/usr/bin/perl

# Downloads boxarts from TheGameDB
# Usage: ./tgdb.pl path/to/file.dat

use v5.16.0;
use File::Basename;
use feature "switch";
use utf8;
use Data::Dumper;
use LWP::Simple;
use LWP::UserAgent;
use XML::Simple;
binmode(STDOUT, ":utf8");

sub slurp { local $/; open(my $fh, '<:utf8', shift); <$fh> }

my $dat = slurp $ARGV[0];
my $system = basename($ARGV[0]);
$system =~ s/\.dat//;

say $system;

mkdir "$system/Named_Boxarts", 0755;

my $hashes = slurp "hash.csv";
my @hashes = split "\n", $hashes;

my $ua = LWP::UserAgent->new;
$ua->agent('Mozilla/5.0');

while ($dat =~ /game \(\r\n(?<game>.*?)\r\n\)\r\n/smg) {

	my %rom;
	my $title;
	for my $line (split "\r\n", $+{game}) {
		$line =~ /(?<key>\w+)\s(?<value>.*)$/;
                if ($+{key} eq "name")
                {
                        $title = $+{value};
                        $title =~ s/"(?<title>.*)"/$1/;
                }
		elsif ($+{key} eq "rom")
		{
			my @rom;
			my $romline = $+{value};
			while ($romline =~ /(".+?")|(\w+)/g)
			{
				push @rom, $1 || $2;
			}
			%rom = @rom;
		}
	}

	my $sha1 = lc %rom{sha1};

	#if (($title cmp 'S') == -1) {
	#	next;
	#}
	
	say "sha1 ", $sha1;
	my @res = grep { /^${sha1}(.*)$/ } @hashes;
	my $res = @res[0];
	my $gdbid = (split ",", $res)[1];
	say $gdbid;
	if ($gdbid and ! -e "$system/Named_Boxarts/$title.png"
	           and ! -e "$system/Named_Boxarts/$title.jpg")
	{
		my $txt = $ua->get("http://thegamesdb.net/api/GetGame.php?id=$gdbid")->content;
	 	my $xml = XMLin($txt, ForceArray => [ 'boxart' ]);

		for (@{ $$xml{Game}{Images}{boxart} })
		{
			say $$xml{baseImgUrl} . $$_{content} if $$_{side} eq "front";

			if ($$_{side} eq "front") {
				my $request = HTTP::Request->new( GET => $$xml{baseImgUrl} . $$_{content} );
				my $response = $ua->request($request);
				my $content = $response->content."\n";

				open FILE, ">$system/Named_Boxarts/$title.jpg" or die "Can't create file: $!.\n";
				binmode FILE;
				
				if ($response->is_success){
					print FILE $content;
			                say "File downloaded and saved!!!";
				}

				close FILE;
			}
		}
	}

	if (!$gdbid)
	{
		open TXT, ">>$system/Named_Boxarts/$title.txt" or die "Can't create file: $!.\n";
		close TXT;
	}
}
