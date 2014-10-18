#Looks up random insults
bind pub - !pun pun
proc pun {nick host hand chan arg} {
  package require http
  set url "http://www.punoftheday.com/cgi-bin/randompun.pl"
  set page [http::data [http::geturl $url]]
  regsub -all {(?:\n|\t|\v|\r|\x01)} $page " " page
 	if {[regexp -nocase {<div class="dropshadow1">(.*?)</div>} $page " " pun]} {
		regsub -nocase -- {<p>(.*?)</p>} $pun "\\1" pun
		regsub {^[\ ]*} $pun "" pun
		regsub {[\ ]*$} $pun "" pun
		putserv "PRIVMSG $chan :$pun"
	}
}

putlog "Insulterrrrrrr HackPat @ FreeNode"