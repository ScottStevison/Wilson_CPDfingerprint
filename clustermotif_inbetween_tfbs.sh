#!/bin/bash
# Orftcr.sh

export NA=$1
export TF=$2
export LEN=$3
export NORM=$4
cd ${NA}

printf "${NA}_dipy_bk_inbetween_plot.txt\n${LEN}\n${TF}\n${NA}_dipy_inbetween_bk_plus.wig\n${NA}_dipy_inbetween_bk_minus.wig\n\n" | perl ../motifplot_yeastbs_inbetween.pl

fastaFromBed -s -fi ../saccer3_genome.fa -bed ${NA}_dipy_bk_inbetween_plot_${LEN}bp_${TF}.bed -fo ${NA}_dipy_bk_inbetween_plot_${LEN}bp_${TF}.fa

printf "${NA}_dipy_bk_inbetween_plot_${LEN}bp_${TF}.txt\n${NORM}\n" | perl ../normplot.pl 

printf "${NA}_dipy_bk_inbetween_plot_${LEN}bp_${TF}_norm${NORM}.txt\n" | perl ../haplot_sort.pl

perl ../format_CDT.pl < ${NA}_dipy_bk_inbetween_plot_${LEN}bp_${TF}_norm${NORM}_sorted.txt >${NA}_dipy_bk_inbetween_plot_${LEN}bp_${TF}_norm${NORM}_sorted.cdt
