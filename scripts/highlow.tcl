##################################################################################################
##                                                                                              ##
##  Author: Justdabomb2                         <email: edngravy@sbcglobal.net>                 ##
##  Script: High Low                                                                            ##
##  Version: v2.0                                                                               ##
##  Date: 10/25/2006                                                                            ##
##  Tested with: Eggdrop v1.6.18                                                                ##
##                                                                                              ##
##                                                                                              ##
##  Commands:     !hl on <number> - Turns the game on and tells the bot to pick a number        ##
##                                  between 0 and <number>.                                     ##
##                !hl off         - Turns the game off.                                         ##
##                !hl help        - Shows the commands.                                         ##
##                !hl activate    - Activates the game so others can play.                      ##
##                !hl deactivate  - Deactivates the game so others can't play.                  ##
##                !guess <number> - Guesses <number> and tells you if your guess was correct,   ##
##                                  too high, or too low.                                       ##
##                                                                                              ##
##                                                                                              ##
##  Installation:                                                                               ##
##                1. Save in your scripts directory as "highlow.tcl".                           ##
##                2. add line "source scripts/highlow.tcl to the bottom of your eggdrop         ##
##                   configuration file.                                                        ##
##                3. CTRL+F search for 'set hlchan ' and change "#channel" to the name of       ##
##                   the channel you want the game to be played on.                             ##
##                4. CTRL+F search for 'set hlownerofbot ' and change "YourNick" to your nick.  ##
##   (optional) - 5. CTRL+F search for 'set correctmsgs' and change the messages below to what  ##
##                   you want them to say when a person guesses correst.                        ##
##   (optional) - 6. CTRL+F search for 'set incorrectsgs' and change the messages below to what ##
##                   you want it to say when a person guess too high, or too low.               ##
##                7. Rehash or restart your bot, and type "!hl help" in the channel.            ##
##                                                                                              ##
##                                                                                              ##
##  Bugs:         - None known yet, E-mail me if you find any.                                  ##
##                                                                                              ##
##                                                                                              ##
##  Features:     - You can choose the highest number you want the bot to be able to choose     ##
##                  from (global variable) and the seperate number to use for a specific        ##
##                  round (public command).                                                     ##
##                - You can activate and deactivate the game if you do not want others to play  ##
##                  it at the moment.                                                           ##
##                  - Only the bot owner that you set in the global variable can use these      ##
##                    commands.                                                                 ##
##                - It is only played on the channel you set in the global varibale.            ##
##                  - E-mail me if you would like this feature taken out if you don't know how  ##
##                    to do it yourself.                                                        ##
##                - You can veiw all the commands for the through a public command.             ##
##                                                                                              ##
##                                                                                              ##
##  You do NOT need to change anything in this script (besides what it tells you to change in   ##
##              the installation), it should work fine the way it is right now.                 ##
##                                                                                              ##
##   Newer versions on this script will be out if I decide something should be added or a bug   ##
##                                     needs to be fixed.                                       ##
##                                                                                              ##
##           If you notice any problems with the script, please e-mail them to me at            ##
##                                   edngravy@sbcglobal.net                                     ##
##                                                                                              ##
##                 *Thanks for the great suggestions for this script Rolcol!*                   ##
##                                                                                              ##
##    Please do not re-distribute a modified version of this script. If you do re-distribute    ##
##     it in it's original form, please give credit to me, and do not claim it as your own.     ##
##                                                                                              ##
##                                                                   ~Thank you!                ##
##                                                                                              ##
##################################################################################################

############################
## Set this to your nick. ##
############################

set hlownerofbot "SS_Patrick"

############################################################
## Do NOT forget to set this to the name of your channel. ##
############################################################

set hlchan "#No!"

################################################################################################
## You can set this to the highest number you want to be able to guess from (default 100000). ##
################################################################################################

set highestnumber "100000"

########################################################################################
## You can set this to the lowest number you want to be able guess from (default 10). ##
########################################################################################

set lowestnumber "10"

######################################################################
## Random messages the bot will use when you get the correct guess. ##
######################################################################

set correctmsgs {
  "Good job!"
  "Congratulations!"
  "Wowzers!"
  "Great Guess!"
  "Good work!"
  "Outstanding!"
  "Now win again!"
}

#########################################################################
## Random messages your bot will use when you make an incorrect guess. ##
#########################################################################

set incorrectmsgs {
  "Sorry"
  "Too bad,"
  "Try again,"
  "Incorrect guess,"
  "Keep trying"
}

######################################################
## You don't need to edit anything below this line. ##
######################################################

####################################
## Do NOT change these variables! ##
####################################

set hlonoroff 1
set hldeact 0
set hlinuse 0
set numbertouse ""
set correctnumber ""
set hlcreator "Justdabomb2"
set hlturnedoff "High Low has been turned off by"
set hlnoton "\0039High Low\0031 is not currently on."
set hlalreadyoff "\0039High Low\0031 is already off."
set hlinvalidguess "Your guesses must be bewteen"
set hlinvalidnumber "Please use a number between"
set hlalreadyon "\0039High Low\0031 is already on."
set hlnumberstoguess "\0031The numbers vary from\0033\002 0\002 \0031to\0037"
set hlturnedon "\0039High Low\00314 has been turned on by"
set hlnumbertoolow "won't use that number, it is too low."
set hltryhigher "Try a higher number."
set hlnumbertoohigh "won't use that number, it is too high."
set hltrylower "Try a lower number."
set hlguesscmd "Type \002!guess <number>\002"
set hlcmd "Type \002!hl on <number>.\002"
set hlhelpon "Turns the game on and tells the bot to pick a number between 0 and <number>."
set hlhelpoff "Turns the game off."
set hlhelpguess "Guesses <number> and tells you if your guess what too high or too low."
set hlhelpactivate "Activates the script so others can use it."
set hlhelpdeactivate "Deactivates the script so others can not use it."
set hldeactivated "\0039High Low\0031 has been deactivated. Ask $hlownerofbot to activate it."
set hlbeenactivated "\0039High Low\0031 has been activated."
set hlalreadyactivated "\0039High Low\0031 has already been activated."
set hlbeendeactivated "\0039High Low\0031 has been deactivated."
set hlalreadydeactivated "\0039High Low\0031 has already been deactivated."
set hlonlyinchan "\0039High Low\0031 is only played in"
set hloncmd "on"
set hloffcmd "off"
set hlhelpcmd "help"
set hlactivatecmd "activate"
set hldeactivatecmd "deactivate"

#############################
## These are the commands. ##
#############################

bind pub - !hl hl:setuse
bind pub - !guess hl:guess

######################################################################
## This is where the '!hl <command(s)>' part of the script starts.  ##
######################################################################

proc hl:setuse {nick uhost hand chan arg} {
  global hlinuse correctnumber hlcreator numbertouse highestnumber lowestnumber hlonoroff hlchan hlownerofbot hlcmd
  global hlguesscmd hlnumberstoguess hloncmd hloffcmd hlhelpcmd hlactivatecmd hldeactivatecmd hlinvalidnumber
  global hlnumbertoolow hlnumbertoohigh hlhelpon hlhelpoff hlhelpguess hlonlyinchan hlturnedoff hlbeenactivated
  global hlbeendeactivated hlturnedon hlalreadyon hlalreadyoff hldeactivated hldeact hlhelpactivate hlhelpdeactivate
  global hlalreadyactivated hlalreadydeactivated
  if { $hldeact == 1 } {
    set command [lindex $arg 0]
    if {[string tolower $command] == [string tolower $hlactivatecmd]} { 
      if {[string tolower $nick] == [string tolower $hlownerofbot]} {
        putquick "PRIVMSG $chan :$hlbeenactivated"
        set hlonoroff 1
        set hldeact 0
        } else {
        putquick "NOTICE $nick :Only $hlownerofbot can use this command."
      }
      return
    }
    if {[string tolower $command] == [string tolower $hldeactivatecmd]} { 
      if {[string tolower $nick] == [string tolower $hlownerofbot]} {
        putquick "PRIVMSG $chan :$hlalreadydeactivated"
        } else {
        putquick "NOTICE $nick :Only $hlownerofbot can use this command."
      }
      return
    }
  }
  if { $hlonoroff == 1 } {
    if {[string tolower $chan] == [string tolower $hlchan]} {
      set command [lindex $arg 0]
      if {$command == ""} {
        putquick "NOTICE $nick :\0030,1Type $hlcmd"
      }
      if {[string tolower $command] == [string tolower $hloncmd]} { 
        if { $hlinuse == 0 } {
          set numbertouse [lindex $arg 1]
          if {$numbertouse == ""} {
            putquick "NOTICE $nick :\0030,1Type $hlcmd"
            return
          }
          if {[string tolower $numbertouse] < [string tolower $lowestnumber]} { 
            putquick "NOTICE $nick :\0030,1$hlnumbertoolow $hlinvalidnumber $lowestnumber and $highestnumber."
            return
          }
          if {[string tolower $numbertouse] > [string tolower $highestnumber]} { 
            putquick "NOTICE $nick :\0030,1$hlnumbertoohigh $hlinvalidnumber $lowestnumber and $highestnumber."
            return
            } else {
            set hlinuse 1
            set correctnumber [rand $numbertouse]
            putquick "PRIVMSG $chan :\0039,1High Low\0038,14 By: $hlcreator" 
            putquick "PRIVMSG $chan :$hlturnedon \00310$nick\00314. $hlguesscmd to guess a number." 
            putquick "PRIVMSG $chan :$hlnumberstoguess \002$numbertouse\002\0031." 
          }
          } else {
          putquick "PRIVMSG $chan :$hlalreadyon"
        }
      }
      if {[string tolower $command] == [string tolower $hloffcmd]} { 
        if { $hlinuse == 1 } {
          set hlinuse 0
          set numbertouse ""
          putquick "PRIVMSG $chan :\0034$hlturnedoff \00310$nick."
          } else {
          putquick "PRIVMSG $chan :\0031$hlalreadyoff"
        }
      }
      if {[string tolower $command] == [string tolower $hlhelpcmd]} {
        if {[string tolower $nick] == [string tolower $hlownerofbot]} {
          putquick "NOTICE $nick :\0037,1\002!hl on <number> \002\0033,1- $hlhelpon"
          putquick "NOTICE $nick :\0037,1\002!hl off \002\0033,1- $hlhelpoff"
          putquick "NOTICE $nick :\0037,1\002!guess <number> \002\0033,1- $hlhelpguess"
          putquick "NOTICE $nick :\0037,1\002!hl activate \002\0033,1- $hlhelpactivate"
          putquick "NOTICE $nick :\0037,1\002!hl deactivate \002\0033,1- $hlhelpdeactivate"
          } else {
          putquick "NOTICE $nick :\0037,1\002!hl on <number> \002\0033,1- $hlhelpon"
          putquick "NOTICE $nick :\0037,1\002!hl off \002\0033,1- $hlhelpoff"
          putquick "NOTICE $nick :\0037,1\002!guess <number> \002\0033,1- $hlhelpguess"
        }
      }
      if {[string tolower $command] == [string tolower $hlactivatecmd]} { 
        if {[string tolower $nick] == [string tolower $hlownerofbot]} {
          putquick "PRIVMSG $chan :$hlalreadyactivated"
          } else {
          putquick "NOTICE $nick :\0030,1Only $hlownerofbot can use this command."
        }
      }
      if {[string tolower $command] == [string tolower $hldeactivatecmd]} { 
        if {[string tolower $nick] == [string tolower $hlownerofbot]} {
          putquick "PRIVMSG $chan :$hlbeendeactivated"
          set hlonoroff 0
          set hlinuse 0
          set hldeact 1
          set numbertouse ""
          set correctnumber ""
          } else {
          putquick "NOTICE $nick :\0030,1Only $hlownerofbot can use this command."
        }
      }
      } else {
      putquick "PRIVMSG $chan :$hlonlyinchan $hlchan"
    }
    } else {
    putquick "PRIVMSG $chan :$hldeactivated"
  }
}

#####################################################################
## This is where the '!guess <number>' part of the script starts.  ##
#####################################################################

proc hl:guess {nick uhost hand chan args} {
  global hlinuse correctnumber numbertouse lowestnumber hlchan hlonoroff hlownerofbot 
  global hldeactivated hltrylower hltryhigher hlnoton hlinvalidguess correctmsgs incorrectmsgs hlguesscmd
  set correctmsg [lindex $correctmsgs [rand [llength $correctmsgs]]]
  set incorrectmsg [lindex $incorrectmsgs [rand [llength $incorrectmsgs]]]
  if { $hlonoroff == 1 } {
    if {[string tolower $chan] == [string tolower $hlchan]} {
      if { $hlinuse == 1 } {
        set guess [lindex $args 0]
        if {$guess == ""} {
          putquick "NOTICE $nick :\0030,1$hlguesscmd"
          return
          } else {
          if { [string tolower $guess] == [string tolower $correctnumber] } {
            set hlinuse 0
            putquick "PRIVMSG $chan :\00310$nick\00313 got the correct guess of \002\00312$correctnumber\00313\002. $correctmsg"
          }
          if { [string tolower $guess] > [string tolower $numbertouse] } {
            putquick "NOTICE $nick :\0030,1$hlinvalidguess\0033,1\002 0\002 \0030,1and\0037,1 \002$numbertouse\002."
            return
          }
          if { [string tolower $guess] > [string tolower $correctnumber] } {
            	putquick "PRIVMSG $chan :\0037$incorrectmsg \00310$nick\0037. Your guess of \002$guess\002 was too \002high\002. $hltrylower"
          }
          if { [string tolower $guess] < [string tolower $correctnumber] } {
            	putquick "PRIVMSG $chan :\0033$incorrectmsg \00310$nick\0033. Your guess of \002$guess\002 was too \002low\002. $hltryhigher"
          }
        }
        } else {
        putquick "PRIVMSG $chan :\0031Sorry \00310$nick,\0031 $hlnoton"
      }
      } else {
      putquick "PRIVMSG $chan :$hlonlyinchan $hlchan."
    }
    } else {
    putquick "PRIVMSG $chan :$hldeactivated"
  }
}

putlog "$hlcreator's High Low Script Loaded"