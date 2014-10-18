# bMotion: admin plugin file for friendship mangement
#
# $Id: admin_friendship.tcl 862 2007-09-30 16:47:24Z james $
#

###############################################################################
# This is a bMotion plugin
# Copyright (C) James Michael Seward 2000-2002
#
# This program is covered by the GPL, please refer the to LICENCE file in the
# distribution; further information can be found in the headers of the scripts
# in the modules directory.
###############################################################################


### management version


proc bMotion_plugin_management_friends { handle { arg "" } } {

	if [regexp -nocase {show (.+)} $arg matches nick] {
		if {$nick == "all"} {
			bMotion_putadmin [getFriendsList]
			return 0
		}
		bMotion_putadmin "Friendship rating for $nick is [getFriendshipHandle $nick]%"
		return 0
	}

  if [regexp -nocase {set ([^ ]+) ([0-9]+)} $arg matches nick val] {
     setFriendshipHandle $nick $val
     bMotion_putadmin "Friendship rating for $nick is now [getFriendshipHandle $nick]%"
		return 0
  }
  
  bMotion_putadmin "usage: friendship \[show|set\]"
}

bMotion_plugin_add_management "friends" "^friends?(hip)?"  n       bMotion_plugin_management_friends "any"
