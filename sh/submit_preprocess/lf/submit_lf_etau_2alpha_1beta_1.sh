jobsub_submit -G dune \
    --mail_never \
    -N 10 \
    --memory=5000MB \
    --disk=10GB \
    --cpu=1 \
    --expected-lifetime=30h \
    --singularity-image /cvmfs/singularity.opensciencegrid.org/fermilab/fnal-wn-sl7:latest \
    --append_condor_requirements='(TARGET.HAS_Singularity==true&&TARGET.HAS_CVMFS_dune_opensciencegrid_org==true&&TARGET.HAS_CVMFS_larsoft_opensciencegrid_org==true&&TARGET.CVMFS_dune_opensciencegrid_org_REVISION>=1105)' \
	 file:///exp/dune/app/users/sungbino/RESum/sample_prod/proposal_2026/jobsub/run_preprocess/lf/run_preprocess_lf_etau_2alpha_1beta_1.sh
