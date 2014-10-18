#Looks up random insults
bind pub - !commit
proc commit {nick host hand chan arg} {

  package require http
  set url "http://whatthecommit.com/"
  set page [http::data [http::geturl $url]]
  regexp {<p>(.*?)<\/p>} $page commit
  putserv "PRIVMSG $chan :$commit "
}

putlog "Random commit v1.0"