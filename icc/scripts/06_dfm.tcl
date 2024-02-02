#==============================================
# Add core filler to unify the deisify of Chip for better yield
#==============================================
source ../scripts/addCoreFiller.cmd
#==============================================
# dealing with DRC vioation
#==============================================
# verify_zrt_route 
# route_zrt_detail -incremental true -initial_drc_from_input true ;



#==============================================
# Add IO text 
#==============================================
source ../scripts/add_io_text.tcl
add_io_text m3text 5 portName ;# automatically add all signal Pad (no including Power Pad)
#==============================================
# Remeber to add Power Pad by yourself :
# Add text on Core Power
# gui_set_mouse_tool_option -tool CreateTextTool -option {text} -value {VCC}
# gui_set_mouse_tool_option -tool CreateTextTool -option {height} -value {10}
# gui_mouse_tool -window [gui_get_current_window -types Layout -mru] -add_point {1138.330 3715.440} -scale 0.1982
# gui_set_mouse_tool_option -tool CreateTextTool -option {text} -value {GND}
# gui_mouse_tool -window [gui_get_current_window -types Layout -mru] -add_point {1138.330 3705.720} -scale 0.1982
# gui_set_mouse_tool_option -tool CreateTextTool -option {text} -value {IOVCC}
# gui_mouse_tool -window [gui_get_current_window -types Layout -mru] -add_point {2.150 492.130} -scale 0.0001
# gui_set_mouse_tool_option -tool CreateTextTool -option {text} -value {IOGND}
# gui_mouse_tool -window [gui_get_current_window -types Layout -mru] -add_point {1231.970 2.150} -scale 0.0001

gui_set_mouse_tool_option -tool CreateTextTool -option {text} -value {VCC}
gui_set_mouse_tool_option -tool CreateTextTool -option {height} -value {10}
gui_mouse_tool -window [gui_get_current_window -types Layout -mru] -start CreateTextTool
gui_set_mouse_tool_option -tool CreateTextTool -option {layer} -value {metal1}
gui_set_mouse_tool_option -tool CreateTextTool -option {layer} -value {metal3}
gui_set_mouse_tool_option -tool CreateTextTool -option {autoLayer} -value {false}
gui_set_mouse_tool_option -tool CreateTextTool -option {layer} -value {m3text}
gui_mouse_tool -window [gui_get_current_window -types Layout -mru] -add_point {1510.600 5107.660} -scale 0.1334
gui_set_mouse_tool_option -tool CreateTextTool -option {text} -value {GND}
gui_mouse_tool -window [gui_get_current_window -types Layout -mru] -add_point {1507.930 5097.120} -scale 0.1334
gui_set_mouse_tool_option -tool CreateTextTool -option {text} -value {IOGND}
gui_mouse_tool -window [gui_get_current_window -types Layout -mru] -add_point {2.150 3062.430} -scale 0.0001
gui_set_mouse_tool_option -tool CreateTextTool -option {text} -value {IOVCC}
gui_mouse_tool -window [gui_get_current_window -types Layout -mru] -add_point {2.150 1820.750} -scale 0.0001
#==============================================
# Add bondpad
#==============================================
source ../scripts/createNplace_bondpads_umc_C.tcl
createNplace_bondpads -inline_pad_ref_name BONDPADCGU_m -stagger true -stagger_pad_ref_name BONDPADCNU_m
derive_pg_connection -power_net {VCC} -ground_net {GND} -power_pin {VCC} -ground_pin {GND}
#==============================================
#Save Design
#==============================================
save_mw_cel  -design "CHIP.CEL;1"
save_mw_cel  -design "CHIP.CEL;1" -as "dfm"
#==============================================
# write output files
# write out layout (.gds) file
#==============================================
set_write_stream_options -map_layer /usr/cad/Library/CBDK018_UMC_Faraday_v1.0/CIC/ICC/macro.map -child_depth 20 -flatten_via
write_stream -format gds -lib_name ./CHIP -cells {CHIP } CHIP_lab.gds
#==============================================
# write out verilog file
#==============================================
write_verilog -unconnected_ports -diode_ports -wire_declaration -keep_backslash_before_hiersep -no_physical_only_cells CHIP_pr.v
# -unconnected_ports (remove unconnected port for LVS)
#==============================================
# write out verilog file
# Write out standard delay format
#==============================================
write_sdf -version 2.0 -context verilog -load_delay net CHIP_pr.sdf
#==============================================
# write out verilog file
# Write out standard delay format
#==============================================
report_timing > [format %s%s%s $REPORT_PATH $design_name "_DFM_timing.rpt"]
report_power > [format %s%s%s $REPORT_PATH $design_name "_DFM_power.rpt"]
report_area > [format %s%s%s $REPORT_PATH $design_name "_DFM_area.rpt"]


exit