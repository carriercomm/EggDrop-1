bind pub - !nopelol notsafeforwork

proc notsafeforwork {nick host hand chan arg} {
 set customtext "\002Please tag all not safe for work images, texts and websites. Not doing so will earn you a kick"
 putserv "PRIVMSG $chan :$customtext"
}
##putlog "nsfw.tcl v1.0 by npocmak: LOADED"