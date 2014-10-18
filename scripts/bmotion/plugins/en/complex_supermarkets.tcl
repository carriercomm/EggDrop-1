##bMotion plugin: supermarkets
#
# $Id: complex_supermarkets.tcl 794 2007-06-23 21:12:05Z james $
#

###############################################################################
# This is a bMotion plugin
# Copyright (C) James Michael Seward 2000-2002
#
# This program is covered by the GPL, please refer the to LICENCE file in the
# distribution; further information can be found in the headers of the scripts
# in the modules directory.
###############################################################################

bMotion_plugin_add_complex "supermarkets" {\m(sainsbury\'s|sainsburys|safeway|aldi|asda|walmart|wal-mart|wal mart|somerfield|lidl|co-op|budgens|cws|kiwk-save|kwiksave|kwik save|budgens|iceland|circle k|k-mart|7-11|costcutter|costco|marks and spencers|m&s|marks and sparks|mace-line)\M} 40 bMotion_plugin_complex_supermarket "en"

proc bMotion_plugin_complex_supermarket { nick host handle channel text } {
  if {![bMotion_interbot_me_next $channel]} { return 1 }
  if [regexp -nocase {\m(sainsbury\'s|sainsburys|safeway|aldi|asda|walmart|wal-mart|wal mart|somerfield|lidl|co-op|budgens|cws|kiwk-save|kwiksave|kwik save|budgens|iceland|circle k|k-mart|7-11|costcutter|costco|marks and spencers|m&s|marks and sparks|mace-line)\M} $text matches where ] {
    bMotionDoAction $channel $where "%VAR{insultsupermarket}"
    driftFriendship $nick -1
		return 1
  }
}
