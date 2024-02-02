set REPORT_PATH "./report/"
#==============================================
#Create physical I/O cell
#==============================================
source ../scripts/create_phy_cell.tcl
read_pin_pad_physical_constraints ../design_data/io.tdf ;#Read Top Design File, Specify pad cell location
#==============================================
##Initialize the floorplan, Create Course Placement
#==============================================
# create_floorplan -flip_first_row -left_io2core 90 -bottom_io2core 90 -right_io2core 90 -top_io2core 90
create_floorplan -core_utilization 0.1 \
-flip_first_row -left_io2core 90 -bottom_io2core 90 -right_io2core 90 -top_io2core 90
insert_pad_filler -cell {EMPTY16C EMPTY8C EMPTY4C EMPTY2C EMPTY1C} \
-overlap_cell {EMPTY1C} ;#Insert pad filer cells
save_mw_cel  -design $design_name
save_mw_cel  -design $design_name -as "die_init"
##Initialize the floorplan, Create Course Placement
#==============================================
# Run Incremental Timing/Congestion Driven Placement
# Choose one of than, don not select both at same time
#==============================================
# create_fp_placement -timing_driven -incremental all
create_fp_placement -congestion -incremental all
#==============================================
# Report COngestion
#==============================================
report_congestion -grc_based -routing_stage global > \
[format %s%s%s $REPORT_PATH $design_name "_design_plan_1st_congestion.rpt"];##Check Congestion ,Global Route Congestion

save_mw_cel  -design $design_name
save_mw_cel  -design $design_name -as "Before_PNS"
#==============================================
##Power Network Synthesis (PNS) setting
#==============================================
derive_pg_connection -power_net {VCC} -ground_net {GND} -power_pin {VCC} -ground_pin {GND} ;#Connect P/G nets before Running PNS/PNA
#Strap
set_fp_rail_constraints -add_layer  -layer metal3 -direction horizontal -max_strap 20 -min_strap 10 -max_width 8 -min_width 8 -spacing minimum
set_fp_rail_constraints -add_layer  -layer metal2 -direction vertical -max_strap 20 -min_strap 10 -max_width 8 -min_width 8 -spacing minimum
#Ring
set_fp_rail_constraints  -set_ring -nets  {VCC GND VCC GND VCC GND}  -horizontal_ring_layer { metal3 } -vertical_ring_layer { metal2 } -ring_width 8 -ring_spacing 3 -extend_strap core_ring

set_fp_rail_constraints -set_global   -no_routing_over_hard_macros
synthesize_fp_rail  -nets {VCC GND} -voltage_supply 1.8 -synthesize_power_plan -power_budget 80
#
commit_fp_rail


set_preroute_drc_strategy -use_fat_via -min_layer metal1 -max_layer metal6
#physically Connect Cells to PG Ring
preroute_instances  -ignore_macros -ignore_cover_cells -primary_routing_layer pin -extend_for_multiple_connections -extension_gap 10
#create Standard cell Rails
preroute_standard_cells -extend_for_multiple_connections  -extension_gap 16 -connect horizontal  -skip_pad_pins  -remove_floating_pieces  -do_not_route_over_macros  -fill_empty_rows  -port_filter_mode off -cell_master_filter_mode off -cell_instance_filter_mode off -voltage_area_filter_mode off -route_type {P/G Std. Cell Pin Conn}
#==============================================
#Analyze IR drops
#==============================================
#PNA
# analyze_fp_rail  -nets {VCC GND} -power_budget 80 -voltage_supply 1.8
#if IR Drop is not acceotable
#close_mw_cel
#open_mw_cel_ Before_PNS

#==============================================
#Apply pnet options, -complete : strap will NOT blockage the std cell; -partial partially blockage
#==============================================
set_pnet_options -complete "metal2 metal3"
# create_fp_placement -incremental all ;#?
#==============================================
#Save Design
#==============================================
save_mw_cel  -design $design_name
save_mw_cel  -design $design_name -as "design_planning"
