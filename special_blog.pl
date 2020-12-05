#!/usr/bin/perl -w
#------------------------------------------------------
# Script Name: special_blog.pl
# Script Version: 1.0
# Date: Wed Feb  1 14:31:11 EST 2012
# Author: sys2x5
# Description: script to get blogs from anywhere
# Revision history:
#       1.0/Wed Feb  1 14:31:11 EST 2012 : original version
#------------------------------------------------------

#------------------------------------------------------
# Function:
# Version Added:
# Input:
# Output:
# Description:
#------------------------------------------------------

use warnings;
use strict;
use FileHandle;
use diagnostics;
use Getopt::Long; 
use File::Copy;

#commandline arguments

#my @ARGV = () ;
my $site = '0' ; 
my $archive = '0' ; 
my $help = '0' ;


my $result = GetOptions ( 
	"SITE=s" => \$site,
	"ARCHIVE" => \$archive,
	"HELP" => \$help,
			);


			
#print "$site \n" ;
#print "$archive  \n" ;
#print "$help  \n" ;



my $page = `wget -O - "$site"`;

$site =~ s/\/$// ;
#if ( $site =~ m/\/$/ ) {
#	
#	$site = $_ ;
#	chomp ( $site );
#	
#}

#my $site_name = `echo $site | rev | cut -d"/" -f2- | rev`;
my @site_name_array = split /\//, $site ;
#chomp ( $site_name[$3] ) ;
my $site_name = splice(@site_name_array,1,2);
#print $site_name ;
#print "@site_name_array \n\r";
#print "$site_name \n\n\n\n\n\n\n\n\n\n\n\n" ;

my @fragment_page ='';

my @links_page = '' ;
my @links_page_1 = '' ;
my @links_page_2 = '' ;
my @pic_page = '' ;
my @pic_array = '' ;
my $pic_dir = "PICS" ;
my @files = '' ;
my @png_array = '' ;
my @weird_names_array = '' ;
my @video_page = '' ;
my @video_page_2 = '' ;
my @youtube_array = '' ;
my @vid_files_array = '' ;
my @vk_files_array = '' ;

mkdir $pic_dir ;


#print "$page \n";


#pull page links out of main page variable and put in array

while ( $page =~ m/src\=\"(.*?)\"/g ) {

	 push ( @fragment_page, "$1 \n" ) ;

} ;

while ( $page =~ m/src\=\'(.*?)\'/g ) {

	 push ( @fragment_page, "$1 \n" ) ;

} ;

#addijng href info , may take this out

while ( $page =~ m/href\=\"(.*?)\"/g ) {

         push ( @fragment_page, "$1 \n" ) ;

} ;

while ( $page =~ m/href\=\'(.*?)\'/g ) {

         push ( @fragment_page, "$1 \n" ) ;

} ;

#foreach ( @fragment_page ){
#
	
#	if (/jp?g/i or /png/i or /gif/i) {
#	my $temp_page_1 = $_ ;
#
#	push ( @links_page, $temp_page_1 );
	
#	}
#}

#pullout relevant links

@links_page = grep{/jp?g/i|/png/i|/gif/i|/gifv/i} @fragment_page ;
#@video_page = grep{/mp?g/i|/wmv/i|/flv/i|/avi/i|/youtube/i} @fragment_page ;
@video_page = grep{/mp.g/i|/vk.com/i|/wmv/i|/flv/i|/avi/i|/youtube/i|/mp3/i|/gifv/i} @fragment_page ;



foreach ( @links_page ){

	my $temp_page_1 = $_ ;
	
	$temp_page_1 =~ s/";"/"\n"/i ;
	$temp_page_1 =~ m/src\=\"(.*?)\"/g ;
	$temp_page_1 =~ s/\+copy// ;
	$temp_page_1 =~ s/\_p.jpg/.jpg/i ;
	$temp_page_1 =~ s/\_q.jpg/.jpg/i ;
	$temp_page_1 =~ s/.thumbnail//i ;
	$temp_page_1 =~ s/_thumb.jpg/.jpg/i ;
	$temp_page_1 =~ s/\/tn_/\//i ;
	$temp_page_1 =~ s/\/th_/\//i ;
	$temp_page_1 =~ s/s200/s1600/i ;
#clean out filenames with 34x56 , 756x345, etc
	$temp_page_1 =~ s/-\d{2,}x\d{2,}.jpg/.jpg/g ;
	$temp_page_1 =~ s/-\d{2,}x\d{2,}.jpg/.jpg/g ;
	$temp_page_1 =~ s/-\d{2,}x\d{2,}.gif/.gif/g ;
	$temp_page_1 =~ s/-\d{2,}x\d{2,}.gif/.gif/g ;
	$temp_page_1 =~ s/-\d{2,}x\d{2,}.png/.png/g ;
	$temp_page_1 =~ s/-\d{2,}x\d{2,}.png/.png/g ;

    $temp_page_1 =~ s/\(/\\(/i ;
    $temp_page_1 =~ s/\)/\\)/i ;

	
#	$temp_page_1 =~ s/^\/\///g ;
#fix file links that are relative 
	$temp_page_1 =~ s/^\//$site_name\//g ;
	$temp_page_1 =~ s/^\.\./$site_name\//g ;
	
	push ( @links_page_2, $temp_page_1 );
	
}

#print @links_page_2 ;

#clean up duplicates

my %temp_hash = map { $_ => 1 } @links_page_2 ;
@pic_page = keys %temp_hash;


chdir ( $pic_dir ); 

foreach ( @pic_page ) {

	my $temp_page_1 = $_ ;

	system("wget --tries=1 --random-wait --connect-timeout=10 --timeout=10 -nc $temp_page_1") ;
	
}


while (<*>) 
{
	my $temp_list = $_ ;
    push (@files,"$temp_list \n") if (-f "$temp_list");
}

@png_array = grep{/png/i} @files ;

#system("convert_png.ksh") ;

#print @png_array ;

chomp( my $local_dir = `pwd` ) ;

@weird_names_array = grep{/\%/} @files ;

#print @weird_names_array ;


#print $local_dir ;

#foreach ( @png_array ){

#	my $png_file = $_ ;
#	my $jpg_file = $png_file ;
	
#	$png_file =~ s/png//i ;
#	$jpg_file =~ s/png/jpg/i ;
#print $png_file ;
#print $jpg_file ;	
#	exec("convert", "$local_dir/$png_file", "$local_dir/$jpg_file");

	
#	unlink ($png_file) ;
#}

foreach ( @weird_names_array ){

	chomp ( my $png_file = $_ );
	my $jpg_file = $png_file ;
	
	$png_file =~ s/\%//i ;
#	$jpg_file =~ s/png/jpg/i ;
#print $png_file ;
#print $jpg_file ;	
#	exec("convert", "$local_dir/$png_file", "$local_dir/$jpg_file");
move("$png_file" ,"$jpg_file");
	
#	unlink ($png_file) ;
}



#my @array  = ("abc","def","abc","ghi","ghi","abc","jklm","abc","def");
#my %hash   = map { $_ => 1 } @array;
#my @unique = keys %hash;


#@fragment_page =~ m/jpg/i ;

#print @fragment_page ;
#print @links_page ;
#print @pic_page ;
#print  @pic_array ;

#print "printing video page \n" ;


foreach ( @video_page ){

	my $temp_page_1 = $_ ;
	
	$temp_page_1 =~ s/\;/\\;/g ;
	$temp_page_1 =~ s/\&/\\&/g ;
	$temp_page_1 =~ s/\?/\\?/g ;
	$temp_page_1 =~ s/\=/\\=/g ;

	
	push ( @video_page_2, $temp_page_1 );
	
}

@youtube_array = grep{/youtube/i} @video_page_2 ;
@vid_files_array = grep{!/youtube/i} @video_page_2 ;
@vk_files_array = grep {/vk.com/i} @video_page_2 ;


#print "@youtube_array \n\n" ;

foreach ( @youtube_array ) {

       my $youtube_link = $_ ;

#      system("single_youtube.ksh -l $youtube_link") ;
#       system("youtube-dl --playlist-end 10 -v -t $youtube_link") ;
       system("youtube-dl -f \"bestvideo\[ext=mp4\]+bestaudio\[ext=m4a\]/bestvideo+bestaudio\" --merge-output-format mp4 --sleep-interval 1 --max-sleep-interval 30 --playlist-end 10 -v -t $youtube_link") ;

}


#print "@vk_files_array \n\n" ;

#http://vk.com/video_ext.php?oid=199926725&#038;id=167729392&#038;hash=c2eefdb16e9b9579&#038;hd=2 ;
#http://vk.com/video199926725_167729392?hash=c2eefdb16e9b9579a ;


foreach ( @vk_files_array ) {

        my $vid_link = $_ ;
        my @vid_k = split("=", $vid_link );

        $vid_k[1] =~ s|\D||g;
#        print "$vid_k[1] \n" ;

        $vid_k[2] =~ s|\D||g;
#       print "$vid_k[2] \n" ;

	$vid_k[3] =~ s|\D||g;
#        print "$vid_k[3] \n" ;

#	my $vk_vid = http://vk.com/video$vid_k[1]_$vid_k[2]?hash=$vid_k[2] ;

#        system("youtube-dl -v -t $vid_link") ;
        system("youtube-dl --playlist-end 10 --sleep-interval 1 --max-sleep-interval 30 -v -t http://vk.com/video$vid_k[1]_$vid_k[2]?hash=$vid_k[3]") ;

}       



#print "@vid_files_array \n\n" ;

foreach ( @vid_files_array ) {

	my $vid_link = $_ ;
	
	system("wget --tries=1 --random-wait --connect-timeout=20 --timeout=10 -nc $vid_link") ;

}
