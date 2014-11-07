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
#bind pub - ${pubtrig}tits tits:pub

proc tits:pub {} {
  set page [myRand 0 100]
  set theurl "https://api.imgur.com/3/gallery/r/boobs/time/$page"
  dict set hdr Authorization "Client-ID cefb2e6ae32f74f"
  http::register https 443 [list ::tls::socket -tls1 1]
  set token [http::geturl $theurl -headers $hdr -query]
  set responseBody [::json::json2dict [http::data $token]]
  set data [lindex $responseBody 1]
  set linkid [myRand 0 30]
  set link [lindex $data $linkid]
  puts $link
  puts [dict size $data]
  http::cleanup $token

}  
proc myRand { min max } {
    set maxFactor [expr [expr $max + 1] - $min]
    set value [expr int([expr rand() * 100])]
    set value [expr [expr $value % $maxFactor] + $min]
return $value
}
tits:pub

#putlog ".:Loaded:. ignore.tcl - HackPat@Freenode"