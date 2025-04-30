#!/bin/bash
# SetBackground.sh
#Code adapted from code on Taylor lab github site

export NA=$1
cd ${NA}

# calculate inbetween position for wig

#perl ../inbetween_cpd_format.pl <${NA}_dipy_sorted_minusstrand.bed >${NA}_dipy_inbetween_minusstrand.wig

#perl ../inbetween_cpd_format.pl <${NA}_dipy_sorted_plusstrand.bed >${NA}_dipy_inbetween_plusstrand.wig

# set backbground for dipyrimidine reads
printf "${NA}_dipy_inbetween_minusstrand.wig\n../initial_minus_inbetween_dipy.wig\n" | perl ../set_background.pl >${NA}_dipy_inbetween_bk_minus.wig

printf "${NA}_dipy_inbetween_plusstrand.wig\n../initial_plus_inbetween_dipy.wig\n" | perl ../set_background.pl >${NA}_dipy_inbetween_bk_plus.wig

perl ../add_UV_wig_files.pl ${NA}_dipy_inbetween_bk_minus.wig ${NA}_dipy_inbetween_bk_plus.wig >${NA}_dipy_inbetween_bk_bothstrands.wig
