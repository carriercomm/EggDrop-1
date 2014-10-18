#Looks up random insults
bind pub - !commit commit
proc commit {nick host hand chan arg} {
  package require http
  set url "http://whatthecommit.com"
  set page [http::data [http::geturl $url]]
  regsub -all {(?:\n|\t|\v|\r|\x01)} $page " " page
  if {[regexp -nocase {<div id="content">(.*?)</div>} $page " " commit]} {
  	regsub -nocase -- {<p>(.*?)</p><p class="permalink">} $commit "\\1" commit
  	putserv "PRIVMSG $chan :$commit"
  }
}

putlog "Random commit v1.0"