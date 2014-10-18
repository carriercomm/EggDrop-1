#Looks up random insults
bind pub - !commit
proc commit {nick host hand chan arg} {

  package require http
  set url "http://whatthecommit.com/"
  set page [http::data [http::geturl $url]]
  if {[regexp -nocase {<div id="content">(.*?)</div>} $page commit]} {
  	regsub -nocase -- {<p>(.*?)</p>} $commit "\\1" commit
  	putserv "PRIVMSG $chan :$commit"
  }
}

putlog "Random commit v1.0"