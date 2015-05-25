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


set term epslatex;

set xrange [0.01:1000]
set logscale x

set output "./figures/elkc_1D_lognormal_0.eps"
set ylabel "Euler characteristic" rotate by 90
plot "lognormal_1D_Lc1_T5_th.dat" u ($1):($2) title "$\\rlinv=5$" w l ls 1 lw 2,\
     "lognormal_1D_Lc1_T1_th.dat" u ($1):($2) title "$\\rlinv=5$" w l ls 2 lw 2,\
     "lognormal_1D_Lc1_T0.1_th.dat" u ($1):($2) title "$\\rlinv=5$" w l ls 3 lw 2



set output


