#rtl_sim axi_top + debug_tes
vcs ../../../verilog/tb_for_combine_32.v \
../../../verilog/axis_top_ver1126_tcb.v \
../../../verilog/top_tcb_121_16_10.v \
../../../verilog/layer0_tcb_121x16x10.v \
../../../verilog/layer2_tcb_121x16x10.v \
../../../verilog/comparator_30bit.v \
-R -full64 -kdb -lca +v2k \
-debug_access+all \
+define+RTL_SIM | tee ../../../run_all/RTL_sim.log
 


#verdi -dbdir simv.daidir -ssf rtl_sim_axis_top.fsdb&