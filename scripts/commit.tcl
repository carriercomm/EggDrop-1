#Looks up random insults
bind pub - !commit commit
proc commit {nick host hand chan arg} {
  package require http
  set url "http://whatthecommit.com"
  set page [http::data [http::geturl $url]]
  regsub -all {(?:\n|\t|\v|\r|\x01)} $page " " page
  if {[regexp -nocase {<div id="content">(.*?)</div>} $page " " commit]} {
  	regsub -nocase -- {<p class="permalink">(.*?)</p>} $commit "\\1" url
  	regsub -nocase -- {<p>(.*?)</p>} $url "" url
  	regsub -nocase -- {<p>(.*?)</p>} $commit "\\1" commit
  	regsub -nocase -- {<p.*?>(.*?)</p>} $commit "\\1" commit
  	regsub -nocase -- {<a href=(.*?)></a>} $url "\\1" url
  	regsub -nocase -- {<a href="(.*?)">permalink</a>} $url "\\1" url
  	regsub -nocase -- {<a.*?>(.*?)</a>} $commit "" commit
  	regsub -nocase -- {\[\]} $commit "" commit
  	regsub -nocase -- {\[(.*?)\]} $url "\\1" url
  	regsub {^[\ ]*} $url "" url
  	regsub {[\ ]*$} $url "" url
  	regsub {^[\ ]*} $commit "" commit
  	regsub {[\ ]*$} $commit "" commit
  	putserv "PRIVMSG $chan :$commit - http://whatthecommit.com$url"
  }
}

putlog "Random commit v1.0"