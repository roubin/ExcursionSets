set term postscrip eps color; set output "./plot.eps";
#set term epslatex; set output "./figures/gmf_cumulative.eps"

#SET LINE STYLE
set style line 1 lt 1 lw 2 pt 1 ps 0.5 lc rgb "#0060ad" #--blue
set style line 2 lt 1 lw 2 pt 1 ps 0.5 lc rgb "#dd181f" #--red
set style line 3 lt 1 lw 2 pt 1 ps 0.5 lc rgb "#008800" #--green
set style line 4 lt 1 lw 2 pt 1 ps 0.5 lc rgb "#00aabb" #--blue light
set style line 5 lt 1 lw 2 pt 1 ps 0.5 lc rgb "#ff5500" #--orange
set style line 6 lt 1 lw 2 pt 1 ps 0.5 lc rgb "#bb0088" #--purple
set style line 7 lt 1 lw 2 pt 1 ps 0.5 lc rgb "#346D3D" #--purple

set style line 11 lt 2 lw 2 pt 1 ps 0.5 lc rgb "#0060ad" #--blue
set style line 12 lt 2 lw 2 pt 1 ps 0.5 lc rgb "#dd181f" #--red
set style line 13 lt 2 lw 2 pt 1 ps 0.5 lc rgb "#008800" #--green

set style line 21 lt 3 lw 2 pt 1 ps 0.5 lc rgb "#0060ad" #--blue
set style line 22 lt 3 lw 2 pt 1 ps 0.5 lc rgb "#dd181f" #--red
set style line 23 lt 3 lw 2 pt 1 ps 0.5 lc rgb "#008800" #--green


#SET AXES
#set border
#set key t r
set xzeroaxis
set yzeroaxis


#set xlabel "$\\lset$"
set xtics nomirror
set ytics nomirror

#set yrange [0:8000]
set xrange [-5:5]


#set ylabel "$\\GMFa_k=\\minfu$" rotate by 90


set style fill transparent solid 0.2

set term postscrip eps color; set output "./plot.eps";
set key b r
#set logscale x
plot "../output_f_exp_lkc0.dat" u ($1):($2):($4) notitle "Experimental Enveloppe"  w filledcu ls 11 ,\
     "../output_f_exp_lkc0.dat" u ($1):($2) notitle w l ls 11 ,\
     "../output_f_exp_lkc0.dat" u ($1):($4) notitle w l ls 11 ,\
     "gaussian_3D_Lc2_th.dat" u ($1):($2) title "Theoretical" w l ls 2 ,\
     "../output_f_exp_lkc0.dat" u ($1):($3) title "Experimental" w p ls 11



set output


