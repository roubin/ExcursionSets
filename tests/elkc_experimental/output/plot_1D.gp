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


set xlabel "$\\lset$"
set xtics nomirror
set ytics nomirror


set style fill transparent solid 0.2

set xrange [0.01:1000]

set logscale x

set term epslatex;
set output "./figures/elkc_exp_1D_lognormal_0.eps"
set ylabel "Euler characteristic $\\EC$" rotate by 90
set key t r
plot "lognormal_1D_Lc1_ex.dat" u ($1):($2):($4) title "Experimental" w filledcu ls 1 lw 1,\
     "lognormal_1D_Lc1_ex.dat" u ($1):($2) notitle w l ls 1 lw 1,\
     "lognormal_1D_Lc1_ex.dat" u ($1):($4) notitle w l ls 1 lw 1,\
     "lognormal_1D_Lc1_th.dat" u ($1):($2) title "Theoretical" w l ls 2 ,\
     "lognormal_1D_Lc1_ex.dat" u ($1):($3) notitle w p ls 1 lw 1,\
     "lognormal_1D_Lc1_ex__SingleRea_1.dat" u ($1):($3) title 'One realization' w l ls 13

set output "./figures/elkc_exp_1D_lognormal_1.eps"
set ylabel "Specific size $\\SpS$" rotate by 90
set key b r
plot "lognormal_1D_Lc1_ex.dat" u ($1):($5):($7) title "Experimental"  w filledcu ls 1 ,\
     "lognormal_1D_Lc1_ex.dat" u ($1):($5) notitle w l ls 1 ,\
     "lognormal_1D_Lc1_ex.dat" u ($1):($7) notitle w l ls 1 ,\
     "lognormal_1D_Lc1_th.dat" u ($1):($3) title "Theoretical" w l ls 2 ,\
     "lognormal_1D_Lc1_ex.dat" u ($1):($6) notitle w p ls 1,\
     "lognormal_1D_Lc1_ex__SingleRea_1.dat" u ($1):($6) title 'One realization' w l ls 13


set output


