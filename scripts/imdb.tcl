##############################################################################################
##  ##     imdb.tcl for eggdrop by Ford_Lawnmower irc.geekshed.net #Script-Help         ##  ##
##############################################################################################
## To use this script you must set channel flag +imdb (ie .chanset #chan +imdb)             ##
##############################################################################################
##############################################################################################
##  ##                             Start Setup.                                         ##  ##
##############################################################################################
## Change imdb_cmdchar to the character you want to use.                                    ##
set imdb_cmdchar "!"
## Change imdb_lang to the 2 digit language code you want to use                            ##
set imdb_lang "en"
proc imdb {nick host hand chan imdbsite imdburl} {
  if {[lsearch -exact [channel info $chan] +imdb] != -1} {
## Change the characters between the "" below to change the logo shown with each result.    ##
    set imdblogo "\002\00301,08IMDb\017"
## Change the format codes between the "" below to change the color/state of the text.      ##
    set imdbtext "\0034"
## Change the format codes between the "" below to change the color/state of the tags.      ##
    set imdbtags "\002"
## Change the format codes between the "" below to change the color/state of the links.     ##
    set imdblinks "\037\002"
## You may adjust how the results are printed by changing line1, line2 and line3            ##
## Valid items are as follows: cast language country genre director writer stars link title ##
## plot rating critic comment shortplot date duration votes title logo graph                ##
    set line1 "title"
    set line2 "shortplot rating link"
    set line3 ""
##############################################################################################
##  ##                           End Setup.                                              ## ##
############################################################################################## 
    if {[catch {set imdbSock [socket -async $imdbsite 80]} sockerr]} {
      putserv "PRIVMSG $chan :$imdbsite $imdburl $sockerr error"
      return 0
      } else {
      puts $imdbSock "GET $imdburl HTTP/1.0"
      puts $imdbSock "Host: $imdbsite"
      puts $imdbSock "User-Agent: Opera 9.6"
      puts $imdbSock ""
      flush $imdbSock
      set imdbtable 0
      set imdbtitle ""
      set imdbcast ""
      set imdblanguage ""
      set imdbcountry ""
      set imdbgenre ""
      set imdbdirector ""
      set imdbwriter ""
      set imdbstars ""
      set imdblink ""
      set imdbtitle ""
      set imdbplot ""
      set imdbrating ""
      set imdbcritic ""
      set imdbcomment ""
      set imdbshortplot ""
      set imdbdate ""
      set imdbduration ""
      set imdbvotes ""
      set imdbgraph ""
      while {![eof $imdbSock]} {
        set imdbvar " [gets $imdbSock] "
        if {[regexp {may refer to:} $imdbvar] || [regexp {HTTP\/1\.0 403} $imdbvar]} {
           putserv "PRIVMSG $chan :\002Nothing found on imdb! Please refine your search and check your spelling."
           close $imdbSock
           return 0
        } elseif {[string match "*<table class=*" $imdbvar]} {
          regexp {"(.*?)"} $imdbvar match imdbtable
        } elseif {[string match "*<h4 class=\"inline\">*</h4>*" $imdbvar]} {
          regexp {>(.*?)<\/h4>} $imdbvar match imdbtable
        } elseif {[string match "*Director:*" $imdbvar]} {
          set imdbtable "Director:"
        } elseif {[string match "*Writer:*" $imdbvar]} {
          set imdbtable "Writer:"
        } elseif {[string match "*<div class=\"star-box-giga-star\">*" $imdbvar]} {
          set imdbtable "Rating:"
        } elseif {[regexp {content="(http:\/\/www.imdb.com\/title\/.*\/)"} $imdbvar match imdblink]} {
          set imdblink [concat "\017${imdbtags}Link:\017" "${imdblinks}${imdblink}\015"]
        } elseif {[regexp {<title>([^<]*)\s-\sIMDb<\/title>} $imdbvar match imdbtitle]} {
          set imdbtitle [concat "\017${imdbtags}Title:\017${imdbtext}" [imdbdehex $imdbtitle]]
        } elseif {[string match "*<h2>Storyline</h2>*" $imdbvar]} {
          set imdbtable "plot:"
        } elseif {$imdbtable == "plot:" && [string match "*<p>*" $imdbvar]} {
          set imdbplot [concat "\017${imdbtags}Plot:\017${imdbtext}" [imdbdehex [imdbstrip $imdbvar]]]
          set imdbtable 0
        } elseif {$imdbtable == "Rating:"} {
          set imdbrating [imdbstrip $imdbvar]
          set imdbgraph "\017${imdbtags}\[${imdbtext}[string repeat "*" [imdbround $imdbrating]]\00314"
          set imdbgraph "${imdbgraph}[string repeat "*" [expr 10 - [imdbround $imdbrating]]]\017${imdbtags}\]\017"
          set imdbrating [concat "\017${imdbtags}Rating:\017${imdbtext}" $imdbrating]
          set imdbtable 0
        } elseif {$imdbtable == "cast_list"} {
          if {[regexp {\/name\/nm.*\/".*>(.*)<\/a>} $imdbvar match imdbcasttemp]} {
           set imdbcast [concat $imdbcast "," [imdbdehex $imdbcasttemp]]
         } elseif {[regexp {<div class=} $imdbvar]} {
           regexp {^\,(.*)} $imdbcast match imdbcast
           set imdbcast [concat "\017${imdbtags}Cast:\017${imdbtext}" $imdbcast]
           set imdbtable 0
         }
       } elseif {$imdbtable == "Language:"} {
         if {[regexp {>(.*?)<\/a>} $imdbvar match imdblanguagetemp]} {
           set imdblanguage [concat $imdblanguage "," [imdbdehex $imdblanguagetemp]]
         } elseif {[regexp {<div class=} $imdbvar]} {
           regexp {^\,(.*)} $imdblanguage match imdblanguage
           set imdblanguage [concat "\017${imdbtags}Language:\017${imdbtext}" $imdblanguage]
           set imdbtable 0
         }
       } elseif {$imdbtable == "Country:"} {
         if {[regexp {>(.*?)<\/a>} $imdbvar match imdbcountrytemp]} {
           set imdbcountry [concat $imdbcountry "," [imdbdehex $imdbcountrytemp]]
         } elseif {[regexp {<div class=} $imdbvar]} {
           regexp {^\,(.*)} $imdbcountry match imdbcountry
           set imdbcountry [concat "\017${imdbtags}Country:\017${imdbtext}" $imdbcountry]
           set imdbtable 0
         }
       } elseif {$imdbtable == "Genres:"} {
         if {[regexp {>(.*?)<\/a>} $imdbvar match imdbgenretemp]} {
           set imdbgenre [concat $imdbgenre "," [imdbdehex $imdbgenretemp]]
         } elseif {[regexp {<div class=} $imdbvar]} {
           regexp {^\,(.*)} $imdbgenre match imdbgenre
           set imdbgenre [concat "\017${imdbtags}Genre:\017${imdbtext}" $imdbgenre]
           set imdbtable 0
         }
       } elseif {$imdbtable == "Director:"} {
         if {[regexp {>(.*?)<\/a>} $imdbvar match imdbdirectortemp]} {
           set imdbdirector [concat $imdbdirector "," [imdbdehex $imdbdirectortemp]]
         } elseif {[regexp {<div class=} $imdbvar]} {
           regexp {^\,(.*)} $imdbdirector match imdbdirector
           set imdbdirector [concat "\017${imdbtags}Director:\017${imdbtext}" $imdbdirector]
           set imdbtable 0
         }
       } elseif {$imdbtable == "Writer:"} {
         if {[regexp {>(.*?)<\/a>} $imdbvar match imdbwritertemp]} {
           set imdbwriter [concat $imdbwriter "," [imdbdehex $imdbwritertemp]]
         } elseif {[regexp {<div class=} $imdbvar]} {
           regexp {^\,(.*)} $imdbwriter match imdbwriter
           set imdbwriter [concat "\017${imdbtags}Writer:\017${imdbtext}" $imdbwriter]
           set imdbtable 0
         }
       } elseif {$imdbtable == "Stars:"} {
         if {[regexp {>(.*?)<\/a>} $imdbvar match imdbstarstemp]} {
           set imdbstars [concat $imdbstars "," [imdbdehex $imdbstarstemp]]
         } elseif {[string match "*</div>*" $imdbvar]} {
           regexp {^\,(.*)} $imdbstars match imdbstars
           set imdbstars [concat "\017${imdbtags}Stars:\017${imdbtext}" $imdbstars]
           set imdbtable 0
         }
       } elseif {[regexp {<span\sitemprop="reviewCount">(.*)<\/span>\scritic<\/a>} $imdbvar match imdbcritic]} {
         set imdbcritic [concat "\017${imdbtags}Critics:\017${imdbtext}" [imdbdehex $imdbcritic]]
       } elseif {[regexp {<span\sitemprop="reviewCount">(.*)<\/span>\suser<\/a>} $imdbvar match imdbcomment]} {
         set imdbcomment [concat "\017${imdbtags}Comments:\017${imdbtext}" [imdbdehex $imdbcomment]]
       } elseif {[regexp {<meta name="description"\scontent="(.*?)"\s/>} $imdbvar match imdbshortplot]} {
         set imdbshortplot [concat "\017${imdbtags}Description:\017${imdbtext}" [imdbdehex $imdbshortplot]]
       } elseif {[regexp {<time itemprop="datePublished" datetime=".*">(.*)<\/time>} $imdbvar match imdbdate]} {
         set imdbdate [concat "\017${imdbtags}Published:\017${imdbtext}" [imdbdehex $imdbdate]]
       } elseif {$imdbtable == "Runtime:" && [regexp {<time itemprop="duration" datetime=".*">(.*)<\/time>} $imdbvar match imdbduration]} {
         set imdbduration [concat "\017${imdbtags}Runtime:\017${imdbtext}" [imdbdehex $imdbduration]]
         set imdbtable 0
       } elseif {[string match "*Aspect Ratio:*" $imdbvar] || [string match "*<!-- begin BOTTOM_AD -->*" $imdbvar]} {
         if {$line1 != ""} {
           imdbmsg $chan $imdblogo $imdbtext [subst [regsub -all -nocase {(\S+)} $line1 {$imdb\1}]]
         }
         if {$line2 != ""} {
           imdbmsg $chan $imdblogo $imdbtext [subst [regsub -all -nocase {(\S+)} $line2 {$imdb\1}]]
         }
         if {$line3 != ""} {
           imdbmsg $chan $imdblogo $imdbtext [subst [regsub -all -nocase {(\S+)} $line3 {$imdb\1}]]
         }
       } elseif {[regexp {<span itemprop="ratingCount">(.*?)<\/span>} $imdbvar match imdbvotes]} {
         set imdbvotes [concat "\017${imdbtags}Votes:\017${imdbtext}" $imdbvotes]
       }
     }
   }
     close $imdbSock
     return 0
 }
}
proc imdbround {num} {
 return [expr {round($num)}]
}
proc imdbmsg {chan logo textf text} {
 set text [imdbtextsplit $text 50]
 set counter 0
 while {$counter <= [llength $text]} {
   if {[lindex $text $counter] != ""} {
     putserv "PRIVMSG $chan :${logo} ${textf}[lindex $text $counter]"
   }
   incr counter
 }
}
proc googleimdbsearch {nick host hand chan search} {
 global imdb_lang
 if {[lsearch -exact [channel info $chan] +imdb] != -1} {
   set googleimdbsite "www.google.com"
   set googleimdbsearch [string map {{ } \%20} "${search}"]
   set googleimdburl "/search?q=${googleimdbsearch}+site:imdb.com&rls=${imdb_lang}&hl=${imdb_lang}"
   if {[catch {set googleimdbSock [socket -async $googleimdbsite 80]} sockerr]} {
     putserv "PRIVMSG $chan :$googleimdbsite $googleimdburl $sockerr error"
     return 0
   } else {
     puts $googleimdbSock "GET $googleimdburl HTTP/1.0"
     puts $googleimdbSock "Host: $googleimdbsite"
     puts $googleimdbSock "User-Agent: Opera 9.6"
     puts $googleimdbSock ""
     flush $googleimdbSock
     while {![eof $googleimdbSock]} {
       set googleimdbvar " [gets $googleimdbSock] "
        if {[regexp {<cite>(.*?)<\/cite>} $googleimdbvar match googleimdbresult]} {
         if {[regexp {imdb\.com} $googleimdbresult]} {
           set googleimdbresult [imdbstrip $googleimdbresult]
           regexp {(.*?)\/} $googleimdbresult match imdbsite
           regexp {\.com(.*)} $googleimdbresult match imdburl
           imdb $nick $host $hand $chan $imdbsite $imdburl
           close $googleimdbSock
            return 0
         }
        }
     }
     putserv "PRIVMSG $chan :\002Nothing found on imdb! Please refine your search and check your spelling."
     close $googleimdbSock
     return 0
   }
 }
}
proc imdbtextsplit {text limit} {
 set text [split $text " "]
 set tokens [llength $text]
 set start 0
 set return ""
 while {[llength [lrange $text $start $tokens]] > $limit} {
   incr tokens -1
   if {[llength [lrange $text $start $tokens]] <= $limit} {
     lappend return [join [lrange $text $start $tokens]]
     set start [expr $tokens + 1]
     set tokens [llength $text]
   }
 }
 lappend return [join [lrange $text $start $tokens]]
 return $return
}
proc imdbhex {decimal} { return [format %x $decimal] }
proc imdbdecimal {hex} { return [expr 0x$hex] }
proc imdbdehex {string} {
 regsub -all {^\{|\}$} $string "" string
 set string [subst [regsub -nocase -all {\&#x([0-9a-f]{1,3});} $string {[format %c [imdbdecimal \1]]}]]
 set string [subst [regsub -nocase -all {\&#([0-9]{1,3});} $string {[format %c \1]}]]
 set string [string map {&quot; \" &middot; · &amp; & <b> \002 </b> \002} $string]
 return $string
}
proc imdbstrip {string} {
 regsub -all {<[^<>]+>} $string "" string
 regsub -all {\[\d+\]} $string "" string
 return $string
}
bind pub - [string trimleft $imdb_cmdchar]imdb googleimdbsearch
setudef flag imdb
putlog "\002*Loaded* \002\00301,08IMDb\002\003 \002by Ford_Lawnmower irc.GeekShed.net #Script-Help"