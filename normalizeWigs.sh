#!/bin/bash
# SetBackground.sh
#Code adapted from code on Taylor lab github site

export norm=$1
export NA=$2
cd ${NA}


# normalize wigs

perl ../norm_wigs.pl ${norm} ${NA}_dipy_inbetween_bk_minus.wig >${NA}_dipy_inbetween_bk_norm_minus.wig
perl ../norm_wigs.pl ${norm} ${NA}_dipy_inbetween_bk_plus.wig >${NA}_dipy_inbetween_bk_norm_plus.wig

perl ../add_UV_wig_files.pl ${NA}_dipy_inbetween_bk_norm_plus.wig ${NA}_dipy_inbetween_bk_norm_minus.wig >${NA}_dipy_inbetween_bk_norm_bothstrands.wig

perl ../leftinbetweenwig.pl <${NA}_dipy_inbetween_bk_norm_bothstrands.wig >${NA}_dipy_leftinbetween_bk_norm_bothstrands.wig
