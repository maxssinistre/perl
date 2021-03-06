#!/usr/bin/perl
#     This program is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
# 
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
# 
#     You should have received a copy of the GNU General Public License
#     along with this program.  If not, see <http://www.gnu.org/licenses/>.

my $VERSION = 0.1;

use strict;
use warnings;
use URI::Escape;
use Getopt::Long;

my $VERSION = "0.1";

my $home =$ENV{HOME};
my $pwd = $ENV{PWD};

my $help;
my $version = 0;
my $destination;
my $quiet;
my $get_url;
my $title;
my $title_of_the_page;

my $found = 0;

GetOptions (
"h|help" => \$help,
"v|version" => \$version,
"o|output=s" => \$destination,
"q|quiet" => \$quiet,
"t|title" => \$title,
"g|get-url" => \$get_url
);

my ($url) = @ARGV;


if (	(!defined($url)) and 
	(!defined($help))and 
	(!defined($destination))and
	(!defined($quiet))and
	(!defined($title))and
	(!defined($get_url))and
	(($version eq 1)) 
    ){
die "$VERSION\n";
}



elsif ((!defined($url)) or (defined($help)) ) {
die "
usage: dailymotion-dl [options] video_url

options:
  -h, --help            print this help text and exit
  -v, --version         print program version and exit

  -o FILE, --output=FILE
                        output video file name
  -q, --quiet           activates quiet mode
  -t, --title           use title in file name
  -g, --get-url         print final video URL only
";
}


unless (-e "$home/.dailymotion" ){
mkdir "$home/.dailymotion";
}

chdir "$home/.dailymotion";
system "wget","-q", "-O","temp.html", "$url";
open(HTML, "temp.html");

my $line;
while ($line = <HTML>){

#<meta name="title" content="Dailymotion : Richard Stallman Free software Song" />
	if ($title){
		if ($line =~/<meta name="title" content="Dailymotion\s*:\s*(.*)"\s*\/>/){
			$title_of_the_page = $1;
# 			$title_of_the_page= decode("utf8", $title_of_the_page);
			$title_of_the_page = decode_entities($title_of_the_page);
			$title_of_the_page =~ s/\//of/;
			$title_of_the_page =~ s/\s+/_/g;
			}
}

#addVariable("url", "http%3A%2F%2Fdailymotion.com%2Fget%2F14%2F320x240%2Fflv%2F3891914.flv%3Fkey%3Dd23c5b681ac9f687d518f744b8e3058b130b08f")
	
# 	if ($line =~ /addVariable\(\"url\",\s*\"(.*)\"\)/){
	if ($line =~ /addVariable\(\"video\",\s*\"(.*)\"\)/){
		$url = $1;
		$found = 1;
		}
}

if($found eq 0) {
die"several things could have happened:\n*or you typed the wrong url\n*or the video has been removed for copyright reasons\n*or dailymotion changed its javascript codes\n";
}


# if (! defined($destination) ){
# $destination = "$pwd";
# }

if (defined($destination) and ($destination !~ /\//) ){
$destination = "$pwd/$destination";
}

if ($title) {
	if (! defined($destination) ){
		$destination = "$pwd/$title_of_the_page";
	}
	else {
		$destination = "$destination/$title_of_the_page"
	}
}

if (defined($destination) and ($destination !~/.flv/) ){
$destination = "$destination.flv"
}

my $garbage;
$url = uri_unescape($url);
# print "$url\n";
($url,$garbage) = split (/\|\|/,$url);
# print "$url\n";
$url =~ s/\@\@spark//;
# print "$url\n";
$url = "http://www.dailymotion.com$url";
# die $url;

if ($get_url) {
print "$url\n";
}

else {

if ($destination){
	if ($quiet){
		system "wget","-q","-O","$destination", "$url";
		}
	else {
		system "wget","-O","$destination", "$url";
		}
}
else {
	chdir $pwd;
	if ($quiet){
		system "wget","-q","$url";
		}
	else {
		system "wget","$url";
		}
}

}


=head1 NAME

dailymotion-dl - a script to download from dailymotion

=head1 DESCRIPTION

This script is a command line script similar to the python script youtube-dl that downloads from youtube

=head1 README

This script is a command line script similar to the python script youtube-dl that downloads from youtube
you'll need the following in order to run it:
*the URI::Escape perl module
*the Getopt::Long perl module
*wget.which is normaly included in any linux distribution


=head1 PREREQUISITES

This script requires the C<URI::Escape> module and the C<Getopt::Long>.  It also requires
wget.

=pod OSNAMES

linux

=pod SCRIPT CATEGORIES

Web

=cut
