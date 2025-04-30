#!/bin/bash
# Orftcr.sh

export NA=$1
export TF=$2
cd ${NA}

printf "${NA}_dipy_bk_inbetween_Pugh.txt\n100\n${TF}\n${NA}_dipy_inbetween_bk_plus.wig\n${NA}_dipy_inbetween_bk_minus.wig\n\n" | perl ../uvpp_offset_yeastbs_inbetween.pl

#printf "${NA}_dipy_bk_inbetween_Pughindiv.txt\n100\n${TF}\n${NA}_dipy_inbetween_bk_plus.wig\n${NA}_dipy_inbetween_bk_minus.wig\n\n" | perl ../uvpplot_offset_yeastbs_inbetween.pl

fastaFromBed -s -fi ../saccer3_genome.fa -bed ${NA}_dipy_bk_inbetween_Pugh_100bp_${TF}.bed -fo ${NA}_dipy_bk_inbetween_Pugh_100bp_${TF}.fa

