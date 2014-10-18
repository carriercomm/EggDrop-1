##############################################################################################
##  ## Horoscope.tcl for eggdrop by Ford_Lawnmower irc.geekshed.net #Script-Help        ##  ##
##############################################################################################
##      To use this script you must set channel flag +horo (ie .chanset #chan +horo)        ##
##############################################################################################
##############################################################################################
##      ____                __                 ###########################################  ##
##     / __/___ _ ___ _ ___/ /____ ___   ___   ###########################################  ##
##    / _/ / _ `// _ `// _  // __// _ \ / _ \  ###########################################  ##
##   /___/ \_, / \_, / \_,_//_/   \___// .__/  ###########################################  ##
##        /___/ /___/                 /_/      ###########################################  ##
##                                             ###########################################  ##
##############################################################################################
##  ##                             Start Setup.                                         ##  ##
##############################################################################################
package require http
package require tls
## Change the character between the "" below to change the command character/trigger.       ##
set horoscopecmdchar "!"
proc horoscope {nick host hand chan search} {
  if {[lsearch -exact [channel info $chan] +horo] != -1} {
## Change the characters between the "" below to change the logo shown with each result.    ##
    set horoscopelogo "\002\00314H\0034o\0038r\00314o\0039s\0034c\00314o\0038p\0039e\002\003"
## Change the format codes between the "" below to change the color/state of the text.      ##
    set textf "\0034"
##############################################################################################
##  ##                           End Setup.                                              ## ##
##############################################################################################
    set horoscopesite "https://uk.astrology.yahoo.com"
    set horoscopesign [getsign $search]
    if {$horoscopesign == "error"} { 
      putserv "PRIVMSG $chan :$horoscopelogo Valid signs are: Aquarius, Pisces, Aries, Taurus, Gemini, Cancer, Leo, Virgo, Libra, Scorpio, Sagittarius, Capricorn."
    } else {
      set horoscopeurl /horoscopes/${horoscopesign}/
      set horoscopefound ""
      ::http::register https 443 tls::socket
      ::http::config -accept "text/html" -useragent "firefox"
      set horoscopetoken [::http::geturl ${horoscopesite}${horoscopeurl}]      
      set horoscopevar [::http::data $horoscopetoken]
      ::http::cleanup $horoscopetoken
      ::http::unregister https
      if {[regexp {<div class="astro-tab-body">(.*?)<\/div>} $horoscopevar match horoscoperesult]} {
     set horoscoperesult [textsplit $horoscoperesult. 50]
     set counter 0
     while {$counter <= [llength $horoscoperesult]} {
       if {[lindex $horoscoperesult $counter] != ""} {
         putserv "PRIVMSG $chan :$horoscopelogo $textf[lindex $horoscoperesult $counter]"
       }
       incr counter
     }
      }              
    }
  }
}
proc textsplit {text limit} {
  set text [split $text " "]
  set tokens [llength $text]
  set start 0
  set return ""
  while {[llength [lrange $text $start $tokens]] > $limit} {
    incr tokens -1
    if {[llength [lrange $text $start $tokens]] <= $limit} {
      lappend return [join [lrange $text $start $tokens]]
      set start [expr $tokens + 1]
      set tokens [llength $text]
    }
  }
  lappend return [join [lrange $text $start $tokens]]
  return $return
}
proc getsign {text} {
  if {[regexp -nocase {^aqu} $text]} { return aquarius
  } elseif {[regexp -nocase {^pis} $text]} { return pisces 
  } elseif {[regexp -nocase {^ari} $text]} { return aries 
  } elseif {[regexp -nocase {^tau} $text]} { return taurus 
  } elseif {[regexp -nocase {^gem} $text]} { return gemini 
  } elseif {[regexp -nocase {^can} $text]} { return cancer 
  } elseif {[regexp -nocase {^leo} $text]} { return leo 
  } elseif {[regexp -nocase {^vir} $text]} { return virgo
  } elseif {[regexp -nocase {^lib} $text]} { return libra
  } elseif {[regexp -nocase {^sco} $text]} { return scorpio 
  } elseif {[regexp -nocase {^sag} $text]} { return sagittarius 
  } elseif {[regexp -nocase {^cap} $text]} { return capricorn
  } else { return "error" }
}
bind pub - ${horoscopecmdchar}horo horoscope
setudef flag horo
putlog "\017\002Horoscope Script by Ford_Lawnmower successfully loaded!"