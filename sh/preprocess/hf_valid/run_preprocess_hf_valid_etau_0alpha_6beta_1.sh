#######################################################################################
#######################################################################################
#!/bin/bash

echo "doing general software setup"
source /cvmfs/dune.opensciencegrid.org/products/dune/setup_dune.sh
setup dunesw v10_03_01d02 -q e26:prof
source /cvmfs/fermilab.opensciencegrid.org/products/common/etc/setup
setup fife_utils
#get info about current grid proxy
voms-proxy-info -all
echo "software setup complete"

echo "echo-ing JOBSUBID: $JOBSUBJOBID"
echo $JOBSUBJOBID | sed 's/.*\.\([0-9]*\)\@[0-9]*.*/\1/p;d'
jobid=`echo $JOBSUBJOBID | sed 's/.*\.\([0-9]*\)\@[0-9]*.*/\1/p;d'`
echo "the number is: $jobid"
nevt=100

#Make sure we know where we are working and where to look for certain files
echo "printing working directory of grid node"
pwd
local_dir=`pwd`
#see whats there
echo "the local repo has the following folders and files:"
ls -ltrha
echo "now cd-ing to CONDOR_DIR_INPUT AT $CONDOR_DIR_INPUT"
cd $CONDOR_DIR_INPUT
echo "now printing the CONDOR_DIR_INPUT path:"
pwd
echo "now ls-ing within CONDOR_DIR_INPUT at $CONDOR_DIR_INPUT"
ls -ltrha

model=hn_esf
prefix=prodaddgenie_nnbar_${model}_dune10kt_1x2x6_hf_valid_etau_0alpha_6beta_1
input=${prefix}_G4_detsim_reco1_reco2_${jobid}.root

ifdh cp /pnfs/dune/persistent/users/lwan/nnbar/tarball/v10_03_01.tar $CONDOR_DIR_INPUT
tar -xvf v10_03_01.tar
source ${CONDOR_DIR_INPUT}/v10_03_01/localProducts_larsoft_v10_03_01_e26_prof/setup-grid
mrbslp
ln -s ${CONDOR_DIR_INPUT}/v10_03_01/build_slf7.x86_64/dunereco/fcl/* .
export CET_PLUGIN_PATH=${CONDOR_DIR_INPUT}/v10_03_01/build_slf7.x86_64/dunereco/slf7.x86_64.e26.prof/lib:${CET_PLUGIN_PATH}

ifdh cp /pnfs/dune/scratch/users/sungbino/v09_85_00/nnbar/${model}/hf_valid/etau_0alpha_6beta_1/reco2/${input} $CONDOR_DIR_INPUT
echo "again ls-ing within CONDOR_DIR_INPUT at $CONDOR_DIR_INPUT"
ls -ltrha

lar -c recoenergys.fcl -s ${input}
echo "finally ls-ing within CONDOR_DIR_INPUT at $CONDOR_DIR_INPUT"
ls -ltrha

ifdh cp -D *preprocess.root /pnfs/dune/scratch/users/sungbino/v10_03_01/nnbar//${model}/hf_valid/etau_0alpha_6beta_1/preprocess
ifdh cp -D RecoEnergyS.root /pnfs/dune/scratch/users/sungbino/v10_03_01/nnbar//${model}/hf_valid/etau_0alpha_6beta_1/preprocess/${prefix}_G4_detsim_reco1_reco2_RecoEnergyS_$jobid.root
