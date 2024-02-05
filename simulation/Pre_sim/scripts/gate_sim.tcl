#gate_level_sim 


vcs ../../../verilog/tb_2_3.v \
../../../dc/run/CHIP_syn.v \
-v /usr/cad/Library/CBDK018_UMC_Faraday_v1.0/CIC/Verilog/fsa0m_a_generic_core_30.lib.src /usr/cad/Library/CBDK018_UMC_Faraday_v1.0/CIC/Verilog/fsa0m_a_t33_generic_io_30.lib.src  \
-R -full64 +maxdelays -negdelay +neg_tchk -kdb -lca\
-xprop=tmerge -report=xprop \
-l gate_level_sim.log -debug_access+all +v2k \
+define+DUMP_VCD+POST_SIM | tee ../../../run_all/pre_sim.log

#verdi -dbdir simv.daidir -ssf axis_top_gate_level.fsdb&