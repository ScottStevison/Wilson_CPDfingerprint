#!/bin/bash
# Orftcr.sh

export NA=$1
export TF=$2
export LEN=$3
cd ${NA}

printf "${NA}_dipy_bk_inbetween_motifindiv.txt\n${LEN}\n${TF}\n${NA}_dipy_inbetween_bk_plus.wig\n${NA}_dipy_inbetween_bk_minus.wig\n\n" | perl ../motifplot_yeastbs_inbetween.pl

