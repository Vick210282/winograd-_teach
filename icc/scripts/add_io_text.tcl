#############################################################################################
# Description: The purpose of the script is to provide same automation as dbAddIOText command 
# which was present in Astro.
#
# This script takes three inputs. 
# First input  --- layer name on which text has to created.
# second input --- height of text
# third input  --- type of text that has to be created on IO's.  
#
# Third input can be of three types as shown below:
#	1. cellInstName
#	2. netName
#       3. portName
#
# If cellInstName is given as third input then texts will be created with Instance names.If 
# netName is given as third input then texts will be created with net names. If portName is 
# given as third input then texts will be created with port names.
#
#
# Author: kapilr@synopsys.com 
##############################################################################################
#
# usage:
# icc_shell> source add_io_text.tcl
# icc_shell> add_io_text METAL 20 portName
#
##############################################################################################


#-hier

proc add_io_text {layernam h texttype} {

  
set num [get_cells -hier -filter "is_io == TRUE &&  ref_name != VCC3IOC && ref_name != VCC3IOD && ref_name != VCCKC && ref_name != VCCKD && ref_name != GNDIOC && ref_name != GNDIOD && ref_name != GNDKC && ref_name != GNDKD" ]
foreach_in_collection z $num {
set box [get_attr $z bbox]
set distance 115.7
set x1 [lindex [lindex $box 0] 0]
set y1 [lindex [lindex $box 0] 1]
set x2 [lindex [lindex $box 1] 0]
set y2 [lindex [lindex $box 1] 1]
set px [expr [expr $x1+$x2]/2]
set py [expr [expr $y1+$y2]/2]
if {[string equal cellInstName $texttype]} {
if {[string equal S [get_attribute [get_attribute $z full_name] orientation]]} {
create_text -height $h -orient W -layer $layernam -origin [list $px [expr $py+$distance]] [get_attribute $z full_name]
} elseif {[string equal N [get_attribute [get_attribute $z full_name] orientation]]} {
create_text -height $h -orient W -layer $layernam -origin [list $px [expr $py-$distance]] [get_attribute $z full_name]
} elseif {[string equal E [get_attribute [get_attribute $z full_name] orientation]]} {
create_text -height $h -layer $layernam -origin [list [expr $px-$distance] $py] [get_attribute $z full_name]
} else {
create_text -height $h -layer $layernam -origin [list [expr $px+$distance] $py] [get_attribute $z full_name]
}
} 


if {[string equal netName $texttype]} {
set tot [get_ports]
foreach_in_collection i $tot {
set t [get_pins -of [get_attribute $z full_name]]
foreach_in_collection j $t {
set test1 [get_attribute -quiet [all_connected $j] full_name]
# echo "$test1"
set test2 [get_attribute $i full_name]
# echo "$test2"
if {[string equal $test2 $test1]} {
set str $test2
}
}
}


if {[string equal S [get_attribute [get_attribute $z full_name] orientation]]} {
create_text -height $h -orient W -layer $layernam -origin [list $px $py] $str
} elseif {[string equal N [get_attribute [get_attribute $z full_name] orientation]]} {
create_text -height $h -orient W -layer $layernam -origin [list $px $py] $str
} else {
create_text -height $h -layer $layernam -origin [list $px $py] $str
}
}

if {[string equal portName $texttype]} {
set tot [get_ports]
foreach_in_collection i $tot {
set t [get_pins -of [get_attribute $z full_name]]
foreach_in_collection j $t {
set test1 [get_attribute -quiet [all_connected $j] full_name]
# echo "$test1"
set test2 [get_attribute $i full_name]
# echo "$test2"
if {[string equal $test2 $test1]} {
set str $test2
}
}
}


if {[string equal S [get_attribute [get_attribute $z full_name] orientation]]} {
create_text -height $h -orient N -layer $layernam -origin [list $px [expr $py+$distance]] $str
} elseif {[string equal N [get_attribute [get_attribute $z full_name] orientation]]} {
create_text -height $h -orient N -layer $layernam -origin [list $px [expr $py-$distance]] $str
} elseif {[string equal E [get_attribute [get_attribute $z full_name] orientation]]} {
create_text -height $h -orient N -layer $layernam -origin [list [expr $px-$distance] $py] $str
} else {
create_text -height $h -layer $layernam -origin [list [expr $px+$distance] $py] $str
}
}

}
}

