#!/usr/bin/perl -Tw
#------------------------------------------------------
# Script Name: abworkout.pl.pl
# Script Version: 1.0
# Date: Mon Jul 19 15:28:56 EDT 2010
# Author: sys2x5
# Description: abworkout randomizer taken from http://www.tmuscle.com/free_online_article_issue/issue_631#unconventional-workout-abs
# Revision history:
#       1.0/Mon Jul 19 15:28:56 EDT 2010 : original version
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
 
 
my @LINEAR = ("Medicine Ball Rollout" , "Linear vertical Pallof Press" , "Swiss Ball Pike" , "The Body Saw");
 
my @LATERAL = ("Side Plank on Medicine Ball time" , "Single-Arm Front Plank on Swiss Ball time" , "Turkish Get-Ups" , "Angled Barbell Rainbows" , "Lateral Pallof Press" , "Side Plank on Medicine Ball time" );
 
my @DYNAMIC = ("Tight Rotations time" , "The Gladiator Twist time" , "Heavy Bag Rotary Strikes time");
 
 
sub choice {
 
my $range = $_[0] ;
 
my $RANDOM = int(rand($range));
 
print $RANDOM ;
 
}
 
sub set_reps {
 
my $EXERCISE = "$_[0]" ;
 
#print "$EXERCISE \n" ;
 
if ($EXERCISE =~ m/time/ ) 
{
print "you will use " ; &set_decision ; print " sets of " ; &time_decision ; print " seconds \n" ;
}
else
{
#print "you will use &set_decision sets of &rep_decision reps \n" ;
print "you will use " ; &set_decision ; print " sets of " ; &rep_decision ; print " reps \n" ;
}
 
}
 
sub set_decision {
 
#my $NUM=&choice(3) ;
my $NUM = int(rand(3));
 
my @SET_NUMBER = (1 , 2 , 3) ;
 
print $SET_NUMBER[$NUM]
 
}
sub rep_decision {
 
my $range = 15;
my $minimum = 10;
 
print int(rand($range)) + $minimum;
 
}
 
 
sub time_decision {
 
my $range = 40;
my $minimum = 20;
 
print int(rand($range)) + $minimum;
 
}
 
 
#Print exercises
print "\n" ;
print "Linear Abdominal Exercises \n" ;
 
#my $NUMBER1 = &choice(3) ;
my $NUMBER1 = int(rand(4));
 
print "$LINEAR[$NUMBER1] \n" ;
 
&set_reps ($LINEAR[$NUMBER1]) ;
print "\n" ;
 
print "Lateral/ Rotary Stability Abdominal Exercises \n" ;
 
#my $NUMBER2 = &choice(6);
my $NUMBER2 = int(rand(6));
 
my $LATERAL1 = $LATERAL[$NUMBER2] ;
 
$LATERAL1 =~ s/time// ;
 
print "$LATERAL1 \n" ;
 
&set_reps ($LATERAL[$NUMBER2])  ;
print "\n" ;
 
print "Dynamic Rotary Abdominal Exercises \n" ;
 
#my $NUMBER3 = &choice(3);
my $NUMBER3 = int(rand(3));
 
my $DYNAMIC1 = $DYNAMIC[$NUMBER3] ;
 
$DYNAMIC1 =~ s/time// ;
 
print "$DYNAMIC1 \n" ;
 
&set_reps ($DYNAMIC[$NUMBER3]) ;
print "\n" ;
 
 
=pod
sub article {
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
 
Linear (vertical) Pallof Press – This is inspired by the original Pallof Press exercise developed by John Pallof. I love the idea of the Pallof Press and don't think it should be limited to just one plane of action, so I developed the Linear Pallof press. Think of this exercise as a kind of "standing ab rollout."
 
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
 
When training physique competitors, I recommend training the abdominals less often using heavier loads for short periods of time. I usually have my bodybuilders perform multiple abdominal exercises at the end of certain workouts or as a stand-alone "abs day" workout, depending on the person\'s training split and personal preference.
 
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
 
This article was not just meant to show you new exercises; it was also meant to inspire you to get creative, so don\'t be afraid to modify an exercise to fit your needs and/or sporting demands. Remember, "If you want what others don\'t have, you must do what others don\'t do!"
 
Put these exercises into practice within your training sessions and tell us about your experience using them on the forum. Also, if you have any other unconventional abs exercise and workouts, share them with us on the comment forum.
 
Coach Nick Tumminello is a Baltimore Personal Trainer who trains a select group of athletes, bodybuilders, and exercise enthusiasts. Nick is also the Strength & Conditioning Coach for team Ground Control MMA. You can purchase Nick\'s Strength Training for Fat Loss & Conditioning DVD through his Blog website.
 
© 1998 — 2010 Testosterone, LLC. All Rights Reserved.
PUBLISHED 06-14-10 08:00
Discuss | Rate | Print Version
 
"
 
}
=cut
