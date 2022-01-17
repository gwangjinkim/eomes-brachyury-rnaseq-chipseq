# rename raw fastq.gz files
mv H5JLJBGXF_280120_CMSJT_20s000290-1-1_Arnold_lane1EoBRA1embr5_1_sequence.txt.gz EoBRA-embr-5-1-1.fastq.gz
mv H5JLJBGXF_280120_CMSJT_20s000290-1-1_Arnold_lane1EoBRA1embr5_2_sequence.txt.gz EoBRA-embr-5-1-2.fastq.gz
mv H5JLJBGXF_280120_CMSJT_20s000290-1-1_Arnold_lane1EoBRA2embr8_1_sequence.txt.gz EoBRA-embr-8-2-1.fastq.gz
mv H5JLJBGXF_280120_CMSJT_20s000290-1-1_Arnold_lane1EoBRA2embr8_2_sequence.txt.gz EoBRA-embr-8-2-2.fastq.gz
mv H5JLJBGXF_280120_CMSJT_20s000290-1-1_Arnold_lane1EoBRA3embr9_1_sequence.txt.gz EoBRA-embr-9-3-1.fastq.gz
mv H5JLJBGXF_280120_CMSJT_20s000290-1-1_Arnold_lane1EoBRA3embr9_2_sequence.txt.gz EoBRA-embr-9-3-2.fastq.gz
mv H5JLJBGXF_280120_CMSJT_20s000290-1-1_Arnold_lane1EoBRA4embr10_1_sequence.txt.gz EoBRA-embr-10-4-1.fastq.gz
mv H5JLJBGXF_280120_CMSJT_20s000290-1-1_Arnold_lane1EoBRA4embr10_2_sequence.txt.gz EoBRA-embr-10-4-2.fastq.gz
mv H5JLJBGXF_280120_CMSJT_20s000290-1-1_Arnold_lane1WT1ebmr1_1_sequence.txt.gz WT-embr-1-1-1.fastq.gz
mv H5JLJBGXF_280120_CMSJT_20s000290-1-1_Arnold_lane1WT1ebmr1_2_sequence.txt.gz WT-embr-1-1-2.fastq.gz
mv H5JLJBGXF_280120_CMSJT_20s000290-1-1_Arnold_lane1WT2ebmr6_1_sequence.txt.gz WT-embr-6-2-1.fastq.gz
mv H5JLJBGXF_280120_CMSJT_20s000290-1-1_Arnold_lane1WT2ebmr6_2_sequence.txt.gz WT-embr-6-2-2.fastq.gz
mv H5JLJBGXF_280120_CMSJT_20s000290-1-1_Arnold_lane1WT3ebmr13_1_sequence.txt.gz WT-embr-13-3-1.fastq.gz
mv H5JLJBGXF_280120_CMSJT_20s000290-1-1_Arnold_lane1WT3ebmr13_2_sequence.txt.gz WT-embr-13-3-2.fastq.gz
mv H5JLJBGXF_280120_CMSJT_20s000290-1-1_Arnold_lane1WT4ebmr14_1_sequence.txt.gz WT-embr-14-4-1.fastq.gz
mv H5JLJBGXF_280120_CMSJT_20s000290-1-1_Arnold_lane1WT4ebmr14_2_sequence.txt.gz WT-embr-14-4-2.fastq.gz

# run alignment # in workstation or cluster using the script `rsubread-oct2018-mouse.r` (requiring in `genome` folder iGenom of mouse)
rsubread-oct2018-mouse.r "EoBRA-embr-5-1" "-1.fastq.gz" "${base}/data/galaxy_2020_jan" "${base}/alignment/galaxy_2020_jan" "${base}/count/galaxy_2020_jan" 4 &> ${base}/alignment/galaxy_2020_jan/EoBRA-embr-5-1.log & \
rsubread-oct2018-mouse.r "EoBRA-embr-8-2" "-1.fastq.gz" "${base}/data/galaxy_2020_jan" "${base}/alignment/galaxy_2020_jan" "${base}/count/galaxy_2020_jan" 4 &> ${base}/alignment/galaxy_2020_jan/EoBRA-embr-8-2.log & \
rsubread-oct2018-mouse.r "EoBRA-embr-9-3" "-1.fastq.gz" "${base}/data/galaxy_2020_jan" "${base}/alignment/galaxy_2020_jan" "${base}/count/galaxy_2020_jan" 4 &> ${base}/alignment/galaxy_2020_jan/EoBRA-embr-9-3.log & \
rsubread-oct2018-mouse.r "EoBRA-embr-10-4" "-1.fastq.gz" "${base}/data/galaxy_2020_jan" "${base}/alignment/galaxy_2020_jan" "${base}/count/galaxy_2020_jan" 4 &> ${base}/alignment/galaxy_2020_jan/EoBRA-embr-10-4.log & \
rsubread-oct2018-mouse.r "WT-embr-1-1" "-1.fastq.gz" "${base}/data/galaxy_2020_jan" "${base}/alignment/galaxy_2020_jan" "${base}/count/galaxy_2020_jan" 4 &> ${base}/alignment/galaxy_2020_jan/WT-embr-1-1.log & \
rsubread-oct2018-mouse.r "WT-embr-6-2" "-1.fastq.gz" "${base}/data/galaxy_2020_jan" "${base}/alignment/galaxy_2020_jan" "${base}/count/galaxy_2020_jan" 4 &> ${base}/alignment/galaxy_2020_jan/WT-embr-6-2.log & \
rsubread-oct2018-mouse.r "WT-embr-13-3" "-1.fastq.gz" "${base}/data/galaxy_2020_jan" "${base}/alignment/galaxy_2020_jan" "${base}/count/galaxy_2020_jan" 4 &> ${base}/alignment/galaxy_2020_jan/WT-embr-13-3.log & \
rsubread-oct2018-mouse.r "WT-embr-14-4" "-1.fastq.gz" "${base}/data/galaxy_2020_jan" "${base}/alignment/galaxy_2020_jan" "${base}/count/galaxy_2020_jan" 4 &> ${base}/alignment/galaxy_2020_jan/WT-embr-14-4.log

# originally actually done in the cluster
msub /home/fr/fr_fr/fr_gk1029/script/new/rsubread-oct2018-mouse.sh "EoBRA-embr-5-1"
msub /home/fr/fr_fr/fr_gk1029/script/new/rsubread-oct2018-mouse.sh "EoBRA-embr-8-2"
msub /home/fr/fr_fr/fr_gk1029/script/new/rsubread-oct2018-mouse.sh "EoBRA-embr-9-3"
msub /home/fr/fr_fr/fr_gk1029/script/new/rsubread-oct2018-mouse.sh "EoBRA-embr-10-4"
msub /home/fr/fr_fr/fr_gk1029/script/new/rsubread-oct2018-mouse.sh "WT-embr-1-1"
msub /home/fr/fr_fr/fr_gk1029/script/new/rsubread-oct2018-mouse.sh "WT-embr-6-2"
msub /home/fr/fr_fr/fr_gk1029/script/new/rsubread-oct2018-mouse.sh "WT-embr-13-3"
msub /home/fr/fr_fr/fr_gk1029/script/new/rsubread-oct2018-mouse.sh "WT-embr-14-4"

# count files used for downstream analyses:y
EoBRA-embr-10-4-sym-fcount.tab
EoBRA-embr-5-1-sym-fcount.tab
EoBRA-embr-8-2-sym-fcount.tab
EoBRA-embr-9-3-sym-fcount.tab
WT-embr-1-1-sym-fcount.tab
WT-embr-13-3-sym-fcount.tab
WT-embr-14-4-sym-fcount.tab
WT-embr-6-2-sym-fcount.tab
