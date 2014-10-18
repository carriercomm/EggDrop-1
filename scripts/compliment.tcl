#Looks up random insults
bind pub - !compliment compliment
proc compliment {nick host hand chan arg} {
	set fp [open "scripts/compliments.txt" r]
    set file_data [read $fp]
    close $fp
    set data [split $file_data "\n"]
    set limit [llength $data]
    set rand [random_int $limit]
    set compliments [lindex $data $rand]
	if {$arg == ""} {
		putserv "PRIVMSG $chan :$compliments"
	} else {
		putserv "PRIVMSG $chan :$arg, $compliments"
	}
}
proc random_int { upper_limit } { 
    global myrand 
    set myrand [expr int(rand() * $upper_limit + 1)] 
    return $myrand 
} 
putlog "compliment HackPat @ FreeNode"