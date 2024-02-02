#design_setup design_planning placement cts route
set start_phase "design_planning"
set design_name "CHIP"

close_mw_cel [format %s%s $design_name ".CEL;1"]

open_mw_cel $start_phase
save_mw_cel  -design [format %s%s $start_phase ".CEL;1"] -as $design_name
close_mw_cel [format %s%s $start_phase ".CEL;1"]
open_mw_cel $design_name


source ../scripts/01_Design_setup.tcl
source ../scripts/02_Design_planning.tcl
source ../scripts/03_Placement.tcl
source ../scripts/04_cts.tcl
source ../scripts/05_route.tcl


open_mw_lib /users/vick/Desktop/winograd_teach/icc/run/CHIP
