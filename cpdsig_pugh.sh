#!/bin/bash
# Orftcr.sh

export NA=$1
cd ${NA}

printf "${NA}_dipy_bk_inbetween_PughAll.txt\n${NA}_dipy_inbetween_bk_plus.wig\n${NA}_dipy_inbetween_bk_minus.wig\n\n" | perl ../indivtfbs_cpdsigs_Pugh_fastall.pl


