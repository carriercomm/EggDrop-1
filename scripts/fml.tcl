##############################################################################################
##  ##     fml.tcl for eggdrop by Ford_Lawnmower irc.geekshed.net #Script-Help          ##  ##
##############################################################################################
## To use this script you must set channel flag +fml (ie .chanset #chan +fml)               ##
##############################################################################################
##############################################################################################
##  ##                             Start Setup.                                         ##  ##
##############################################################################################
## Change fml_cmdchar to the character you want to use.                                     ##
set fml_cmdchar "!"
proc fml {nick host hand chan args} {
  if {[lsearch -exact [channel info $chan] +fml] != -1} {
## Change the characters between the "" below to change the logo shown with each result.    ##
    set fmllogo "\002\00301,11-FML-\002\003"
## Change the format codes between the "" below to change the color/state of the text.      ##
    set textf "\0034"
##############################################################################################
##  ##                           End Setup.                                              ## ##
##############################################################################################	
    set fmlsite "www.fmylife.com"
    set fmlurl "/random"
    if {[catch {set fmlSock [socket -async $fmlsite 80]} sockerr]} {
      putserv "PRIVMSG $chan :$fmlsite $fmlurl $sockerr error"
      return 0
      } else {
      puts $fmlSock "GET $fmlurl HTTP/1.0"
      puts $fmlSock "Host: $fmlsite"
      puts $fmlSock ""
      flush $fmlSock
      while {![eof $fmlSock]} {
        set fmlvar " [gets $fmlSock] "
		if {[regexp {(Today.*?)FML<\/a>} $fmlvar match fmlresult]} {
          putserv "PRIVMSG $chan :${textf}[fmldehex [fmlstrip $fmlresult]] ${fmllogo}"
		  close $fmlSock
		  return 0
		}
      }
      close $fmlSock
      return 0 
    }
  }
}
proc fmlstrip {string} {
  regsub -all {<[^<>]+>} $string "" string
  return $string
}
proc fmldehex {string} {
  regsub -all {[\[\]]} $string "" string
  set string [subst [regsub -nocase -all {\&#([0-9]{2});} $string {[format %c \1]}]]
  return [string map {&quot; \"} $string]
}
bind pub - [string trimleft $fml_cmdchar]fml fml
setudef flag fml
putlog "\002*Loaded* \002\00301,11-FML-\002\003 \002Random by Ford_Lawnmower irc.GeekShed.net #Script-Help"