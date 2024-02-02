check_physical_design -stage pre_clock_opt \
> [format %s%s%s $REPORT_PATH $design_name "_cts_check_physical.rpt"]
report_constraint -all \
> [format %s%s%s $REPORT_PATH $design_name "_cts_1st_constraint.rpt"]
#Before CTS, the following requirements must be met:
#1.P/G net prerouted
#2.Placemnt is completed
#3.Estimated congestion is acceptable
#4.Estimated timing is acceptable ~0 ~ -0.01
#5.Estimated max cap/transition no violation
#6.High fanout nets : reset,clk,scan chain cell


set_fix_hold [all_clocks]
report_timing > [format %s%s%s $REPORT_PATH $design_name "_cts_1st_timing.rpt"]
clock_opt  -fix_hold_all_clocks -no_clock_route 

# clock_opt -fix_hold_all_clocks -congestion -no_clock_route ; # -operating_condition min : use this when hold time violation can not be removed , -congestion
# clock_opt -only_psyn -fix_hold_all_clocks -congestion -no_clock_route
# optimize_clock_tree -buffer_sizing -buffer_relocation -gate_sizing -gate_relocation -delay_insertion -search_repair_loop 2 -operating_condition max -routed_clock_stage None
report_timing 
> [format %s%s%s $REPORT_PATH $design_name "_cts_2nd_timing.rpt"]
report_timing -delay_type min 
> [format %s%s%s $REPORT_PATH $design_name "_cts_2nd_timing_min.rpt"]
derive_pg_connection -power_net {VCC} -ground_net {GND} -power_pin {VCC} -ground_pin {GND}
report_clock_tree -summary > [format %s%s%s $REPORT_PATH $design_name "_cts_clk_tree.rpt"]
#==============================================
#Save Design
#==============================================
save_mw_cel  -design $design_name
save_mw_cel  -design $design_name -as "cts"
