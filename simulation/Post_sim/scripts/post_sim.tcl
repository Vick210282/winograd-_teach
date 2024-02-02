#Post layout simulaion 


vcs ../../../verilog/tb_for_combine_32.v \
../CHIP_pr.v \
-v /usr/cad/Library/CBDK018_UMC_Faraday_v1.0/CIC/Verilog/fsa0m_a_generic_core_30.lib.src /usr/cad/Library/CBDK018_UMC_Faraday_v1.0/CIC/Verilog/fsa0m_a_t33_generic_io_30.lib.src  \
-R -full64 +maxdelays -negdelay +neg_tchk -kdb -lca\
-xprop=tmerge -report=xprop \
-l post_layout_sim.log -debug_access+all +v2k \
+define+SDF | tee ../../../run_all/post_sim.log

#verdi -dbdir simv.daidir -ssf axis_top_gate_level.fsdb&