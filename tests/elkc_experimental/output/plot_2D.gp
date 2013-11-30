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

set term epslatex;
set output "./figures/elkc_exp_2D_gaussian_0.eps"
set ylabel "Euler characteristic" rotate by 90
set key t l
plot "gaussian_2D_Lc5_ex.dat" u ($1):($2):($4) title "Experimental" w filledcu ls 11 ,\
     "gaussian_2D_Lc5_ex.dat" u ($1):($2) notitle w l ls 11 ,\
     "gaussian_2D_Lc5_ex.dat" u ($1):($4) notitle w l ls 11 ,\
     "gaussian_2D_Lc5_th.dat" u ($1):($2) title "Theoretical" w l ls 2 ,\
     "gaussian_2D_Lc5_ex.dat" u ($1):($3) notitle w p ls 11

set output "./figures/elkc_exp_2D_gaussian_1.eps"
set ylabel "Half diameter" rotate by 90
set key t r
plot "gaussian_2D_Lc5_th.dat" u ($1):($3) title "Theoretical" w l ls 2

set output "./figures/elkc_exp_2D_gaussian_2.eps"
set ylabel "Surface area" rotate by 90
set key t r
plot "gaussian_2D_Lc5_ex.dat" u ($1):($8):($10) title "Experimental"  w filledcu ls 11 ,\
     "gaussian_2D_Lc5_ex.dat" u ($1):($8) notitle w l ls 11 ,\
     "gaussian_2D_Lc5_ex.dat" u ($1):($10) notitle w l ls 11 ,\
     "gaussian_2D_Lc5_th.dat" u ($1):($4) title "Theoretical" w l ls 2 ,\
     "gaussian_2D_Lc5_ex.dat" u ($1):($9) notitle w p ls 11


set logscale x

set term epslatex;
set output "./figures/elkc_exp_2D_lognormal_0.eps"
set ylabel "Euler characteristic" rotate by 90
set key t r
plot "lognormal_2D_Lc5_ex.dat" u ($1):($2):($4) title "Experimental" w filledcu ls 11 ,\
     "lognormal_2D_Lc5_ex.dat" u ($1):($2) notitle w l ls 11 ,\
     "lognormal_2D_Lc5_ex.dat" u ($1):($4) notitle w l ls 11 ,\
     "lognormal_2D_Lc5_th.dat" u ($1):($2) title "Theoretical" w l ls 2 ,\
     "lognormal_2D_Lc5_ex.dat" u ($1):($3) notitle w p ls 11

set output "./figures/elkc_exp_2D_lognormal_1.eps"
set ylabel "Half diameter" rotate by 90
set key t r
plot "lognormal_2D_Lc5_th.dat" u ($1):($3) title "Theoretical" w l ls 2

set output "./figures/elkc_exp_2D_lognormal_2.eps"
set ylabel "Surface area" rotate by 90
set key t l
plot "lognormal_2D_Lc5_ex.dat" u ($1):($8):($10) title "Experimental"  w filledcu ls 11 ,\
     "lognormal_2D_Lc5_ex.dat" u ($1):($8) notitle w l ls 11 ,\
     "lognormal_2D_Lc5_ex.dat" u ($1):($10) notitle w l ls 11 ,\
     "lognormal_2D_Lc5_th.dat" u ($1):($4) title "Theoretical" w l ls 2 ,\
     "lognormal_2D_Lc5_ex.dat" u ($1):($9) notitle w p ls 11



set output


