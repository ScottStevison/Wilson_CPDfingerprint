#!/bin/bash
# SetBackground.sh
#Code adapted from code on Taylor lab github site

export NA=$1
cd ${NA}

# calculate inbetween position for wig

perl ../intersect_UV_wig_files.pl ../initial_bothstrands_inbetween_CC.wig ${NA}_dipy_leftinbetween_bk_bothstrands.wig >${NA}_CC_leftinbetween_bk_bothstrands.wig

perl ../intersect_UV_wig_files.pl ../initial_bothstrands_inbetween_CT.wig ${NA}_dipy_leftinbetween_bk_bothstrands.wig >${NA}_CT_leftinbetween_bk_bothstrands.wig

perl ../intersect_UV_wig_files.pl ../initial_bothstrands_inbetween_TC.wig ${NA}_dipy_leftinbetween_bk_bothstrands.wig >${NA}_TC_leftinbetween_bk_bothstrands.wig

perl ../intersect_UV_wig_files.pl ../initial_bothstrands_inbetween_TT.wig ${NA}_dipy_leftinbetween_bk_bothstrands.wig >${NA}_TT_leftinbetween_bk_bothstrands.wig
