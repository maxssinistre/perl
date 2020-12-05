#!/usr/bin/perl -T
#------------------------------------------------------
# Script Name: chaosNpain.pl.pl
# Script Version: 1.0
# Date: Thu Jan  5 11:20:12 EST 2012
# Author: sys2x5
# Description: this is for a 6 day chaos an pain workout, randomized
# Revision history:
#       1.0/Thu Jan  5 11:20:12 EST 2012 : original version
#       2.0/Tue Jun  18 15:25:12 EST 2013 : added set and rep multipliers
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
use Getopt::Long; 
#use Scalar::MoreUtils qw(empty);

my $commandline = $#ARGV ;

#commandline arguments

#my @ARGV = () ;
my $abs = '0' ; 
my $light = '0' ; 
my $pull = '0' ; 
my $squat = '0' ; 
my $olympic = '0' ; 
my $medium = '0' ; 
my $fourworkouts = '0' ;
my $twoweeks = '0' ;
my $help = '0' ;
my $chaos = '0' ;
my $stomack = '0' ;
my $reps = 1 ;
my $groups = 1 ;

#$integer = defined($integer) ? $integer : '5';
#my $integer = $integer_s || "5" ;



my $result = GetOptions ( 
	"NATION" => \$stomack,
	"CHAOS" => \$chaos,
	"HELP" => \$help,
	"FOURWORKOUTS" => \$fourworkouts,
	"TWOWEEKS" => \$twoweeks,
	"ABS" => \$abs, 
	"MEDIUM" => \$medium, 
	"LIGHT" => \$light,
	"PULL" => \$pull,
	"SQUAT" => \$squat,
	"REPS:s" => \$reps,
	"GROUPS:s" => \$groups,
	"OLYMPIC" => \$olympic,);

#my $integer = $integer_s || "5" ;
#print "reps equal $reps \n" ;	
#print "reps equal $groups \n" ;

#Exercise list / arrays

my @PUSH = ("Push Press" , "Push Jerk" , "Overhead Press" , "Wghtd Ft-elev Pshp"); 

my @SNATCH = ("Snatch" , "Thck Snatch"); 

my @CLEANJERK = ("Clean N Jerk" , "Thck Clean N Jerk"); 

my @PULL = ("Clean pull" , "Snatch pull" , "Snatch pull deadlift" , "Cln Pll Dead" , "Rack Pulls w/shrug" , "Shrugs" , "Wghtd Pullup/Chins");

my @SQUAT = ("Alt fr/bk thrusters" , "Bk Sqt" , "Tp Part Bk Sqt" , "Bttm Up Bk Sqt" , "Fr Squat" , "Tp Part Fr Sqt" , "Bttm Up Fr Sqt", "Zercher rack Sqt");

my @BOTH = ("Alt fr/bk thrusters Qi" , "Snatch Qi" , "Clean n Jerk Qi" , "Power Snatch Qi" , "Pwr CleanNJerk Qi" , "Snatch fr Box Qi" , "Cln fr Box-jerk opt Qi");

my @LIGHT1 = ("High pulls blight" , "One arm snatch blight" , "One arm deadlift blight" , "One-leg Squat blight" , "One-leg Deadlift blight" , "Alt fr/bk thrusters blight");

my @LIGHT2 = ("Pushups blight" , "Inverted Rows blight" , "Pullup/Chinups blight" , "Face Pulls blight");

my @LIGHT3 = ("Thick Bar C n Press blight" , "Bar curl blight" , "Plver/CG cmb blight" , "Cable Bar Curl blight" , "V-bar pressdown blight" , "Fr sq shrug blight");

my @MEDIUM1 = ("Fr sq shrug pooh" , "Calf Raise pooh" , "Split Squat pooh" , "Isometric pull pooh" , "Zercher Deadlift pooh" , "Alt fr/bk thrusters pooh");

my @MEDIUM2 = ("Hise Shrug pooh" , "Snatch Pull pooh" , "Barbell Rows pooh" , "Face Pulls pooh");

my @MEDIUM3 = ("Thick Bar C n Press pooh" , "Ladder Overhead Press pooh" , "Ladder curls pooh" , "Ladder pressdown pooh" , "Weighted Chin pooh" , "Fr sq shrug pooh");

my @LINEAR = ("Medicine Ball Rollout Ab" , "Linear vertical Pallof Press Ab" , "Swiss Ball Pike Ab" , "The Body Saw Ab"); 

my @LATERAL = ("RKC Plank time" , "Side Plank on Medicine Ball time" , "Single-Arm Front Plank on Swiss Ball time" , "Turkish Get-Ups Ab" , "Angled Barbell Rainbows Ab" , "Lateral Pallof Press Ab" , "Side Plank on Medicine Ball time Ab" );

my @DYNAMIC = ("Tight Rotations time" , "The Gladiator Twist time" , "Heavy Bag Rotary Strikes time");


#Config subs

sub usage { print
" 
This is a random workout generator based on chaos n pain and my own knowledge \n

\t-abs = generate ab workout \n
\t-light = generate light workout \n
\t-pull = generate heavy pull workout \n 
\t-squat = generate heavy squat workout \n
\t-medium = generate medium workout \n 
\t-olympic = generate olympic workout \n 
\t-fourworkouts = generate four workouts ( Heavy Squat , Light Workout , Heavy Pull , Olympic Workout , Ab Workout ) \n
\t-twoweeks = generate two weeks worth of workouts ( 6 days a week ) \n
\t-groups = set the multiplier that is for the amount of sets - default is 1\n
\t-reps = set the multiplier that is for the amount of reps - default is 1\n 
\t-help = print this help statement \n
\t-chaos = print chaos n pain workout description article in all it\'s foul mouthed glory \n	
\t-nation = print t-naiton article that is the basis for the ab workout \n
\t Ladder reps are when your reps range goes up and comes back down. For example 1,2,3,4,5,6,5,4,3,2,1 
\t Please note , double the reps for the shrugs and for isomatrics, think about it.......
" ;
}

sub choice {

my $range = $_[0] ;

my $RANDOM = int(rand($range));

print $RANDOM ;

}

sub clean_name {

my $DIRTY = shift ;
#my $DIRTY = $_[0] ;

$DIRTY =~ s/time// ;
$DIRTY =~ s/Ab// ;
$DIRTY =~ s/blight// ;
$DIRTY =~ s/pooh// ;
$DIRTY =~ s/Qi// ;

return ( $DIRTY ) ;

}

sub set_reps {

my $EXERCISE = "$_[0]" ;

#print "$EXERCISE \n" ;

if ($EXERCISE =~ m/Qi/ )  
{
my $SETDECIS = &set_decision ;  
my $REPDECIS = &rep_decision_both ;
return ("$SETDECIS x $REPDECIS" );
#&set_decision ; print "x" ; &rep_decision_both ;
}
elsif ($EXERCISE =~ m/time/ )
{
my $SETDECIS = &set_decision_ab ;  
my $REPDECIS = &rep_decision_ab ;
return ("$SETDECIS x $REPDECIS" );
#&set_decision ; print "x" ; &rep_decision ; 
}
elsif ($EXERCISE =~ m/Ab/ )
{
my $SETDECIS = &set_decision_ab ;  
my $REPDECIS = &rep_decision_ab ;
return ("$SETDECIS x $REPDECIS" );
#&set_decision ; print "x" ; &rep_decision ; 
}
elsif ($EXERCISE =~ m/blight/ )
{
my $SETDECIS = &set_decision_light ;  
my $REPDECIS = &rep_decision_light ;
return ("$SETDECIS x $REPDECIS" );
#&set_decision ; print "x" ; &rep_decision ; 
}
elsif ($EXERCISE =~ m/pooh/ )
{
my $SETDECIS = &set_decision_medium ;  
my $REPDECIS = &rep_decision_medium ;
return ("$SETDECIS x $REPDECIS" );
#&set_decision ; print "x" ; &rep_decision ; 
}
else
{
my $SETDECIS = &set_decision ;  
my $REPDECIS = &rep_decision ;
return ("$SETDECIS x $REPDECIS" );
#&set_decision ; print "x" ; &rep_decision ; 
}
}

sub set_decision {

#my $NUM=&choice(3) ;
my $NUM = int(rand(7));

my @SET_NUMBER = (5 , 6 , 7 , 8 , 9 , 10 , 11) ;

#print $SET_NUMBER[$NUM] 
return $groups * ($SET_NUMBER[$NUM] ) ;

}

sub rep_decision {

my $range = 3;
my $minimum = $reps * 1;

return ( int(rand($range)) + $minimum );

}

sub rep_decision_both {

my $range = 2;
my $minimum = $reps * 1;

return ( int(rand($range)) + $minimum );

}

sub set_decision_light {

#my $NUM=&choice(3) ;
my $NUM = int(rand(4));

my @SET_NUMBER = (3 , 4 , 5 , 6) ;

return $groups * ( $SET_NUMBER[$NUM] );

}

sub rep_decision_light {

my $range = 5;
my $minimum = $reps * 3;

return ( int(rand($range)) + $minimum );

}

sub set_decision_medium {

#my $NUM=&choice(3) ;
my $NUM = int(rand(4));

my @SET_NUMBER = (5 , 6 , 7 , 8) ;

return $groups * ( $SET_NUMBER[$NUM] );

}

sub rep_decision_medium {

my $range = 3;
my $minimum = $reps * 2;

return ( int(rand($range)) + $minimum );

}

sub set_decision_ab {

#my $NUM=&choice(3) ;
my $NUM = int(rand(2));

my @SET_NUMBER = (1 , 2 ) ;

return $groups * ( $SET_NUMBER[$NUM] );

}

sub rep_decision_ab {

my $range = 15;
my $minimum = $reps * 10;

return ( int(rand($range)) + $minimum );

}

sub time_decision_ab {

my $range = 40;
my $minimum = $reps * 20;

return ( int(rand($range)) + $minimum );

}

sub time_decision_light {

my $range = 40;
my $minimum = $reps * 20;

return ( int(rand($range)) + $minimum );

}

#Exercise subs

sub ab_linear {

my $NUMBER = int(rand(4));

my $CLEAN = "$LINEAR[$NUMBER] " . &set_reps ($LINEAR[$NUMBER]) ;

clean_name ( $CLEAN );
}

sub ab_lateral {

my $NUMBER = int(rand(7));

my $CLEAN = "$LATERAL[$NUMBER] " . &set_reps ($LATERAL[$NUMBER]) ;

clean_name ( $CLEAN );
}

sub ab_dynamic {

my $NUMBER = int(rand(3));

my $CLEAN = "$DYNAMIC[$NUMBER] " . &set_reps ($DYNAMIC[$NUMBER]) ;

clean_name ( $CLEAN );
}

sub snatch {

my $NUMBER = int(rand(2));

return ( "$SNATCH[$NUMBER] " . &set_reps ($SNATCH[$NUMBER]) )  ;

}

sub cleanjerk {

my $NUMBER = int(rand(2));

return ( "$CLEANJERK[$NUMBER] " . &set_reps ($CLEANJERK[$NUMBER]) )  ;

}

sub full_body {

my $NUMBER = int(rand(7));

my $CLEAN = "$BOTH[$NUMBER] " . &set_reps ($BOTH[$NUMBER]) ;

clean_name ( $CLEAN );
}

sub Squat {

my $NUMBER = int(rand(8));

return ( "$SQUAT[$NUMBER] " . &set_reps ($SQUAT[$NUMBER]) ) ;
}

sub Push_exercise {

my $NUMBER = int(rand(4));

return ( "$PUSH[$NUMBER] " . &set_reps ($PUSH[$NUMBER]) )  ;

}

sub heavy_pull {

my $NUMBER = int(rand(7));

return ( "$PULL[$NUMBER] " . &set_reps ($PULL[$NUMBER]) );

}

sub Medium_Exercise_1 {

my $NUMBER = int(rand(6));

my $CLEAN = "$MEDIUM1[$NUMBER] " . &set_reps ($MEDIUM1[$NUMBER]) ;

clean_name ( $CLEAN );
}

sub Medium_Exercise_2 {

my $NUMBER = int(rand(4));

my $CLEAN = "$MEDIUM2[$NUMBER] " . &set_reps ($MEDIUM1[$NUMBER]) ;

clean_name ( $CLEAN );
}

sub Medium_Exercise_3 {

my $NUMBER = int(rand(6));

my $CLEAN = "$MEDIUM3[$NUMBER] " . &set_reps ($MEDIUM3[$NUMBER]) ;

clean_name ( $CLEAN );
}

sub Light_Exercise_1 {

my $NUMBER = int(rand(6));

my $CLEAN = "$LIGHT1[$NUMBER] " . &set_reps ($LIGHT1[$NUMBER]) ;

clean_name ( $CLEAN );
}

sub Light_Exercise_2 {

my $NUMBER = int(rand(4));

my $CLEAN = "$LIGHT2[$NUMBER] " . &set_reps ($LIGHT1[$NUMBER]) ;

clean_name ( $CLEAN );
}

sub Light_Exercise_3 {

my $NUMBER = int(rand(6));

my $CLEAN = "$LIGHT3[$NUMBER] " . &set_reps ($LIGHT3[$NUMBER]) ;

clean_name ( $CLEAN );
}

#FORMAT subs

sub main_full_2_weeks{    

      my @arr_1 = (['Sunday'	  ,'Monday' 	     ,'Tuesday'       ,'Wednesday'       , 'Thurday'      , 'Friday'  ]
				,[&full_body  	  ,&Light_Exercise_1 ,&full_body 	  ,&Light_Exercise_1 ,&full_body	  ,&Light_Exercise_1 ]
                ,[&Squat     	  ,&Light_Exercise_2 ,&heavy_pull     ,&Light_Exercise_2 ,&Squat     	  ,&Light_Exercise_2 ]
                ,[&Push_exercise  ,&Light_Exercise_3 ,&Push_exercise  ,&Light_Exercise_3 ,&Push_exercise  ,&Light_Exercise_3 ]
                );
				
	  my @arr_2 = (['Sunday'	  ,'Monday' 	     ,'Tuesday'       ,'Wednesday'       , 'Thurday'      , 'Friday'  ]
				,[&full_body  	  ,&Light_Exercise_1 ,&full_body 	  ,&Light_Exercise_1 ,&full_body	  ,&Light_Exercise_1 ]
                ,[&heavy_pull  	  ,&Light_Exercise_2 ,&Squat          ,&Light_Exercise_2 ,&heavy_pull     ,&Light_Exercise_2 ]
                ,[&Push_exercise  ,&Light_Exercise_3 ,&Push_exercise  ,&Light_Exercise_3 ,&Push_exercise  ,&Light_Exercise_3 ]
                );

      for my $row (@arr_1,@arr_2) {
         format FULL =
@<<<<<<<<<<<<<<<<<<<<<<<<<  @<<<<<<<<<<<<<<<<<<<<<<<<<  @<<<<<<<<<<<<<<<<<<<<<<<<<  @<<<<<<<<<<<<<<<<<<<<<<<<<  @<<<<<<<<<<<<<<<<<<<<<<<<<  @<<<<<<<<<<<<<<<<<<<<<<<<<    
         @$row
.
		format_name STDOUT "FULL";
         write STDOUT ;
      }
print "\n" ;
   }   

sub short_3_workout{
   
	
      my @arr_1 = (['Heavy Squat'	,'Light Workout'  	,'Heavy Pull'    ,'Olympic Workout' ,'Ab Workout'	,'Medium Wokout']
				,[&full_body  	  	,&Light_Exercise_1 	, &full_body 	 ,&snatch 			,&ab_linear 	,&Medium_Exercise_1]
                ,[&Squat     	  	,&Light_Exercise_2 	,&heavy_pull     ,&cleanjerk 		,&ab_lateral 	,&Medium_Exercise_2]
                ,[&Push_exercise  	,&Light_Exercise_3 	,&Push_exercise  ,&Squat 			,&ab_dynamic 	,&Medium_Exercise_3]
                );

      for my $row (@arr_1) {
         format SHORT =
@<<<<<<<<<<<<<<<<<<<<<<<<<  @<<<<<<<<<<<<<<<<<<<<<<<<<  @<<<<<<<<<<<<<<<<<<<<<<<<<  @<<<<<<<<<<<<<<<<<<<<<<<<<  @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  @<<<<<<<<<<<<<<<<<<<<<<<<<  
         @$row
.
		format_name STDOUT "SHORT";
         write STDOUT ;
      }
print "\n" ;
   }    

sub short_1_workout{

my $HEADER = shift ;
my $EXERCISE1 = shift ;  
my $EXERCISE2 = shift ;
my $EXERCISE3 = shift ;
	
      my @arr_1 = ([$HEADER	]
				,[$EXERCISE1 ]
                ,[$EXERCISE2 ]
                ,[$EXERCISE3 ]
                );

      for my $row (@arr_1) {
         format SHORTY =
@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
         @$row
.
		format_name STDOUT "SHORTY";
         write STDOUT ;
      }
print "\n" ;
   }      
 


	
	
#print "argv\$\# at the middle $#ARGV \n";
#print "argv@ at the middle @ARGV \n";
#print "argv% at the middle %ARGV \n";
#print "$abs \n"; 
#print "$light \n";  
#print "$pull \n";  
#print "$squat \n";  
#print "$olympic \n";  
#print "$fourworkouts \n"; 
#print "$twoweeks \n"; 
#print "$help \n"; 
#print "$chaos \n";
#print "$#ARGV \n";
	
# release the subs !!!

#if ( $#ARGV < '0' ) {


if ( $abs == 1 ) {

short_1_workout( 'Ab Workout' ,&ab_linear, &ab_lateral , &ab_dynamic ) ;

}
if ( $medium == 1 ) {

short_1_workout( 'Medium Workout' ,&Medium_Exercise_1 ,&Medium_Exercise_2 ,&Medium_Exercise_3 ) ;

}
if ( $light == 1 ) {

short_1_workout( 'Light Workout' ,&Light_Exercise_1 ,&Light_Exercise_2 ,&Light_Exercise_3 ) ;

}
if ( $pull == 1 ) {

short_1_workout( 'Heavy Pull Workout' ,&full_body ,&heavy_pull ,&Push_exercise ) ;

}
if ( $squat == 1 ) {

short_1_workout( 'Heavy Squat Workout' ,&full_body ,&Squat ,&Push_exercise ) ;

}
if ( $olympic == 1 ) {

short_1_workout( 'Olympic Workout' ,&snatch ,&cleanjerk ,&Squat ) ;

}
if ( $twoweeks == 1 ) {
&main_full_2_weeks;
}
if ( $fourworkouts == 1 ) {
&short_3_workout; 
}
if ( $help == 1 ) {
&usage; 
}
if ( $chaos == 1 ) {
&chaos_article; 
}
if ( $stomack == 1 ) {
&ab_article; 
}

#short_3_workout() if !$ARGV[0]; 

#if defined $result ? $ARGV[0] : short_3_workout() ;

#if ( length( @ARGV ) < '1' ) {
if ( $commandline eq -1 ) {
print " Printing 4 random workout types the same as -f option \n If you want usage use the -h option \n\n" ; 
&short_3_workout;
}


#=pod
sub chaos_article { print
"
On Chaos and Pain, you\'re going to train a MINIMUM of 5 days a week, if you\'re going balls

out. I\'ve never tried to pack the volume of work I do into less, really. I\'ve had backoff weeks

because my legs were cramping like crazy, which reduced my training load for a week, but

this program is all about constantly busting your ass. It works for the Bulgarians and the

Russians, and since they\'ve dominated the strength world for the better part of a half

century, it seems as though it might be time for the rest of the world to get clued into the

fact that it\'s better to distribute your training volume over many sessions than to try to stuff

it all into a couple like a housewife trying to wedge her every world possession into her

carry-on to avoid the $15 bag fee. Just as that filtch folds over backwards trying to hoist

that bursting-at-the-seams bag into the overhead, you too will fail if you try to wedge too

much into a training session. Thus, heavy-as-bugh 30-60 minutes sessions shall be the rule,

not the exception, and will be performed between 5 and 7 days a week.(Costa 22, Science

and Practice 4) There are no off weeks, as \"elite athletes cannot afford complete passive

rest for more than three days in a row\", and most Eastern European coaches limit

consecutive rest days to two.(Science and Practice 4)


The Engines of Weakness\'s Destruction

      Squat

      Front Squat

      Clean and Press (and all of its variations... power cleans, push press, fat bar

      clean and press, log clean and press, dumbbell clean and press, reverse

      grip/fast curl and press, unilateral)

      Snatches (one and two arm)

      Push Presses

      Behind the Neck Push Press and Push Jerk

      Military presses (one and two arm)
	  
	  Deadlifts (one arm, two arm, trap bar, etc)
	  
	        Bench press (close grip, reverse grip, incline reverse grip, and regular flat

      bench)

      Pullups (weighted and unweighted)

      Dips (weighted and unweighted)

      Shrugs (HEAVY HEAVY HEAVY)

      High Pulls

      Ultra heavy partial reps of any of the above exercises done from a variety of

      heights and angles. Variety is the spicy of life, and you want your life to be

      spicier than a vat of habanero sauce filled with Ghost Chilis.

      Any other heavy ass exercise you want. Stones, steel suitcases, farmers walks,

      throwing weights for height or distance, etc. The key is that they\'re heavy, not

      conducted on a padded seat or bench (with the exception of bench press), and

      require you to be a bughing man while doing it. Ladies, time for you to grow a

      pair and ditch the neoprene-padded dumbbells.




The basics: I typically combine one push with one pull and one squat three to five days per

week, and often train more than once a day. Thus, I\'m utilizing a program of anywhere

between five and 13 sessions a week. The exercises are basically a grab bag, from which

you can grab any of the above. On those three days, a good general rule per exercise is to

shoot for 15-30 total reps, depending on your rep scheme. Doing triples? Go with 10x3.

Doubles? Shoot for 10-15 sets. Singles? They\'re my bread and butter, and I\'ll do anywhere

from 15 to 30 of them, depending on the workout. I love them.

The key to getting ripped and strong on this program is to use AT LEAST 85% of your 1 rep

max (1RM) on everything, and I like to stay in the 87.5%-100% range. That means HEAVY.

Always. Well, almost always. If you\'re going to squat 3 times a week, you can make the

midweek squat workout a light one if you don\'t feel like going heavy. I like to load 135 or

225 on the bar and squat for time for a couple of sets. I just put a song on my mp3 player

that\'s 2:30 or 3:00 for 135, or 1:30-2:00 for 225 and squat pretty much nonstop. If you

start dying, just stand there under the weight.


Thus, one of the heavy workouts might look like this:


Back Squat 10x3

Behind the Neck Push Press 15x1

Weighted Pullups 5x4 ( I often end up doing slightly higher reps on pullups, since it\'s a pain

to load the belt with small plates once you\'ve got a couple of 45s on there.

If you choose to do clean and press, that counts as both a pull and a press. Thus, you can

just kill yourself at that exercise, or you can do that and another exercise if you want.


So, what to do on the off days? I like busting out the ab wheel and one of the straps people

use for hanging leg raises to work neck off a high cable, and doing high rep arms with a fat

bar, and calves. I also quite enjoy doing the Bear, the Super Bear, or playing uncle by

myself, or with a lifting partner. I\'ll also do 30-45 minute sessions of one arm deadlifts for 3-

5 without straps to work grip and get in some general physical preparation (GPP), do high

rep tri-sets of arms and shoulders with a preloaded barbell, or simply run around the gym

repping out with whatever weights people have left on machines.             The key for these

workouts is for them to be brief and intense, but without loading your spine.


That sugah explained:


The Bear- it\'s a clean and press complex. I\'d start with 95lbs and work my way up, were I

you guys. It\'s a clean from the floor into a front squat, to an overhead press, to a back

squat, to another overhead press, to a front squat, and then cleaning the bar back down to

the floor. That\'s one rep. I like doing those for 5x5, or in an uncle format, which I\'ll address

in a second.

The Super Bear- A buddy of mine and I decided that the Bear didn\'t suck enough, so we

added two more squats- overhead squats, at the top of both overhead presses. Thus, it\'s

clean to front squat, overhead press to overhead squat, then drop the bar on your back and

back squat it, overhead press to overhead squat, then drop the bar on your collarbones and

front squat, then back to the floor. Fun, right? I think we might have had a best of 5x5 with

that using 115, and I was sore for a week.


Uncle- I\'ve This is explained in a subsequent blog. Check the Table of Contents for the page.


Want a weekly program? Well, that would defy the very definition of the name of my

methodology. It\'s supposed to be chaotic. There\'s no need for periodization in my routine,

since it\'s a constant adaptation phase. If you want an example of what a week might look

like, here you go. Just don\'t do this every week.


Monday:

Front Squat

Shrugs 12x2

Close grip BP 10x3

Note: I don\'t recommend shrugging and doing behind the neck push pressing on the same

day until your traps are conditioned well beyond their current state. You will suffer mightily

for violating this rule- you will cramp like you\'ve never cramped before. Additionally, do not

Zercher squat the day after a shrug workout for the same reason.

Tuesday:

Jump Squat 5x3

Behind the Neck Push Press 10x2

Pendlay Row 10x3
                                                                                                 14
Wednesday:

Donkey Calf Raise 10x10xthe stack

Ab Wheel 3x5 standing

Unweighted pullups 100 reps

Arm medley

Thursday:

Bottom position back squat 10x1

Push Press 12x2

Zercher Squat 6x4

Friday:

One Arm Deadlift 10x5

Arm medley

Calves

Saturday:

Squat Lockouts 15x1

Lowest Box Squat 3x3

Reverse Grip Incline Bench Press 6x3

Power Clean 10x1

Sunday:

Rest




The program does have a basis in Waterbury, in addition to the Bulgarian training regime,

Arnold\'s high volume stuff, and an abject hatred of Mike Mentzer thrown in for good

measure.




A word on rest periods- rest as little as possible. I typically rest about 45 seconds to one

minute in between sets, singles included. That keeps the heart rate up, burns more calories,

and improves your muscular endurance while building strength.




Occasionally, I do jump sets, Waterbury style. I\'ll typically do them on my push-pull

exercises, doing something along the lines of close grips jump-setted with bent rows. I keep

my rests super low, so it\'s almost a superset, but if you\'re working opposing muscle groups,

the antagonist of the muscle you\'re working relaxes completely, so you should be pretty

fresh, albeit winded.




On your off days, feel free to work your weak points if they\'re not too fatigued. There are

weeks that I\'ll train shoulders 5x, but never do the same thing two days in a row. I always

change the sets and reps, at least, and typically change the exercises as well. Thus,

whatever bodypart you want to bring up, try training it 5 or 6 times a week, but alternate

heave and light days, and cycle exercises.



                                                                                               16
An example:


Monday- Push Jerks 15x1

Tuesday- unloaded fat bar behind the neck press as part of a tri-set

Wednesday- Strict Military press (standing, feet together, no leg drive) 5x6

Thursday- Bodyweight dips (hits the front delts a bit)

Friday- Clean and Press 10x3

Saturday- Axe Hold with dumbbells for time




That\'s Chaos and Painin a nutshell. A bloody great big nutshell. You love it. Now go lift

something heavy until your bughing eyes bleed.

" ;

}

sub ab_article {
print
"
http://www.tmuscle.com/free_online_article_issue/issue_631#unconventional-workout-abs

Unconventional Workout - Abs
by Nick Tumminello


I\'m frequently asked why I\'m constantly developing new exercise techniques and don\'t just stick to the basics. Often, I answer by repeating this classic quote from my good friend and fellow strength coach Martin Rooney. \"If you want what other people don\'t have, you have to do what other people don\'t do.\"

Insightful SOB, isn\'t he?

The basics are great and should always be the foundation of your program, but there\'s no reason you can\'t combine the old with the new. My athletes always seem to get better results than what can normally be achieved with traditional methods, simply because I make a point of using some nontraditional training methods along with the basics.

In this installment of the Unconventional Workout series, I\'m going to provide you with a step-by-step instruction guide to the latest and greatest abdominal training protocols that I use with my athletes at Performance U in Baltimore, MD.

Each of the exercises and training ideas featured in this article may be new to you, but they are part of my everyday training arsenal and have been battle-tested effective at keeping my athletes strong, stable, and free from back pain. Use them and I\'m sure these techniques will do the same for you.

Regardless of whether you\'re a bodybuilder trying to achieve an impressive six pack, an athlete looking to outperform the competition, or an exercise enthusiasts looking for some new ways to spice up your training and stay back injury free, these abdominal workouts will be just what the doctor ordered to get you the results you\'re after!


Good Abs vs. Good Looking Abs

Just because you have good looking abs doesn\'t mean you have good functioning abs, and accordingly, just because you don\'t have good-looking abs, doesn\'t mean that you don\'t have good functioning abs. All the exercises featured here will help you build a stronger, better functioning set of abs.

As for showing off that six-pack? I\'m sure you know by now that lean, ripped abs are built in the kitchen, not the weight room. Step away from your secret junk-food cupboard if you want a midsection that gets noticed.


To Train Abs or Not to Train Abs?

I\'ve heard many coaches and weight lifting enthusiasts say, \"Just do the big lifts (squat, deadlifts, etc.) and you don\'t need to do any specific abdominal work.\" Although I agree that there\'s a tremendous amount of abdominal activity when performing these lifts, I disagree that\'s all you need to do to maximize your abdominal performance or functional ability.

Put simply, the big lifts like squats and deadlifts are single-dimensional, sagital plane-dominant exercises. Your abdominals, like every other muscle in the body, function in all three planes of motion: sagital (linear), frontal (lateral), and transverse (rotary). Just doing the big lifts completely neglects strengthening the other two critical planes of motion. 

To effectively strengthen the abdominals in all three planes of motion, some direct strengthening exercises performed at various angles such as the ones displayed in this article are required.


To Flex or Not to Flex the Spine?

Whether or not to use spinal flexion exercises is a common argument these days and one that I\'ve been right in the center of. In truth, I've never used crunches or traditional sit-ups in any of my programs; I've always believed that a good training program uses exercises that reverse the sitting/slouching position. Exercise like crunches and sit-ups encourage it, which is why I don't use them.

That said, the real issue is not with spinal flexion; it's with high repetition spinal flexion or prolonged spinal flexion. Respected lower back guru Dr. Stuart McGill and many others have shown that spinal flexion and prolonged flexion to be common causes of disc-related injury.

If you have a healthy back and are under 40 years of age, then lower rep spinal flexion exercises can be performed safely and effectively. That said, after reading some of the new research like this study published in a recent Medicine & Science in Sports & Exercise, I've found myself using less flexion-based exercises, regardless of the age of the athlete or the rep range used.

This particular study used 1467 subjects to evaluate the effect that core stabilization training would have on the traditional sit-up test used by the Armed Forces. Of the 1476-subjects, 761 were placed into a core stabilization program, and 706 were placed into a sit-up program traditionally used to prepare soldiers for their physical fitness test.

The traditional exercise program group performed sit-ups, sit-ups with trunk rotations, and abdominal crunches. Those in the core stabilization exercise program performed a variety of stabilization exercises such as side-bridges, glute bridges, bird-dogs, woodchoppers, and abdominal crunch draw-ins.


Results, Please...

In the end, both groups significantly improved their sit-up performance after 12-weeks, yet the sit up performance was not significantly different between the two groups; even though the core stabilization group never performed sit-ups in their training program! Of notable interest is that the core stabilization group demonstrated significant improvements in sit-up pass rate (5.6%) compared to the traditional sit-up training group's 3.9%. The researchers concluded:

\"Incorporating a core stabilization exercise program into Army physical training does not increase the risk of suboptimal performance on the Army's fitness test and may offer a small benefit for improving sit up performance.\"

(Effects of Sit-up Training versus Core Stabilization Exercises on Sit-up Performance by JD CHILDS, et al. - 2009, Medicine & Science in Sports & Exercise:

November 2009 - Volume 41 - Issue 11 - pp 2072-2083.)

Considering the results of this study, along with my training philosophy of reversing the sitting position/slouchy posture, I've focused my abdominal training programs on mostly spinal stabilization movements and use almost zero spinal flexion exercises. I do, however, make an exception for my bodybuilder clients that I'll cover later in this article.


Unconventional Abdominal Workouts

Now that you have an understanding of my abdominal training philosophy, here's a list of unconventional abdominal training exercises, Performance U style!

The exercises are divided into three sections: linear exercises, lateral/rotary stability exercises, and dynamic rotary exercises. In the program design portion of this article, I'll discuss how to use all three types of abdominal exercises to ensure each abdominal workout is fully comprehensive.

Keep in mind this article is intended to provide you with new, unconventional exercises you've probably not yet seen before, so don't complain when you don't see your favorite high school gym class exercise included in the mix.


Linear Abdominal Exercises

Medicine Ball Rollout – I first displayed this exercise in my Big Lats article. Put simply, it's the hardest abdominal rollout exercise variation I know of!

Linear (vertical) Pallof Press – This is inspired by the original Pallof Press exercise developed by John Pallof. I love the idea of the Pallof Press and don't think it should be limited to just one plane of action, so I developed the Linear Pallof press. Think of this exercise as a kind of \"standing ab rollout.\"

Swiss Ball Pike – The non-stability ball haters may already be familiar with this exercise. If you're not currently using this exercise, you should be, because it's a great one.

When performing the Swiss Ball Pike: Initiate the movement from your abs. Keep you back straight, legs straight, and drive your hips to directly above your shoulders.

By the way, I'm sick of folks talking trash about the Swiss ball. It\'s not the damn ball\'s fault that there are folks out there who don\'t know how to choose their exercises wisely. The Swiss ball is just a tool-so stop blaming the tool and start blaming the bigger tools who are using them inappropriately!

The Body Saw – This is one of my favorite abdominal plank progressions. I first learned the Body Saw exercise form the folks with TRX Suspension Training. Although I love using the TRX, I\'ve developed my own version of the Body Saw exercise that doesn\'t involve using the TRX because not everybody has access to one.


Lateral/ Rotary Stability Abdominal Exercises

The following are stability-oriented exercises, which involve controlling unwanted rotational and/or lateral motion, followed by dynamic rotary exercises.

Side Plank on Medicine Ball – this exercise is just a much tougher progression to the traditional elbow side plank. The added instability of the ball causes the muscles of your shoulder and abdominals to work harder to keep you in position. Be sure to keep your spine straight and your wrist directly underneath your shoulder.

Single-Arm Front Plank on Swiss Ball – This exercise is one of the toughest and most effective \"core\" exercises you\'ll ever try! It\'s a favorite among my combat athletes.

Turkish Get-Ups – Okay, most of you likely know that this isn\'t what women in Istanbul wear for a night on the town. Regardless, I still don\'t see this fantastic exercise used as often as I think it should be.

I\'m sorry if I offend any members of the Kettlebell cult when I say you don't need to be holding a Kettlebell to do Turkish get-ups. Holding a dumbbell is more comfortable and just as effective.

Angled Barbell Rainbows – Many lifters are familiar with the dynamic version of this exercise, but not as familiar with the static version. The static version is what I use most often because it builds the body awareness needed to control the spine when standing. To perform this exercise, you can use the Sorinex Land mine or place a barbell in the corner.

Lateral Pallof Press – Here\'s another one of my tweaks of the Pallof Press concept. This one can be performed in a half-kneeling or standing position.


Dynamic Rotary Abdominal Exercises

Rotational exercises are crucial to sports performance because they develop and refine your ability to transfer and express force from one side of your body to the other. These movements are at the heart of true intelligent functional training.

Tight Rotations – the tight rotation exercise is my favorite rotary training movement because it closely mimics the actions of the abdominals when sprinting, punching, throwing, or changing directions at high speed. Your abs have to control the constant torque happening between your shoulders and hips moving in opposite directions while you move.

The tight rotation series enhances your ability to produce, reduce, and control rotary (torque) forces.

I use a three level progression for the tight rotation series. I spend about 2-4 weeks on each level before progressing to the next.

Each of the Rotations has an accompanying video on the right, so I\'ll spare you a long, boring written description.

The Gladiator Twist – This is another one of those exercises that\'s both fun and effective. The Gladiator Twist is based on the same principles as the Tight Rotation series. If this exercise doesn't light up your abs, nothing will!

Medicine Ball Rotary Tosses – This is one of the best methods to train rotation apart from hitting and kicking a punching bag. If you have access to a med ball and a wall – along with the necessary space and understanding gym staff - give these three medicine ball rotary toss variations a shot. They'll most certainly make you a rotary power beast!


Using these Ab Workouts in Your Program

Regardless of the training goal, I try to perform at least one of each of the three types of abdominal training exercises described above in each workout. That means performing at least one linear exercise, one lateral/rotary stability exercise, and one dynamic rotary exercise.

With that in mind, there are generally two ways in which I use these abdominal training methods with my clients, depending on whether the specific training goal is health and/or sports performance related, or more bodybuilding centered.

For General Health and Sports Performance – I find it best to follow Dr. Stuart McGill's recommendations to train the abdominals more often while using lower loads for longer periods of time to increase muscular endurance of the abdominals.

Dr. McGill\'s research has shown this method to be highly beneficial at enhancing sports performance and developing the stability needed to resist back injury and postural change.

When putting this strategy into practice with my athletes and exercise enthusiasts, I have them perform abdominal/core training exercises in-between sets of upper-body or lower-body exercises.  This way, you make your workouts more productive by increasing the density. Here's an example:

Day A – Upper-Body Push/Pull

1A) Horizontal Push

1B) Horizontal Pull

1C) Linear abs

2A) Vertical Push

2B) Vertical Pull

2C) Lateral/Rotary Stability

3A) Biceps

3B) Triceps

3C) Dynamic Rotary

Day B – Lower-Body Legs/Hips

1A) 2 Leg Hip Dominant

1B)  Linear abs

2A) 1-Leg Knee Dominant

2B) Lateral/Rotary Stability

3A) Calves

3B) Dynamic Rotary

For bodybuilding/physique enhancement goals – When it comes to ab training for my pro and amateur bodybuilders and figure competitors, I take a much different approach than I do with fitness/sports performance clients.

When training physique competitors, I recommend training the abdominals less often using heavier loads for short periods of time. I usually have my bodybuilders perform multiple abdominal exercises at the end of certain workouts or as a stand-alone \"abs day\" workout, depending on the person\'s training split and personal preference.

I also admit that I go against my \"no flexion\" policy when working with physique athletes. Bodybuilders in particular need a significant amount of abdominal hypertrophy to look impressive on stage. I find using some trunk flexion exercises are needed to achieve this look, and therefore the risks of performing flexion exercises don\'t outweigh the benefits to the bodybuilder.

Along with the exercises already described in this article, with bodybuilders I use a number of exercises using the Swiss Ball and (gasp!) the Bosu Ball.

Before you label me as a soy-chai-latte-sipping granola-head, keep in mind that the Bosu Ball, like the Swiss Ball, is just another tool in my toolbox. I have no special affinity for these implements; it\'s simply a matter of selecting the right tool for the job. For these abdominal exercises, I find using the Swiss ball and Bosu creates a better, more effective workout due to the increased trunk range of motion.

These are all quite self-explanatory, so I\'ll skip the drawn-out descriptions and just ask that you check out the photos on the right.

I also use straight leg sit-ups and reverse crunches as described in my How Strong Are Your Abs Really? article.

A typical abdominal workout for a bodybuilder would look like this:

Swiss Ball Crunch 2-3 x 8-12

Medicine Ball Abs Roll Out 2-3 x 45-60 seconds

Swiss Ball Side Crunch 2-3 x 8-12

Angled Barbell Rainbow 2-3 x 45-60 seconds


Conclusion

The folks at TMUSCLE had asked me to give you one unconventional abs workout and instead I hit you with a monster list of exercises and user-friendly programs that anyone can immediately apply. Delivering the latest and greatest training concepts is my business and business is good!

This article was not just meant to show you new exercises; it was also meant to inspire you to get creative, so don\'t be afraid to modify an exercise to fit your needs and/or sporting demands. Remember, \"If you want what others don\'t have, you must do what others don\'t do!\"

Put these exercises into practice within your training sessions and tell us about your experience using them on the forum. Also, if you have any other unconventional abs exercise and workouts, share them with us on the comment forum.

Coach Nick Tumminello is a Baltimore Personal Trainer who trains a select group of athletes, bodybuilders, and exercise enthusiasts. Nick is also the Strength & Conditioning Coach for team Ground Control MMA. You can purchase Nick\'s Strength Training for Fat Loss & Conditioning DVD through his Blog website.

© 1998 — 2010 Testosterone, LLC. All Rights Reserved.
PUBLISHED 06-14-10 08:00
Discuss | Rate | Print Version

" ;

}

