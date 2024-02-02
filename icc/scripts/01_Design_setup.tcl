set design_name "CHIP"
set REPORT_PATH "./report/"
#==============================================
#Create Container
#==============================================
# source ../.synopsys_dc.setup
create_mw_lib  -technology /usr/cad/Library/CBDK018_UMC_Faraday_v1.0/CIC/ICC/umc_018_1p6m_mk_20ka_cic.tf \
-mw_reference_library {/usr/cad/Library/CBDK018_UMC_Faraday_v1.0/CIC/ICC/FSA0M_A_GENERIC_CORE \
/usr/cad/Library/CBDK018_UMC_Faraday_v1.0/CIC/ICC/FSA0M_A_T33_GENERIC_IO \
/usr/cad/Library/CBDK018_UMC_Faraday_v1.0/CIC/ICC/BONDPAD}\
 -bus_naming_style {[%d]}  -open  CHIP

# create_mw_lib  -technology /usr/cad/Library/CBDK018_UMC_Faraday_v1.0/CIC/ICC/umc_018_1p6m_mk_20ka_cic.tf \
# -mw_reference_library {/usr/cad/Library/CBDK018_UMC_Faraday_v1.0/CIC/ICC/FSA0M_A_GENERIC_CORE \
#  /usr/cad/Library/CBDK018_UMC_Faraday_v1.0/CIC/ICC/FSA0M_A_T33_GENERIC_IO \
#  /usr/cad/Library/CBDK018_UMC_Faraday_v1.0/CIC/ICC/BONDPAD} \
#  -bus_naming_style {[%d]}  -open  CHIP


# set_check_library_option -all
# check_library

set syn_v_file_location [format %s%s ../../dc/run/$design_name _syn.v]
import_designs -format verilog -top $design_name -cel $design_name $syn_v_file_location


#==============================================
#Specify TLU+ Parasitic RC Model Files
#==============================================
set_tlu_plus_files -max_tluplus /usr/cad/Library/CBDK018_UMC_Faraday_v1.0/CIC/ICC/tluplus/u18_typ.tluplus \
-tech2itf_map  /usr/cad/Library/CBDK018_UMC_Faraday_v1.0/CIC/ICC/tluplus/u18.map

set sdc_file_loaction [format %s%s ../../dc/run/$design_name _syn.sdc]
read_sdc  -version Latest $sdc_file_loaction
#==============================================
#Check Setup time if timing violation happened, go back to Design Compiler adn change it.
#==============================================

# set_zero_interconnect_delay_mode true
# report_constraint -all
# report_timing 
# set_zero_interconnect_delay_mode false
#==============================================
#Save Design
#==============================================
save_mw_cel  -design $design_name
save_mw_cel  -design $design_name -as "design_setup"
