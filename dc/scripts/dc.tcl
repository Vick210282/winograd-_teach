#cd ..
#==============================================
#Setting
#==============================================
set design_name "CHIP"
set cycle_time 30 ; # Clock Period defined by designer
set clk_name axi_clk ; # Clokc name defined by designer
set rst_name axi_reset_n ;# reset name defined by designer

set t_in 0.9 ; #input delay defined by designer
set t_out 0.5 ; #output delay defined by designer
set_host_options -max_cores 8
#==============================================
# Analyze and  Read files
#==============================================
analyze -library WORK -format verilog {../../verilog/WC.v}
analyze -library WORK -format verilog {../../verilog/CHIP.v}

read_file -format verilog {../../verilog/WC.v}
read_file -format verilog {../../verilog/CHIP.v}

elaborate WC -architecture verilog -library WORK -update
elaborate CHIP -architecture verilog -library WORK -update
#==============================================
# Check setup file has been read
#==============================================
current_design [get_designs $design_name]
source .synopsys_dc.setup
link
#CHIP Level Constraint
#==============================================
#Setting Operating Conditions
#==============================================
set_operating_conditions -max WCCOM -max_library \
fsa0m_a_generic_core_ss1p62v125c\
                         -min BCCOM -min_library \
fsa0m_a_generic_core_ff1p98vm40c
set_driving_cell -library fsa0m_a_t33_generic_io_ss1p62v125c -lib_cell XMC -pin {O} [all_inputs]
set_load [load_of "fsa0m_a_t33_generic_io_ss1p62v125c/YA2GSC/I"] [all_outputs]
 
#==============================================
#Setting Clock Constraints
#==============================================
create_clock -period $cycle_time  [get_ports $clk_name]  
set_dont_touch_network  [get_clocks $clk_name]
set_fix_hold  [get_clocks $clk_name]
set_clock_uncertainty  0.1  [get_clocks $clk_name]
set_clock_latency  0.5  [get_clocks $clk_name]
set_input_transition  0.5  [all_inputs];#TSRI machine 
set_clock_transition  0.1  [all_clocks]
set_ideal_network  [get_ports $clk_name]

# In\Output delay are defined by specific situation
# set_input_delay $t_in -clock $clk_name [remove_from_collection [all_inputs] [get_ports $clk_name]]
# set_output_delay $t_out -clock $clk_name [all_outputs]

# set_load 40 [all_outputs] ; # 93000 in TSRI
#==============================================
# deal with High Fanout Net (HFN)
#==============================================
set_ideal_network  [get_ports $rst_name]
set high_fanout_net_threshold 0
uniquify
#==============================================
# Deal with assign statement
#==============================================
set_fix_multiple_port_nets -all -buffer_constants [get_designs *]
#IO port can not be changed
set_dont_touch [get_cell ipad_*]
set_dont_touch [get_cell opad_*]
#==============================================
#DRC Constraints
#==============================================
#check_timing
set_max_area 0
set_max_capacitance 0.5 [all_inputs]
set_max_fanout 2 [all_inputs]
set_max_transition 0.5 [all_inputs]
#==============================================
#check_timing
#==============================================
current_design [get_designs $design_name]
#==============================================
# Compile
#==============================================
# compile -boundary_optimization
compile_ultra
current_design [get_designs $design_name]
#==============================================
# if there is scan chain in design, do not remove unconnected ports
#==============================================
remove_unconnected_ports -blast_buses [get_cells -hierarchical *]
#==============================================
#Naming Rule
#==============================================
set bus_inference_style {%s[%d]}
set bus_naming_style {%s[%d]}
set hdlout_internal_busses true
change_names -hierarchy -rule verilog
define_name_rules name_rule -allowed {a-z A-Z 0-9 _} -max_length 255 -type cell
define_name_rules name_rule -allowed {a-z A-Z 0-9 _[]} -max_length 255 -type net
define_name_rules name_rule -map {{"\\*cell\\*" "cell"}}
define_name_rules name_rule -case_insensitive
change_names -hierarchy -rules name_rule
#==============================================
#Write output file
#==============================================

write -format verilog -hierarchy -output [format %s%s $design_name _syn.v]
write -format ddc   -hierarchy -output [format %s%s $design_name _syn.ddc]
write_sdc [format %s%s $design_name _syn.sdc]
write_sdf -version 1.0 -context verilog -load_delay net [format %s%s $design_name _syn.sdf]
report_area -designware > [format %s%s $design_name _area.log]
report_timing > [format %s%s $design_name _timing.log]
report_power > [format %s%s $design_name _power.log]
report_qor   >  [format %s%s $design_name _qor.log]

exit
