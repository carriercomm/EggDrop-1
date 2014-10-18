## bMotion: correct common english errors by other people
#
# $Id: complex_correct.tcl 753 2007-01-02 22:27:32Z james $
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

bMotion_plugin_add_complex "correct-of" "(must|should) of" 30 bMotion_plugin_complex_correct "en"

proc bMotion_plugin_complex_correct { nick host handle channel text } {
  #if {![bMotion_interbot_me_next $channel]} { return 0 }

  if [regexp -nocase "(must|should) of" $text matches nnk] {
    bMotionDoAction $channel $nnk "%VAR{shouldhaves}"
    return 1
  }
}

bMotion_abstract_register "shouldhaves"
bMotion_abstract_batchadd "shouldhaves" {
  "\"%% have\" %VAR{smiles}"
  "%% what?"
  "%% HAVE, %% HAVE"
  "s/of/have/"
}
