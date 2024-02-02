#check violation before route
# report_constraint -all
# max cap viloation => psynopt -only_design_rule
#==============================================
# Check Design and Report, after-CTS-pre-Route
# check violation before route
#==============================================
# report_timing 
check_zrt_routability  -error_view CHIP.err \
> [format %s%s%s $REPORT_PATH $design_name "_route_zroutability.rpt"] ; #if blockage on IO port, ignore it.
check_physical_design -stage pre_route_opt \
> [format %s%s%s $REPORT_PATH $design_name "_route_check.rpt"]
#==============================================
#Setting Routing Setting
#==============================================
set_route_zrt_common_options \
-post_detail_route_redundant_via_insertion high \
-concurrent_redundant_via_mode insert_at_high_cost \
-concurrent_redundant_via_effort_level high
#==============================================
#Detail Routing (1st Routing)
#==============================================
#Route all clk nets before others
route_zrt_group -all_clock_nets ;
## Route the signal net
## Global routing => Track assignment => Detail Routing automatically 
# route_zrt_auto -max_detail_route_iterations 100
route_zrt_auto
report_timing \
> [format %s%s%s $REPORT_PATH $design_name "_route_1st_timing.rpt"]

report_timing -delay_type min \
> [format %s%s%s $REPORT_PATH $design_name "_route_1st_hold_timing.rpt"]
#==============================================
# Detail Routing (2nd Routing) 
# if taiming performance is not acceptablem, run 2nd route.
# #==============================================
# set_fix_hold [all_clocks]
# set_host_options -max_cores 4
# route_opt -effort high -xtalk_reduction;
# route_opt -incremental ;
# #==============================================
# Verify Design and report (3rd Routing)
# Fix DRC violation
#==============================================
verify_zrt_route \
> [format %s%s%s $REPORT_PATH $design_name "_route_drc.rpt"];#find the location where DRC violation happened

route_zrt_detail -incremental true \
-initial_drc_from_input true ;  # -max_number_iterations 120 # fix DRC problem

#[2]
remove_route_by_type -signal_detail_route ;#delete routing 
route_opt -effort high ; #re-route
verify_zrt_route 

route_zrt_detail -incremental true \
-initial_drc_from_input true  \
-max_number_iterations 1000 ;# fix DRC problem

derive_pg_connection -power_net {VCC} -ground_net {GND} -power_pin {VCC} -ground_pin {GND}

#==============================================
# [1]
# If still have DRC problems, repeat the following command 
#==============================================
# verify_zrt_route > [format %s%s%s $REPORT_PATH $design_name "_route_drc.rpt"];
# route_zrt_detail -incremental true -initial_drc_from_input true  -max_number_iterations 1000 ;# fix DRC problem

#============================================== 
# [2]
# If DRC violation can not be solved after using route_zrt_detail
# Remove the detail route and re-route detail route
# route_opt will do GR,DR,search%repai,logic and placenebt opt
# ==============================================

# remove_route_by_type -signal_detail_route ;#delete routing 
# route_opt -effort high ; #re-route
# verify_zrt_route 
# route_zrt_detail -incremental true -initial_drc_from_input true  -max_number_iterations 1000 ;# fix DRC problem

#==============================================
# [3]
# re-route and blockages 
#==============================================
# create_routing_blockage -layers {metal2Blockage}  -bbox {{014.930 998.580} {1015.770 999.600}}


# remove_route_by_type -signal_detail_route -nets DUT/top_tcb_DUT/DUT_layer0/sub_1_root_sub_1_root_add_157_221_DIFF_13_ 

# remove_route_by_type -signal_detail_route -nets  DUT/top_tcb_DUT/DUT_layer0/sub_61_root_add_0_root_add_206/carry[13]

# route_eco -nets {DUT/top_tcb_DUT/DUT_layer0/sub_1_root_sub_1_root_add_157_221_DIFF_13_ \
# DUT/top_tcb_DUT/DUT_layer0/sub_61_root_add_0_root_add_206/carry[13]}

# RT-302
# route_eco -auto -search_repair_loop 5\
#          -utilize_dangling_wires -scope local\
#          -reroute modified_nets_first_then_others

# remove_routing_blockage {RB_11266049}
#==============================================
# The foundry does no provide Antenna rule, do not need to check Antenna violoation.
# Notice 
# 1.Open net must be 0
# 2.DRC violation must be 0
# Example:
#==============================================
# icc_shell:verify_zrt_route 
# Verify Summary:
# Total number of nets = 158854, of which 0 are not extracted
# Total number of open nets = 0, of which 0 are frozen    => has to be zero
# Total number of excluded ports = 0 ports of 0 unplaced cells connected to 0 nets
#                                  0 ports without pins of 0 cells connected to 0 nets
#                                  0 ports of 0 cover cells connected to 0 non-pg nets
# Total number of DRCs = 0 => has to be zero
# Total number of antenna violations = no antenna rules defined => do not check
# Total number of voltage-area violations = no voltage-areas defined
# Total number of tie to rail violations = not checked
# Total number of tie to rail directly violations = not checked
#==============================================
# report_timing 
verify_zrt_route > [format %s%s%s $REPORT_PATH $design_name "_route_drc_final.rpt"]
report_timing > [format %s%s%s $REPORT_PATH $design_name "_route_3rd_timing.rpt"]
report_timing -delay_type min > [format %s%s%s $REPORT_PATH $design_name "_route_3rd_min_timing.rpt"]
report_constraint -all > [format %s%s%s $REPORT_PATH $design_name "_route_con.rpt"]
report_design -physical > [format %s%s%s $REPORT_PATH $design_name "_route_physical.rpt"]
report_power > [format %s%s%s $REPORT_PATH $design_name "_route_power.rpt"]


derive_pg_connection -power_net {VCC} -ground_net {GND} -power_pin {VCC} -ground_pin {GND}
# # #==============================================
# # #Save Design
# # #==============================================
save_mw_cel  -design "CHIP.CEL;1"
save_mw_cel  -design "CHIP.CEL;1" -as "route"
