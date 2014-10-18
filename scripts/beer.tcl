####################################################################
##         beer.tcl v.1.beta1 by SpiKe^^  ##  15 Mar 09  -        ##
####################################################################
#                                                                  #
# beer is a simple channel chatter script.  Included are default   #
# bartender triggers.  Can be used for Any Triggers.  Variable     #
# replacements can be used in all replies.  Complete on-join greet #
# functions included.                                              #
#                                                                  #
# Add this line:      source scripts/beer.tcl                      #
# to your eggdrop config and rehash to load the script.            #
#                                                                  #
#           Please report bugs or make comments at:                #
#                irc: undernet: #pc-mIRC-help                      #
#              email: spike@mytclscripts.com                       #
#               http://www.mytclscripts.com                        #
#                                                                  #
#                       Highlights                                 #
# 1. Unlimited Public Triggers with Public Replies                 #
# 2. Flood Protection                                              #
# 3. Multi-Channel                                                 #
# 4. Control Access by User Flags                                  #
# 5. Complete On-Join Greeting Functions                           #
# 6. Variable Replacements in All Replies:                         #
#     %m (me)         :is replaced by the users nick               #
#     %d (drinker)    :is replaced by the nick(s) provided         #
#     %b (bartender)  :is replaced by the botnick                  #
#     %c (channel)    :is replaced by the channel                  #
#                                                                  #
####################################################################
#                                                                  #
#                        Beer Script Notes                         #
#                                                                  #
# 1. Script can set an unlimited number of public triggers and     #
#    a one line public reply for each trigger.                     #
#                                                                  #
# 2. Triggers/replies are listed in the tcl setting, one per line: #
#                                                                  #
#    Example:  beer %b hands %d a beer.                            #
#                                                                  #
#    The first word in the line is the trigger word:    beer       #
#    Trigger can be any one word  (No Spaces in triggers).         #
#    Everything else is the reply:    %b hands %d a beer.          #
#                                                                  #
# 3. Script will trigger in 3 different ways:                      #
#    a.  The trigger by itself:   !beer                            #
#        Drinker (%d) would be replaced by the users nick          #
#    b.  Trigger with a target nick:   !beer SpiKe^^               #
#        Drinker would be replaced by the nick:   SpiKe^^          #
#    c.  Trigger with multiple nicks:   !beer SpiKe^^ ted bart     #
#        Drinker would be replaced by:   SpiKe^^ ted & bart        #
#                                                                  #
# 4. Variable replacement codes for nicks in replies:              #
#     %m (me)         :usually replaced by the users nick          #
#     %d (drinker)    :usually replaced by the nick(s) provided    #
#     %b (bartender)  :always replaced by the botnick              #
#                                                                  #
# 4. Variable replacement notes:                                   #
#    a.  Don't use all 3 nick codes in the same reply.             #
#        If no target nick is provided, (me) & (drinker) would     #
#        both be replaced by the users nick.                       #
#    b.  If reply uses both (me) & (drinker) replacement codes,    #
#        and no target nick is provided...                         #
#          %d    :would be replaced by the users nick              #
#          %m    :would be replaced by the botnick  (bartender)    #
#                                                                  #
####################################################################




################################################
########  Beer Channel Talker Settings  ########
################################################

##  set Beer Channels here  ##
# ex. {#MyChan}
# ex. {#powerdrinkers #bud #weiser}
# or:  {*}  = all channels
set beerchans {*}

##  set public beer flags here  ##
##  userfile flags required to trigger the beer script (-|- = everyone)  ##
set beerflags -|-

##  set public trigger prefix here  (can be "")  ##
set beerpre "!"

##  set beer flood settings  ##
set beerflood  4  ;##  number of beer requests in 10 seconds  ##
set beerignore 20  ;##  next request sets ignore for 'x' seconds  ##
set beerigmsg "Beer Flood! The bar is now closed."  ;##  can be "" for no msg  ##
set beeropen "The bar is now open."  ;##  can be "" for no msg  ##

##  set reply colors here  (each can be "")  ##
set beercolor1 "10"  ;# all beer reply lines start this color #
set beercolor2 "10"
set beercolor3 "10"
set beercolor4 "10"

########################################
####  Beer Talker Triggers/Replies  ####
########################################

##  set triggers and returns here ##
##  trigger first,  no spaces in triggers!!  ##
####  variable replacement  ####
##  %m (me)         :is replaced by the users nick  ##
##  %d (drinker)    :is replaced by the nick(s) provided  ##
##  %b (bartender)  :is replaced by the botnick  ##
##  %c (channel)    :is replaced by the channel  ##
##  %p (prefix)     :is replaced by the command prefix setting  ##
####  colors replacement  (all reply lines start with color #1)  ####
##  %1 (color #1)   :is replaced by color #1 from above  ##
##  %2 (color #2)   :is replaced by color #2 from above  ##
##  %3 (color #3)   :is replaced by color #3 from above  ##
##  %4 (color #4)   :is replaced by color #4 from above  ##

set beers {

menu We have %pbeer %pcocktails %pshots %pwine %pmunchies %pjukebox %phouse

beer We have %pbud %pbudlight %pbudice %pmiller
bud  %d says pop a top again %b. I think I'll have another round. 
budlight 1 for %d and 1 for %m.
budice %b hands %d a budice
miller another please %b. Few more and I'll be living the "high" life ;)

cocktails We have %pmargaritas
margaritas %d says hey %b, give the lady here a drink. Lord have mercy, my only thought was tequila makes her clothes fall off.

shots We have %ptequlia %pwhiskey %pscotch %pburbon 
tequila %b pours the shot thinking... 1 tequila, 2 tequila 3 tequila, floor.
whiskey %b hands %d a double shot and reflects... few more of those you'll be dancing on the ceiling.
scotch another round my friend, and one for %d
burbon %d loosens tie and sighs... %b triple on the rocks if it does ya:)

wine We have %pred %pwhite
red %b sings red red wine you make me feel so fine...you keep me rocking all of the time, and hands %d the glass 
white hey %b once i drank a lil wine and it made me oh so fine. so keep em coming %b then we can dance and party all night

munchies We have %pchips %ppretzels %peggs %ppizza %pcheeseberger
chips Hey %d, betcha can't eat just one.
pretzels %b places a bowl of pretzels on the bar. 
eggs hmmm pickled eggs and beer.. are ya sure;) 
pizza %b places a piping hot fully loaded pizza in front of %d enjoy %d
cheeseberger %b asks...want fries with that

jukebox We play all the hits. %prock %pcountry %ppunk %pcomedy
rock Sammy Hagar Sings... One shot...Hey! more tequila! Two shots...Hey! que veneno! Three shots... Ay yi yi yi yi ... Hey! Hey! Hey! Hey! Hey! Hey! 
country Jimmy Buffet Sings... So %b bring a pitcher, Another round of brew...Honey why don't we get drunk and screw
punk Bare Naked Ladies Sings... I love you more then the week before... I discovered alcohol.
comedy The Blues Brothers Sing... Hey %b Draw one, two, three, four glasses of beer

house We have %pladies %pgents %pstool %plastcall %pbar %pround %ptime %pdrunk %psingalong
ladies its ladies nite %b buys all the pretty ladies a drink 
gents This is your lucky nite boys. Wet t-shirt contest tonight.
stool well hell I was sure that stool was there a minute ago
lastcall The clock on the wall says 3 o'clock... last call for alcohol... What ya need;)
bar %b buys everyone on %c a drink
round %d buys everyone on %c a drink
time Time for another round. What'll it be boys & girls;)
drunk Who %d  
singalong We have 99 bottles of beer on the wall, 99 bottles of beer, %b takes one down....

}  ;## end beers list ##



###############################################
########  Beer Channel Greet Settings  ########
###############################################

##  send onjoin greeting how ??  (0 = no channel greeting)  ##
set beeronjoin 0  ;# 1=privatemsg 2=usernotice 3=public inchan 4=channelnotice #

##  set channels to do onjoin message in  ##
##  NOTE:  onjoin messages only sent to Beer Channels  ##
# ex. {#MyChan}
# ex. {#powerdrinkers #bud #weiser}
# or:  {*}  = all Beer Channels
set beerjchans {*}

##  set exempt user flags for onjoin  ##
# ex. b       :same as b|b  :exempt all global & channel bots
# ex. -|mn    :exempt only channel masters & owners
# ex. f|*     :exempt global friends and everyone with any channel flags
set beerjxmpt bmno|fmn

##  OnJoin reply flood  ##  mostly for beeronjoin setting 1 or 2 above  ##
set beerjflood  4  ;##  max number of joins to reply to in 10 seconds  ##

#######################################
####  Beer Channel Greetings Text  ####
#######################################

##  set the text to send for OnJoin greetings  ##
####  variable replacement  (for both public & private greetings)  ####
##  %b (bot nick)   :is replaced by the botnick  ##
##  %p (prefix)     :is replaced by the command prefix setting  ##
##  %1 (color #1)   :is replaced by color #1 from above  ##
##  %2 (color #2)   :is replaced by color #2 from above  ##
##  %3 (color #3)   :is replaced by color #3 from above  ##
##  %4 (color #4)   :is replaced by color #4 from above  ##


##  set public (in channel) join message/notice  # for settings 3 & 4 above ##
##  note:  also used after a join flood, even if set to 1 or 2 ##
####  variable replacement  (for public greetings)  ####
##  %c (channel)    :is replaced by the channel joined   ##
##  %n (nick)       :is replaced by the nick(s) that joined  ##
##  %j (joined)     :above nicks joined with ,'s or a &  ##
set beerpubjoin {

[%n] Welcome to %c I'm %b. I'll be your bartender today. We have %pbeer %pcocktails %pshots %pwine %pmunchies %pjukebox %phouse

}  ;## end onjoin msg  ##

##  set private message/notice join text  # for settings 1 & 2 above ##
####  variable replacement  (for private greetings)  ####
##  %n (nick)       :is replaced by the users nick  ##
##  %c (channel)    :is replaced by the channel(s) this nick joined  ##
##  %j (joined)     :above channels joined with ,'s or a &  ##
set beerusrjoin {

[%n] Welcome to %c I'm %b. I'll be your bartender today. We have %pbeer %pcocktails %pshots %pwine %pmunchies %pjukebox %phouse

}  ;## end onjoin msg  ##



########################################################################################
### end settings ### end settings ### end settings ### end settings ### end settings ###
### end settings ### end settings ### end settings ### end settings ### end settings ###
########################################################################################

set beerchans [split [string trim $beerchans]]
set beerigmsg [string trim $beerigmsg]  ;  set beeropen [string trim $beeropen]

proc BrIsDig {str} { return [string is digit -strict $str] }
proc BrStrLo {str} { return [string tolower $str] }

if {$beercolor1 eq "" && $beercolor2 eq "" && $beercolor3 eq "" && $beercolor4 eq ""} {
  array set beer {clr1 "" clr2 "" clr3 "" clr4 ""}
} elseif {$beercolor1 eq $beercolor2 && $beercolor1 eq $beercolor3 && $beercolor1 eq $beercolor4} {
  array set beer {clr2 "" clr3 "" clr4 ""}  ;  set beer(clr1) $beercolor1
} else {
  array set beer [list clr1 $beercolor1 clr2 $beercolor2 clr3 $beercolor3 clr4 $beercolor4]
}
unset beercolor1 beercolor2 beercolor3 beercolor4

foreach brtmp [binds DrinkNow] {
 foreach {brtyp brflg brnam brhit brprc} $brtmp {  break  }
 unbind $brtyp $brflg $brnam $brprc
}

set beers [split [string trim $beers] "\n"]  ;  set newbeers ""
foreach bitem $beers {  set brtmp [split [string trim $bitem]]
 if {[llength $brtmp]>"1"} {  set brtrig [lindex $brtmp 0]  ;  set brtxt [join [lrange $brtmp 1 end]]
 set brtxt [string map [list %p $beerpre] $brtxt]
   foreach brchan $beerchans {  bind pubm $beerflags "$brchan $beerpre$brtrig*" DrinkNow  }
   if {[string match {*%[1234]*} $brtxt]} {  set brtmp ""
     if {![string match {%[1234]*} $brtxt]} {
       if {$beer(clr1) ne ""} {  set brtmp $beer(clr1)  }
     } elseif {[string index $brtxt 1]=="2"} {
       if {$beer(clr2) eq ""} {  set brtxt [string range $brtxt 2 end]  }
     } elseif {[string index $brtxt 1]=="3"} {
       if {$beer(clr3) eq ""} {  set brtxt [string range $brtxt 2 end]  }
     } elseif {[string index $brtxt 1]=="4"} {
       if {$beer(clr4) eq ""} {  set brtxt [string range $brtxt 2 end]  }
     } else {
       if {$beer(clr1) eq ""} {  set brtxt [string range $brtxt 2 end]  }
     }
     set brtxt [string map [list %1 $beer(clr1) %2 $beer(clr2) %3 $beer(clr3) %4 $beer(clr4)] $brtxt]
   } else {
     if {$beer(clr1) eq ""} {  set brtmp ""  } else {  set brtmp $beer(clr1)  }
   }
   lappend newbeers "$beerpre$brtrig $brtmp$brtxt"
 }
}
set beers $newbeers

if {![info exists beer(fludcnt)]} {  set beer(fludcnt) 0  }
if {![info exists beer(ignore)]} {  set beer(ignore) 0  }
if {![info exists beer(publs)]} {  set beer(publs) ""  }

proc ZeroFcnt {} {  global beer
 if {$beer(ignore)=="0"} {  set beer(publs) ""  ;  set beer(fludcnt) 0  }
}

proc UnIgnore {cnt} {  global beer beeropen  ;  incr beer(ignore) -$cnt
 if {$beer(ignore)=="0"} {
   if {$beeropen ne ""} {
     if {$beer(clr1) eq ""} {  set brtmp ""  } else {  set brtmp $beer(clr1)  }
     foreach chan $beer(publs) {  puthelp "PRIVMSG $chan :$brtmp $beeropen"  }
   }
   set beer(publs) ""  ;  set beer(fludcnt) 0
 }
}

proc DrinkNow {nk uh hn ch tx} {  global beer beers beerflood beerignore beerigmsg botnick
 set tx [split $tx]  ;  set next [lsearch -inline $beers "[lindex $tx 0] *"]
 if {$next ne ""} {
   if {$beer(fludcnt)==$beerflood} {  utimer $beerignore "UnIgnore 1"  ;  incr beer(ignore)
     if {[lsearch $beer(publs) $ch]=="-1"} {  lappend beer(publs) $ch  }
     if {$beerigmsg ne ""} {
       if {$beer(clr1) eq ""} {  set brtmp ""  } else {  set brtmp $beer(clr1)  }
       foreach chan $beer(publs) {  puthelp "PRIVMSG $chan :$brtmp $beerigmsg"  }
     }
   } elseif {$beer(fludcnt)>$beerflood && [lsearch $beer(publs) $ch]=="-1"} {  lappend beer(publs) $ch
     if {$beerigmsg ne ""} {
       if {$beer(clr1) eq ""} {  set brtmp ""  } else {  set brtmp $beer(clr1)  }
       puthelp "PRIVMSG $ch :$brtmp $beerigmsg"
     }
   }
   incr beer(fludcnt)
   if {$beer(ignore)>"0"} {  return 0  }
   if {$beer(fludcnt)=="1"} {  utimer 10 ZeroFcnt  }
   if {[lsearch $beer(publs) $ch]=="-1"} {  lappend beer(publs) $ch  }
   set me $nk  ;  set drinker $me  ;  set bar $botnick
   if {[llength $tx]=="1"} {
     if {[string match *%b* $next] && [string match *%d* $next] && [string match *%m* $next]} {  set err 1
     } elseif {[string match *%d* $next] && [string match *%m* $next]} {  set me $bar  }
   } elseif {[llength $tx]=="2"} {  set drinker [lindex $tx 1]
   } else {  set drinker "[join [lrange $tx 1 end-1]] & [lindex $tx end]"  }
   puthelp "PRIVMSG $ch :[string map [list %d $drinker %c $ch %m $me %b $bar] [join [lrange [split $next] 1 end]]]"
 }
}

## beer on-join code ##

foreach brtmp [binds BeerJoin] {
 foreach {brtyp brflg brnam brhit brprc} $brtmp {  break  }
 unbind $brtyp $brflg $brnam $brprc
}

if {![BrIsDig $beeronjoin]} {  set beeronjoin 0  }

if {$beeronjoin>"0"} {
  if {$beerjchans eq "" || $beerjchans eq "*"} {  set beerjchans $beerchans
  } else {  set beerjchans [split [string trim $beerjchans]]  ;  set brtmp ""
    foreach bchan $beerjchans {
     if {$beerchans eq "*" || [lsearch [BrStrLo $beerchans] [BrStrLo $bchan]]>"-1"} {
         lappend brtmp $bchan  }
    }
    if {$brtmp ne ""} {  set beerjchans $brtmp  } else {  set beeronjoin 0
      putlog "Beer.tcl on-join message disabled. Missing/Invalid On-Join Channel(s)."
    }
  }
}

if {$beeronjoin>"0"} {  set brcnt 0
  foreach brmsg [list $beerusrjoin $beerpubjoin] {  incr brcnt
   set brmsg [split [string trim $brmsg] "\n"]  ;  set newgreet ""
   foreach bline $brmsg {  set bline [string trim $bline]
    if {$bline ne ""} {  lappend newgreet [string map [list %p $beerpre] $bline]  }
   }
   if {$brcnt=="1"} {  set beerusrjoin $newgreet  } else {  set beerpubjoin $newgreet  }
  }
  if {$beerpubjoin eq ""} {  set beeronjoin 0
    putlog "Beer.tcl on-join message disabled. Missing a Public On-Join Message."
  } elseif {$beerusrjoin eq "" && $beeronjoin<"3"} {
    putlog "Beer.tcl on-join message set public. Missing a User On-Join Message."
    if {$beeronjoin=="1"} {  set beeronjoin 3  } else {  set beeronjoin 4  }
  }
}

if {$beeronjoin=="0"} {  unset beerusrjoin beerpubjoin beerjchans beerjflood beerjxmpt
  if {[info exists beer(joinls)]} {
      unset beer(joinls) beer(joincnt) beer(joinflud) beer(lastjmsg) beer(wasflud)  }
  if {[info exists beer(jtimer)]} {  unset beer(jtimer)  }
} else {  set beerjxmpt [string trim $beerjxmpt]
  if {$beerjxmpt ne ""} {
    if {[string first | $beerjxmpt]=="-1"} {  append beerjxmpt |$beerjxmpt  }
    set beerjxmpt [split $beerjxmpt |]
  }
  if {$beerjxmpt eq "- -"} {  set beerjxmpt ""  }
  if {![info exists beer(joinls)]} {
      array set beer {joinls "" joincnt 0 joinflud 0 lastjmsg "" wasflud 0}  }
  foreach brch $beerjchans {  bind join - "$brch *" BeerJoin  }
####  Begin PROC BeerJoin  ####
  proc BeerJoin {nk uh hn ch} {  global beer beerjflood beerjxmpt botnick
   if {$beer(joincnt)==$beerjflood} {  set beer(joinflud) 1  ;  set beer(wasflud) 1  }
   incr beer(joincnt)  ;  set xmpt 0
   if {$nk eq $botnick} {  set xmpt 1
   } elseif {$beerjxmpt ne "" && $hn ne "*"} {  foreach {ng nc} $beerjxmpt { break }
     set flgs [split [chattr $hn $ch] |]  ;  foreach {hg hc} $flgs { break }
     if {$ng ne "-" && $ng ne ""} {
       if {$ng eq "*" && $hg ne "-"} {  set xmpt 1
       } else {  set patrn *\[$ng\]*
         if {[string match $patrn $hg]} {  set xmpt 1  }
       }
     }
     if {$xmpt=="0" && $nc ne "-" && $nc ne ""} {
       if {$nc eq "*" && $hc ne "-"} {  set xmpt 1
       } else {  set patrn *\[$nc\]*
         if {[string match $patrn $hc]} {  set xmpt 1  }
       }
     }
   }
   if {$xmpt=="0"} {
     if {[lsearch [BrStrLo $beer(joinls)] [BrStrLo $nk@$ch]]=="-1"} { lappend beer(joinls) $nk@$ch }
     if {![info exists beer(qtimer)]} {  set beer(qtimer) [utimer 4 SndJmsg]  }
   }
   if {![info exists beer(jtimer)]} {  set beer(jtimer) [utimer 10 ZeroJcnt]  }
  }
####  End PROC BeerJoin  ####
####  Begin PROC ZeroJcnt  ####
  proc ZeroJcnt {} {  global beer beerjflood
   if {$beer(joincnt)>$beerjflood} {  set beer(wasflud) 1  } else {  set beer(wasflud) 0  }
   set beer(joincnt) 0
   if {$beer(wasflud)=="0"} {  unset beer(jtimer)
     if {$beer(joinls) eq ""} {  ;## if the queue has stopped running too ##
       if {$beer(wasflud)=="0"} {  set beer(joinflud) 0  }
     }
     return 0
   }
   set beer(jtimer) [utimer 10 ZeroJcnt]
  }
####  End PROC ZeroJcnt  ####
####  Begin PROC SndJmsg  ####
  proc SndJmsg {} {  global beer beeronjoin beerusrjoin beerpubjoin botnick
   set idx -1  ;  set got 0
   foreach nc $beer(joinls) {  incr idx
    foreach {nk ch} [split $nc @] {  break  }
    if {[onchan $nk $ch] && [BrStrLo $nc] ne $beer(lastjmsg)} {  set got 1  ;  break  }
   }
   if {$got=="0"} {  set beer(joinls) ""
   } else {  set beer(lastjmsg) [BrStrLo $nc]
     set beer(joinls) [lreplace $beer(joinls) 0 $idx]  ;  set how 2
     if {$beer(joinflud)=="1" && $beeronjoin=="1"} {  set putpre "PRIVMSG $ch :"
     } elseif {$beer(joinflud)=="1" && $beeronjoin=="2"} {  set putpre "NOTICE $ch :"
     } elseif {$beeronjoin=="1"} {  set putpre "PRIVMSG $nk :"  ;  set how 1
     } elseif {$beeronjoin=="2"} {  set putpre "NOTICE $nk :"  ;  set how 1
     } elseif {$beeronjoin=="4"} {  set putpre "NOTICE $ch :"
     } else {  set putpre "PRIVMSG $ch :"  }
     set brtmp ""  ;  set newjls ""
     if {$how=="1"} {  lappend brtmp $ch  ;  set st $nk@*
     } else {  lappend brtmp $nk  ;  set st *@$ch  }
     foreach onc $beer(joinls) {
      if {[string match -nocase $st $onc]} {
        foreach {onk och} [split $onc @] {  break  }
        if {[onchan $onk $och]} {
          if {$how=="1"} {  lappend brtmp $och  } else {  lappend brtmp $onk  }
        }
      } else {  lappend newjls $onc  }
     }
     set beer(joinls) $newjls
   }
   if {$beer(joinls) eq ""} {  unset beer(qtimer)
     if {$beer(wasflud)=="0"} {  set beer(joinflud) 0  }
   } else {  set beer(qtimer) [utimer 4 SndJmsg]  }
   if {$got=="1"} {  set norc [join $brtmp]
     if {[llength $brtmp]<"3"} {  set brtmp [join $brtmp " & "]
     } else {  set brtmp [join $brtmp ", "]  }
     set maps [list %b $botnick %1 $beer(clr1) %2 $beer(clr2) %3 $beer(clr3) %4 $beer(clr4)]
     if {$how=="1"} {  set txlns $beerusrjoin  ;  lappend maps %n $nk %c $norc %j $brtmp
     } else {  set txlns $beerpubjoin  ;  lappend maps %n $norc %c $ch %j $brtmp  }
     foreach txtl $txlns {  puthelp "$putpre[string map $maps $txtl]"  }
   }
  }
####  End PROC SndJmsg  ####
}

putlog "beer.tcl v.1.beta1 by SpiKe^^ loaded"
