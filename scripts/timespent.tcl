#### ++++ Author: MadaliN <madalinmen28@yahoo.com> 
### +++ Website: www.ChanRank.com 
## +++ TCL Name: Timespent 
# +++ Version: 1.0
## ++++ 
# Commands: 
#   !timespent activate         (local or global owner) 
#   !timespent deactivate         (local or global owner) 
#   !timespent <$nickname> <$chan>      (local or global owner) 
# 

#### 
# +++ Created: 1/26/2013 
#### 

bind TIME - * egghelp:timespent 

bind pub - !idle timespent:pub 
bind pub - !ding timespent:pub 

set announce(time) "1" ;#setting is in hours 

setudef flag timespent 

proc egghelp:timespent {min hour day month year} { 
   global timespent announce noa 

   set list "" 
   foreach chan [channels] { 
      if {[channel get $chan timespent]} { 
         foreach u [chanlist $chan] { 

            set host [lindex [split [getchanhost $u $chan] @] 1] 

            if {![info exists timespent($chan,$host)]} { 
               set timespent($chan,$host) "60 $u" 
               timespent:save 
            } else { 
               set timespent($chan,$host) "[expr [lindex [split $timespent($chan,$host)] 0] + 60] $u" 
               timespent:save 

               if {$announce(time) != ""} { 
                  if {[lindex [split $timespent($chan,$host)] 0] > [expr $announce(time) * 3600]} { 
                     if {![info exists noa($chan,$host)]} { 
                        set noa($chan,$host) "[unixtime]" 
                        timespent:save 

                        lappend list "\00303[lindex [split $timespent($chan,$host)] 1]\003" 
                     } 
                  } 
               } 
            } 
         } 
         if {$list != ""} { 
            putserv "PRIVMSG $chan :Users who spent more than \00312$announce(time)\003 hour    on \00304$chan\003 are: [join $list "\002,\002 "]" 
         } 
      } 
   } 
} 

proc timespent:pub {nick uhost hand chan arg} { 
   global timespent 

   set host [lindex [split [getchanhost [lindex [split $arg] 0] $chan] @] 1] 

   switch -exact -- [lindex [split $arg] 0] { 
      activate { 
         if {[matchattr $hand n] || [matchattr $hand |N $chan]} { 
            channel set $chan +timespent 

            putserv "PRIVMSG $chan :\002$nick\002 - TIMESPENT script \00312activated\003 succesfully" 
         } 
      } 
      deactivate { 
         if {[matchattr $hand n] || [matchattr $hand |N $chan]} { 
            channel set $chan -timespent 

            putserv "PRIVMSG $chan :\002$nick\002 - TIMESPENT script \00304deactivated\003 succesfully" 
         } 
      } 
      default { 

            if {[string match -nocase "#*" [lindex [split $arg] 1]]} { 
               if {![info exists timespent([lindex [split $arg] 1],$host)]} { 
                  putserv "PRIVMSG $chan :\002$nick\002 - Nickname \00303[lindex [split $arg] 0]\003 has no info on \00312[lindex [split $arg] 1]" 
               } else { 
                  putserv "PRIVMSG $chan :\002$nick\002 - Nickname \00303[lindex [split $arg] 0]\003 idled on \00312[lindex [split $arg] 1]\003 for \00303[duration [lindex [split $timespent([lindex [split $arg] 1],$host)] 0]]" 
               } 
            } else { 
               if {![info exists timespent($chan,$host)]} { 
                  putserv "PRIVMSG $chan :\002$nick\002 - Nickname \00303[lindex [split $arg] 0]\003 has no info on this channel" 
               } else { 
                  putserv "PRIVMSG $chan :\002$nick\002 - Nickname \00303[lindex [split $arg] 0]\003 idled on \00312$chan\003 for \00303[duration [lindex [split $timespent($chan,$host)] 0]]" 
               } 
            } 
      } 
   } 
} 

proc timespent:save {} { 
   global timespent 

   set ofile [open timespent w] 
   puts $ofile "array set timespent [list [array get timespent]]" 
   close $ofile 
} 

catch {source timespent} 

putlog "+++ Succesfully loaded: \00312Timpespent TCL Script" 