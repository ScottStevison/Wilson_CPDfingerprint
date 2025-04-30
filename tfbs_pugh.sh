#!/bin/bash
# Orftcr.sh

export NA=$1
export TF=$2
cd ${NA}

printf "${NA}_dipy_bk_Pugh.txt\n100\n${TF}\n${NA}_dipy_bk_plus.wig\n${NA}_dipy_bk_minus.wig\n\n" | perl ../uvpp_offset_yeastbs_mutations.pl
