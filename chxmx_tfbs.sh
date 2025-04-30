#!/bin/bash
# Orftcr.sh

export DIR=$1
export NA=$2
export LEN=$3
cd ${DIR}

#printf "${NA}_dipy_bk_chxmx.txt\n10\n${NA}\n${NA}_CX_sort.wig\n${NA}_CX_sort.wig\n\n" | perl ../motif_yeastbs.pl

printf "${NA}_dipy_bk_chxmxindiv.txt\n${LEN}\n${NA}\n${NA}_CX.wig\n${NA}_CX.wig\n\n" | perl ../motifplot_yeastbs.pl

cd ..
