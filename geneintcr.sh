#!/bin/bash
# Orftcr.sh

export NA=$1
cd ${NA}

#lowres bin analysis first
#printf "${NA}_dipy_inbetween_bk_plus.wig\n${NA}_dipy_inbetween_bk_minus.wig\n" | perl ../cpd_inorf_bins.pl >${NA}_dipy_inbetween_bk_tcrbins_matrix.txt

#printf "${NA}_dipy_inbetween_bk_tcrbins_matrix.txt\n" | perl ../tcr_bins_allgenes.pl >${NA}_dipy_inbetween_bk_tcrbins_allgenes.txt

#highres analysis second

printf "${NA}_dipy_inbetween_bk_plus.wig\n${NA}_dipy_inbetween_bk_minus.wig\n" | perl ../cpd_inorf_highres.pl >${NA}_dipy_inbetween_bk_tcrhires_matrix.txt

#printf "${NA}_dipy_inbetween_bk_tcrhires_matrix.txt\n" | perl ../tcr_inhires_allgenes.pl >${NA}_dipy_inbetween_bk_tcrhires_allgenes.txt

#
#printf "${NA}_dipy_inbetween_bk_tcrhires_matrix.txt\n" | perl ../orfplot_cpdhires_trxall.pl 
#
#printf "${NA}_dipy_inbetween_bk_tcrhires_trxsorted.txt" | perl ../tcr_hires_allgenes.pl >${NA}_dipy_inbetween_bk_tcrhires_trxsorted_allgenes.txt

