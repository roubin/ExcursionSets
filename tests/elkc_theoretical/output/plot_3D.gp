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


set xzeroaxis
set yzeroaxis


set xlabel "$\\lset$"
set xtics nomirror
set ytics nomirror

set xrange [-5:5]

set style fill transparent solid 0.2

plot "gaussian_3D_Lc5_100x10x10_th.dat" u ($1):($2); max_A = GPVAL_DATA_Y_MAX
plot "gaussian_3D_Lc5_200x20x20_th.dat" u ($1):($2); max_B = GPVAL_DATA_Y_MAX
plot "gaussian_3D_Lc5_400x40x40_th.dat" u ($1):($2); max_C = GPVAL_DATA_Y_MAX


set term epslatex;
set output "./figures/elkc_th_3D_gaussian_0_constant_ratio.eps"
set ylabel "Euler characteristic" rotate by 90
set key b r
plot "gaussian_3D_Lc5_100x10x10_th.dat" u ($1):($2/max_A) title "$100\\times 10\\times 10$" w l ls 1,\
     "gaussian_3D_Lc5_200x20x20_th.dat" u ($1):($2/max_B) title "$200\\times 20\\times 20$" w l ls 2,\
     "gaussian_3D_Lc5_400x40x40_th.dat" u ($1):($2/max_C) title "$400\\times 40\\times 40$" w l ls 3



set output

set term unknown;
plot "gaussian_3D_Lc5_10x10x10_th.dat"   u ($1):($2); max_A = GPVAL_DATA_Y_MAX
plot "gaussian_3D_Lc5_100x10x10_th.dat"  u ($1):($2); max_B = GPVAL_DATA_Y_MAX
plot "gaussian_3D_Lc5_1000x10x10_th.dat" u ($1):($2); max_C = GPVAL_DATA_Y_MAX

set term epslatex;
set output "./figures/elkc_th_3D_gaussian_0_constant_area.eps"
set ylabel "Euler characteristic" rotate by 90
set key b r
plot "gaussian_3D_Lc5_10x10x10_th.dat"   u ($1):($2/max_A) title "$10\\times 10\\times 10$"   w l ls 1,\
     "gaussian_3D_Lc5_100x10x10_th.dat"  u ($1):($2/max_B) title "$100\\times 10\\times 10$"  w l ls 2,\
     "gaussian_3D_Lc5_1000x10x10_th.dat" u ($1):($2/max_C) title "$1000\\times 10\\times 10$" w l ls 3



set output


