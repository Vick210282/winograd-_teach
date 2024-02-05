#rtl_sim axi_top + debug_tes
vcs ../../../verilog/tb_2_3.v \
../../../verilog/WC.v \
-R -full64 -kdb -lca +v2k \
-debug_access+all \
+define+RTL_SIM | tee ../../../run_all/RTL_sim.log
 


#verdi -dbdir simv.daidir -ssf rtl_sim_axis_top.fsdb&