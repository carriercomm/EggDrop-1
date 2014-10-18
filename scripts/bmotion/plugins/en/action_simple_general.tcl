# bMotion simple action plugins
#
# $Id: action_simple_general.tcl 439 2004-03-17 20:36:24Z jamesoff $
#

###############################################################################
# This is a bMotion plugin
# Copyright (C) James Michael Seward 2000-2002
#
# This program is covered by the GPL, please refer the to LICENCE file in the
# distribution; further information can be found in the headers of the scripts
# in the modules directory.
###############################################################################

#                         name  regexp            %   responses
#bMotion_plugin_add_action_simple "licks" "(licks|bites) %botnicks" 100 [list "%VAR{rarrs}"]
bMotion_plugin_add_action_simple "moo" "^(goes |does a )?moo+s?( at %botnicks)?" 40 [list "%VAR{moos}"] "en"

