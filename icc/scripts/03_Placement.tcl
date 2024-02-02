
set REPORT_PATH "./report/"
#==============================================
#Start with a Good design Setup
#==============================================
check_physical_design -stage pre_place_opt > \
[format %s%s%s $REPORT_PATH $design_name "_placement_1st_check_phy_design.rpt"]
check_physical_constraints > \
[format %s%s%s $REPORT_PATH $design_name "_placement_phy_constraint.rpt"]
#No DFT in TCBNN
#read_def  "../design_data/MAC_scan_dft.def"
#==============================================
#Dealing with Congestion before Continue
# Error: report_congestion failed because some cells do not have legal placement. (PSYN-972)
# => legalize_placement 
#==============================================
legalize_placement 
report_congestion -grc_based -routing_stage global > \
[format %s%s%s $REPORT_PATH $design_name "_placement_1st_congestion.rpt"]
#PYNS-545 legalize_placement 
#It is important to minimize or eliminate congestion before continuing
#======================================================================
# Report the setting for high fanout synthesis
#======================================================================
report_ahfs_options > \
[format "%s%s%s" $REPORT_PATH $design_name "_placement_ahfs_options.rpt"]
all_high_fanout -nets  > \
[format "%s%s%s" $REPORT_PATH $design_name "_placement_ahfs_net.rpt"]
# enable constant Net buffering
set_auto_disable_drc_nets -constant false
#==============================================
#check timing
#==============================================
# read_sdc  -version Latest $sdc_file_loaction ;#UID-341 can be ignored
#==============================================
# check if timing slack is greater than 0
# You should DEFINITELY meet timing after using Zero interconnect(ZIC) delay mode
# If not, go back to previous step, fix timing issue before continue
# before starting placement, it is important to ensure that the design is not over-constrianed
#==============================================
set_zero_interconnect_delay_mode true ; #only compute cell delay
report_timing > \
[format %s%s%s $REPORT_PATH $design_name "_placement_zero_delay_true_timing.rpt"]
set_zero_interconnect_delay_mode false ; 
report_timing > \
[format %s%s%s $REPORT_PATH $design_name "_placement_zero_delay_false_timing.rpt"]
#==============================================
#IF Timing failed
#psynopt ;# Fix timing violation
#==============================================


#==============================================
#Placement
#==============================================
# add tile cell will show a lot of warning, which is fine.
source ../scripts/add_tie.tcl ;#Add tie cell 
place_opt -high
# place_opt -congestion
derive_pg_connection -power_net {VCC} -ground_net {GND} -power_pin {VCC} -ground_pin {GND}

#==============================================
#Placement -minimun QoR impact
#==============================================
# refine_placement -congestion_effoet medium
# set_fix_hold [all_clocks]
# psynopt -congestion; # -congestion

#==============================================
#Placement -\Best congestion removal
#==============================================
# refine_placement -perturbation_level high
# psynopt
# derive_pg_connection -power_net {VCC} -ground_net {GND} -power_pin {VCC} -ground_pin {GND}

#==============================================
# Fix constrints after placement
#==============================================
# max cap/tran viloation => psynopt -only_design_rule
# psynopt -only_design_rule

report_constraint -all \
> [format %s%s%s $REPORT_PATH $design_name "_placement_constraint.rpt"]
psynopt ; # deal with constraint
psynopt -only_design_rule ;#max cap, max tran


report_timing > [format %s%s%s $REPORT_PATH $design_name "_placement_timing.rpt"]
report_power > [format %s%s%s $REPORT_PATH $design_name "_placement_power.rpt"]
report_congestion -grc_based -routing_stage global \
> [format %s%s%s $REPORT_PATH $design_name "_placement_2nd_congestion.rpt"]
#==============================================
#Save Design
#==============================================
save_mw_cel  -design $design_name
save_mw_cel  -design $design_name -as "placement"

