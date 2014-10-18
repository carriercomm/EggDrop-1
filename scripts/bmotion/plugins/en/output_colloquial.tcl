## bMotion output plugin: colloquial
#
# $Id: output_colloquial.tcl 803 2007-06-23 23:00:04Z james $
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

bMotion_plugin_add_output "colloq" bMotion_plugin_output_colloq 1 "en"


#    Attempt to make contractions etc similar to real people
#
proc bMotion_plugin_output_colloq { channel line } {
  global bMotionSettings

  set colloq_rate $bMotionSettings(colloq)
  set oldLine $line

  if [bMotion_plugin_output_colloq_chance $colloq_rate] {
    regsub -all -nocase "\mshould( have|\'ve| of)\M" $line "%VAR{colloq_shouldhave}" line
  }

  if [bMotion_plugin_output_colloq_chance $colloq_rate] {
    regsub -all -nocase "\mshouldn't( have|\'ve| of)\M" $line "%VAR{colloq_shouldhavenot}" line
  }

  if [bMotion_plugin_output_colloq_chance $colloq_rate] {
    regsub -all -nocase "sort of" $line "sorta" line
    regsub -all -nocase "something" $line "sommat" line
  }

  if [bMotion_plugin_output_colloq_chance $colloq_rate] {
    regsub -all -nocase "cheap" $line "cheep" line
    regsub -all -nocase "seam" $line "seem" line
    regsub -all -nocase "mean" $line "meen" line
  }

  if [bMotion_plugin_output_colloq_chance $colloq_rate] {
    regsub -all -nocase "exactly" $line "exactily" line
    regsub -all -nocase "separate" $line "seperate" line
    regsub -all -nocase "definitely" $line "definately" line
  }

  if [bMotion_plugin_output_colloq_chance $colloq_rate] {
    regsub -all -nocase {\myou\M} $line "%VAR{colloq_you}" line
    regsub -all -nocase {\myour\M} $line "%VAR{colloq_your}" line
  }

  if [bMotion_plugin_output_colloq_chance $colloq_rate] {
    regsub -all -nocase "n't" $line "nt" line
  }

  if [bMotion_plugin_output_colloq_chance $colloq_rate] {
    if {![regexp "\.$" $line]} {
      append line "."
    }
  }

  #let's break some words
  global colloq_negative
  set newLine ""
  set words [split $line { }]
  foreach word $words {
    if {[bMotion_plugin_output_colloq_chance $colloq_rate]} {
      regsub -nocase {\m(dis|anti|un|im)} $word [pickRandom $colloq_negative] word
    }
    append newLine "$word "
  }
  set line $newLine

  #don't waste time updating if the line didn't change
  if {$line == $oldLine} {
    return $oldLine
  }

  return [string trim [bMotionDoInterpolation $line "" ""]]
}

#random chance test
proc bMotion_plugin_output_colloq_chance { freq } {
  if {[rand 1000] <= $freq} {
    return 1
  }
  return 0
}

set colloq_shouldhave {
  "should've"
  "should of"
}

set colloq_shouldhavenot {
  "shouldnt've"
  "shouldn't of"
  "shouldnt of"
  "shouldnt have"
}

set colloq_you {
  "u"
  "ya"
}

set colloq_your {
  "ur"
}

set colloq_negative {
  "dis"
  "un"
  "anti"
  "im"
}
