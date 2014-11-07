# Commands: 
# ---------
# OPs:  !ignore add <*!*host@mask.etc> <duration> <reason>
#       !ignore add <nick> <duration> <reason>
#       !ignore del *!*host@mask.etc
#       !ignores
package require http
package require tls
package require json
# The trigger

set pubtrig "!"

# ---- EDIT END ----
proc getTrigger {} {
  global pubtrig
  return $pubtrig
}
bind pub - ${pubtrig}tits tits:pub
bind pub - ${pubtrig}ass ass:pub
bind pub - ${pubtrig}pussy pussy:pub
bind pub - ${pubtrig}nsfw nsfw:pub

proc tits:pub {nick host hand chan arg} {
  set page [myRand 0 50]
  set theurl "https://api.imgur.com/3/gallery/r/Boobies/time/$page"
  dict set hdr Authorization "Client-ID cefb2e6ae32f74f"
  http::register https 443 [list ::tls::socket -tls1 1]
  set token [http::geturl $theurl -headers $hdr -query]
  set responseBody [::json::json2dict [http::data $token]]
  set data [lindex $responseBody 1]
  set linkid [myRand 0 30]
  set imagedata [lindex $data $linkid]
  if {[regexp -nocase {link (.*?) reddit_comments} $imagedata " " link]} {
    regsub -nocase -- {link (.*?) reddit_comments} $link "\\1" link
  } else {
    set link "Wohhh there cowboy, slow down!"
  }
  if {[regexp -nocase {title {(.*?)} description} $imagedata " " title]} {
    regsub -nocase -- {title {(.*?)} description} $title "\\1" title
  } else {
    set title "Title Unknown"
  }
  putserv "PRIVMSG $chan :Your random tits! $link - Title: $title"
  http::cleanup $token
}
proc ass:pub {nick host hand chan arg} {
  set page [myRand 0 50]
  set theurl "https://api.imgur.com/3/gallery/r/ass/time/$page"
  dict set hdr Authorization "Client-ID cefb2e6ae32f74f"
  http::register https 443 [list ::tls::socket -tls1 1]
  set token [http::geturl $theurl -headers $hdr -query]
  set responseBody [::json::json2dict [http::data $token]]
  set data [lindex $responseBody 1]
  set linkid [myRand 0 30]
  set imagedata [lindex $data $linkid]
  if {[regexp -nocase {link (.*?) reddit_comments} $imagedata " " link]} {
    regsub -nocase -- {link (.*?) reddit_comments} $link "\\1" link
  } else {
    set link "Wohhh there cowboy, slow down!"
  }
  if {[regexp -nocase {title {(.*?)} description} $imagedata " " title]} {
    regsub -nocase -- {title {(.*?)} description} $title "\\1" title
  } else {
    set title "Title Unknown"
  }
  putserv "PRIVMSG $chan :Your random ass! $link - Title: $title"
  http::cleanup $token
}
proc pussy:pub {nick host hand chan arg} {
  set page [myRand 0 50]
  set theurl "https://api.imgur.com/3/gallery/r/pussy/time/$page"
  dict set hdr Authorization "Client-ID cefb2e6ae32f74f"
  http::register https 443 [list ::tls::socket -tls1 1]
  set token [http::geturl $theurl -headers $hdr -query]
  set responseBody [::json::json2dict [http::data $token]]
  set data [lindex $responseBody 1]
  set linkid [myRand 0 30]
  set imagedata [lindex $data $linkid]
  if {[regexp -nocase {link (.*?) reddit_comments} $imagedata " " link]} {
    regsub -nocase -- {link (.*?) reddit_comments} $link "\\1" link
  } else {
    set link "Wohhh there cowboy, slow down!"
  }
  if {[regexp -nocase {title {(.*?)} description} $imagedata " " title]} {
    regsub -nocase -- {title {(.*?)} description} $title "\\1" title
  } else {
    set title "Title Unknown"
  }
  putserv "PRIVMSG $chan :Your random pussy! $link - Title: $title"
  http::cleanup $token
}
proc myRand { min max } {
    set maxFactor [expr [expr $max + 1] - $min]
    set value [expr int([expr rand() * 100])]
    set value [expr [expr $value % $maxFactor] + $min]
return $value
}
proc nsfw:pub {nick host hand chan arg} {
  set page [myRand 0 50]
  set theurl "https://api.imgur.com/3/gallery/r/nsfw/time/$page"
  dict set hdr Authorization "Client-ID cefb2e6ae32f74f"
  http::register https 443 [list ::tls::socket -tls1 1]
  set token [http::geturl $theurl -headers $hdr -query]
  set responseBody [::json::json2dict [http::data $token]]
  set data [lindex $responseBody 1]
  set linkid [myRand 0 30]
  set imagedata [lindex $data $linkid]
  if {$arg != ""} {
    set listnsfw ""
    for {set i 0} {$i < $arg} {incr i} {
      set randata [lindex $data $i]
        if {[regexp -nocase {link (.*?) reddit_comments} $randata " " link]} {
          regsub -nocase -- {link (.*?) reddit_comments} $link "\\1" link
          lappend listnsfw $link
        } else {
          set link "Wohhh there cowboy, slow down!"
        }
    }
    putserv "PRIVMSG $chan :Random Tities/Ass/Pussy/Whoknows $listnsfw"
  } else {
        if {[regexp -nocase {link (.*?) reddit_comments} $randata " " link]} {
          regsub -nocase -- {link (.*?) reddit_comments} $link "\\1" link
        } else {
          set link "Wohhh there cowboy, slow down!"
        }
        if {[regexp -nocase {title {(.*?)} description} $randata " " title]} {
          regsub -nocase -- {title {(.*?)} description} $title "\\1" title
        } else {
          set title "Title Unknown"
        }
        putserv "PRIVMSG $chan :Your random pussy! $link - Title: $title"
  }
  
  http::cleanup $token
}
proc myRand { min max } {
    set maxFactor [expr [expr $max + 1] - $min]
    set value [expr int([expr rand() * 100])]
    set value [expr [expr $value % $maxFactor] + $min]
return $value
}
#putlog ".:Loaded:. ignore.tcl - HackPat@Freenode"