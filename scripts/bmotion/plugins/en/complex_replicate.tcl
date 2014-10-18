## bMotion: replicate plugin
#
# $Id: complex_replicate.tcl 860 2007-09-24 12:52:08Z james $
#
# vim: fdm=indent fdn=1

###############################################################################
# This is a bMotion plugin
# Copyright (C) James Michael Seward 2000-2002
#
# This program is covered by the GPL, please refer the to LICENCE file in the
# distribution; further information can be found in the headers of the scripts
# in the modules directory.
###############################################################################

bMotion_plugin_add_complex "replicate" "^%botnicks:?,? (please )?(replicate|create|send|make) (.+?\[^?\])$" 100 bMotion_plugin_complex_replicate "en"
bMotion_plugin_add_complex "replicate2" "^%botnicks:?,? (please )?(replicate|create|send|make) (.+) (for|to) (.+)" 100 bMotion_plugin_complex_replicate2 "en"

proc bMotion_plugin_complex_replicate { nick host handle channel text } {
  global botnicks

  regexp -nocase "^${botnicks}:?,? (please )?(replicate|create|send|make) (.+)" $text matches bot please action details

  #make it so
  if [regexp -nocase "^it so$" $details] { 
    bMotionDoAction $channel $nick "/makes it so for %%"
    bMotion_plugins_settings_set "system" "lastdonefor" $channel "" $nick
    return 1
  }

  # make it something
  if [regexp -nocase "^it (.+)$" $details ming details2] {
    bMotionDoAction $channel $nick "/makes it $details2 for %%"
    bMotion_plugins_settings_set "system" "lastdonefor" $channel "" $nick
    return 1
  }

  # actually replicate
  set who [string trim [string range $details 0 [string first " " $details]]]
  set item [string range $details [expr [string first " " $details] + 1] [string length $details]]
  set whom ""
  if {$who == ""} {
    bMotionDoAction $channel $nick "Idiot. Try pressing Alt-F4 for help, %%"
    return 1
  }
  if {$who == "me"} { set whom $nick }
  if {[regexp -nocase "(yourself|you)" $who]} { set whom [getPronoun] }
  if {$whom == ""} { set whom $who }
  if {[string tolower $action] == "make"} {
    if {($whom == [getPronoun]) && [regexp -nocase "(come|cum|ejaculate|squirt)" $item]} {
      cum $channel $nick
      return 1
    }
    if {[rand 4] == 0 || [regexp -nocase "into" $item]} {
      set whom "$whom is"
      if {$who == "me"} { set whom "you are" }
      if {[regexp -nocase "(yourself|you)" $who]} { set whom "I am" }
      if [regexp -nocase "into" $item] {
        set item [string range $item [expr [string first "into" $item] + 5] end]
      }
      set hisHers [getHisHers]
      bMotionDoAction $channel $hisHers "%VAR{wands}"
      bMotionDoAction $channel $whom "*PING* ... %% $item"
      if [rand 2] { bMotionDoAction $channel $whom "I AM THE WIZARD%colen" }
      bMotionGetHappy
      bMotionGetUnLonely
      bMotion_putloglev d * "bMotion: Turned someone into $item :P"
      return 1
    }
  }
  bMotionDoAction $channel $whom "/replicates $item and hands it to %%"
  bMotionGetUnLonely
  bMotion_plugins_settings_set "system" "lastdonefor" $channel "" $nick
  return 1
}


proc bMotion_plugin_complex_replicate2 { nick host handle channel text } {
  global botnicks botnick
  regexp -nocase "^${botnicks}:?,? (please )?(replicate|create|send|make) (.+?)( for| to) (.+)" $text matches bot please action details f who

  bMotion_plugin_complex_replicate $nick $host $handle $channel "$botnick $action $who $details"
  return 1
}
