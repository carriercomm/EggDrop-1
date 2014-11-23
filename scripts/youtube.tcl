##############################################################################################
##  ##     Youtube.tcl for eggdrop by Ford_Lawnmower irc.geekshed.net #Script-Help      ##  ##
##############################################################################################
## To use this script you must set channel flag +youtubeURL (ie .chanset #chan +youtubeURL) ##
##############################################################################################
package require tls
##############################################################################################
##  ##                             Start Setup.                                         ##  ##
##############################################################################################
proc youtubesurl {nick host hand chan text} {
  if {[lsearch -exact [channel info $chan] +youtubeURL] != -1} {
## Change the characters between the "" below to change the logo shown with each result.    ##
    set youtubelogo "\002\00301,00You\00300,04Tube\002\017"
## Change the format codes between the "" below to change the color/state of the text.      ##
    set textf "\002\017"
    set tagcolor "\002"
    set hostlang "en"
##############################################################################################
##  ##                           End Setup.                                              ## ##
##############################################################################################
    set youtubecheck [regexp -all -nocase {(?:\/watch\?v=|youtu\.be\/)([\d\w-]{11})} $text match youtubeid]
    if {$youtubeid != ""} {
      set youtubesite www.youtube.com
      set youtubeurl "/watch?v=${youtubeid}&hl=${hostlang}"
      set youtubeviews ""
      set youtubedesc ""
      set youtubeuser ""
      set youtubelikes ""
      set youtubedislikes ""
      set youtubedate ""
      set youtubefound ""
      set youtubeduration ""
      if {[catch {set youtubesock [tls::socket $youtubesite 443]} sockerr]} {
        putlog "$youtubesite $youtubeurl $sockerr error"
        return 0
      } else {
        puts $youtubesock "GET $youtubeurl HTTP/1.0"
        puts $youtubesock "Host: $youtubesite"
        puts $youtubesock ""
        flush $youtubesock
        while {![eof $youtubesock]} {
          set youtubevar " [gets $youtubesock] "
          if {[regexp -nocase {<title>(.*?)\s-\sYouTube<\/title>} $youtubevar match youtubedesc]} {
            set youtubedesc "${tagcolor}Title: ${textf}${youtubedesc}"
          } elseif {[regexp -nocase {\/user\/(.*?)">} $youtubevar match youtubeuser]} {
            set youtubeuser "${tagcolor}Uploader: ${textf}${youtubeuser}"
          } elseif {[regexp -nocase {<span class="yt-user-name[^>]*>([^<]*)<} $youtubevar match youtubeuser]} {
            set youtubeuser "${tagcolor}Uploader: ${textf}${youtubeuser}"
          } elseif {[regexp -nocase {watch-view-count"\s?>([^\x20]*)<} $youtubevar match youtubeviews]} {
            set youtubeviews "${tagcolor}Views: ${textf}${youtubeviews}"
          } elseif {[regexp -nocase {watch-like\s[^<>]+><[^<>]+><[^<>]+>([^<>\s]+)\s?<} $youtubevar match youtubelikes]} {
            set youtubelikes "${tagcolor}Likes: ${textf}${youtubelikes}"
          } elseif {[regexp -nocase {watch-like\s.+>([^<>]+)\s?<\/span><\/button>} $youtubevar match youtubelikes]} {
            set youtubelikes "${tagcolor}Likes: ${textf}${youtubelikes}"
          } elseif {[regexp -nocase {watch-time-text..(.*)<\/strong>} $youtubevar match youtubedate]} {
            set youtubedate "${tagcolor}Uploaded: ${textf}[string map -nocase {"uploaded on" ""} ${youtubedate}]"
            putserv "PRIVMSG $chan :[yturldehex "${youtubelogo} ${youtubedesc} ${youtubeviews} ${youtubelikes} ${youtubedislikes} ${youtubeuser} ${youtubedate} ${youtubeduration}"]"   
            close $youtubesock
            return 0
          } elseif {[regexp -nocase {watch-dislike\s[^<>]+><[^<>]+><[^<>]+>([^<>\s]+)\s?<} $youtubevar match youtubedislikes]} {
            set youtubedislikes "${tagcolor}Dislikes: ${textf}${youtubedislikes}"
          } elseif {[regexp -nocase {watch-dislike\s.+>([^<>]+)\s?<\/span><\/button>} $youtubevar match youtubedislikes]} {
            set youtubedislikes "${tagcolor}Dislikes: ${textf}${youtubedislikes}"
          } elseif {[regexp -nocase {\"duration\"\scontent\=\"([^"]+)\"} $youtubevar match youtubeduration]} {
            set youtubeduration "${tagcolor}Duration: ${textf}[string map {PT "" M " Minutes " S " Seconds "} $youtubeduration]"
          } elseif {[string match {*id="watch-uploader-info">*} $youtubevar]} {
            set youtubefound "found"
          } elseif {[regexp {<\/body>} $youtubevar 1] != 0} {
            close $youtubesock
            return 0
          } 
        }
        close $youtubesock
        return 0 
      }
    }
  }
}
proc yturldehex {string} {
  regsub -all {[\[\]]} $string "" string
  set string [subst [regsub -nocase -all {\&#([0-9]{2});} $string {[format %c \1]}]]
  return [encoding convertfrom utf-8 [string map {&quot; \" \xa0 "," &amp; \&} $string]]
}
proc yturlencode {instring} {
  return [subst [regsub -nocase -all {([^a-z0-9])} $instring {%[format %x [scan "\\&" %c]]}]]
}
bind pubm -|- "*youtube.*watch?v=*" youtubesurl
bind pubm -|- "*youtu.be/*" youtubesurl
setudef flag youtubeURL
putlog "\002*Loaded* \00301,00You\00300,04Tube\002\017 \002URL check V 00.05 by Ford_Lawnmower irc.GeekShed.net #Script-Help"