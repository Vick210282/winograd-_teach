######################
#start
######################
echo "Start Source tool"
source ./.tool_use
######################
# Run RTL simulation
echo "Run RTL simulation..."
cd ../simulation/RTL_sim/run/
source ../scripts/run.tcl
echo "RTL simulation done..."
######################
# Run Design Compiler
######################
echo "Run Design Compiler..."
cd ../../../dc/run
source ../scripts/run_dc.tcl
######################
# Run Pre-layout Simulation
######################
echo "Run Pre-Layout simulation..."
cd ../../simulation/Pre_sim/run/
source ../scripts/gate_sim.tcl
echo " Pre-Layout simulation Done..."
######################
# Run ICC 
######################
echo "Start Auto Placement and Route using ICC"
cd ../../../icc/run/
source ../scripts/run_icc.tcl
echo "ICC DONE"
######################
# Cpoy Files to destination
######################
echo "Cpoy Files to destination "
cp CHIP_lab.gds ../verify/drc/BaseRule/
cp CHIP_lab.gds ../verify/lvs
cp CHIP_pr.v ../verify
cd ../verify
######################
# Edit CHIP_pr.v
######################
echo "Edit files... Comment the Physical cells "
python comment.py
cp CHIP_pr.v lvs/
cp CHIP_pr.v ../../simulation/Post_sim/
######################
# Calibre DRC
######################
echo "DRC..... "
cd drc/BaseRule/
calibre -drc -hier G-DF-Mixed_Mode_RFCMOS18-1.8v_3.3v-1P6M-MMC-Calibre-DRC-2.14_P1 -turbo 8
cp BaseRule.db ../../result/
cd ../../lvs
#####################
# turn verilog to spice format
#####################
echo "V 2 LVS "
v2lvs -v CHIP_pr.v -l umc18_core_lvs.v -s umc18_core_lvs.spi -l umc18_io_lvs.v -sumc18_io_lvs.spi -lumc18_pad_lvs.v -s umc18_pad_lvs.spi -o source.spi -s1 VCC -s0 GND

######################
# Calibre LVS
######################
echo "LVS.... "
calibre -lvs -spice source.spi -hier -auto G-DF-MIXED_MODE_RFCMOS18-1.8V_3.3V-1P6M-MMC_CALIBRE-LVS-2.1-P8_m.txt -turbo 8
cp lvs_test.rep ../result/
# calibre -rve svdb &
# after idle
######################
# Post Layout Simulation
######################
echo "Post layout simulation "
cd ../../../simulation/Post_layout_sim/run
source ../scripts/post_sim.tcl
######################
# Show DRC /LVS result
######################
cd ../../../icc/verify/result/
calibre -rve BaseRule.db &
code lvs_test.rep &



