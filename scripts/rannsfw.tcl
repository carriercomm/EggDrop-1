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
  set theurl "https://api.imgur.com/3/gallery/r/boobs"
  dict set hdr Authorization "Client-ID cefb2e6ae32f74f"
  http::register https 443 [list ::tls::socket -tls1 1]
  set token [http::geturl $theurl -headers $hdr -query]
  set responseBody [::json::json2dict [http::data $token]]
  set data [lindex $responseBody 1]
  set link [lindex $data 1]
  puts $link
  puts [dict size $data]
  http::cleanup $token

}  

tits:pub

#putlog ".:Loaded:. ignore.tcl - HackPat@Freenode"