set term epslatex

#SET LINE STYLE
set style line 1 lt 1 lw 2 pt 1 ps 0.5 lc rgb "#0060ad" #--blue
set style line 2 lt 1 lw 2 pt 1 ps 0.5 lc rgb "#dd181f" #--red
set style line 3 lt 1 lw 2 pt 1 ps 0.5 lc rgb "#008800" #--green
set style line 4 lt 1 lw 2 pt 1 ps 0.5 lc rgb "#00aabb" #--blue light
set style line 5 lt 1 lw 2 pt 1 ps 0.5 lc rgb "#ff5500" #--orange
set style line 6 lt 1 lw 2 pt 1 ps 0.5 lc rgb "#bb0088" #--purple
set style line 7 lt 1 lw 2 pt 1 ps 0.5 lc rgb "#346D3D" #--purple
set style line 9 lt 1 lw 2 pt 1 ps 0.5 lc rgb "#FFFFF" #--black


set style line 11 lt 2 lw 2 pt 1 ps 0.5 lc rgb "#0060ad" #--blue
set style line 12 lt 2 lw 2 pt 1 ps 0.5 lc rgb "#dd181f" #--red
set style line 13 lt 2 lw 2 pt 1 ps 0.5 lc rgb "#008800" #--green

set style line 21 lt 3 lw 2 pt 1 ps 0.5 lc rgb "#0060ad" #--blue
set style line 22 lt 3 lw 2 pt 1 ps 0.5 lc rgb "#dd181f" #--red
set style line 23 lt 3 lw 2 pt 1 ps 0.5 lc rgb "#008800" #--green


#SET AXES
#set border
#set key t r
unset key
set xzeroaxis
set yzeroaxis


set xlabel "$\\lset$"
set xtics nomirror
set ytics nomirror



set xrange [0.001:100]
set logscale x

set ylabel "Euler characteristic" rotate by 90

set output "./figures/size_effect_2D_different_Euler_behaviors_l0.001.eps"
plot "size_effect_2D_different_Euler_behaviors_l0.001.dat" u ($1):($2) notitle "Theoretical" w l ls 1 

# line at value 1
set arrow from 0.001,1 to 100,1 ls 12 nohead

set output "./figures/size_effect_2D_different_Euler_behaviors_l0.8.eps"
plot "size_effect_2D_different_Euler_behaviors_l0.8.dat" u ($1):($2) notitle "Theoretical" w l ls 1 

set output "./figures/size_effect_2D_different_Euler_behaviors_l2.5.eps"
plot "size_effect_2D_different_Euler_behaviors_l2.5.dat" u ($1):($2) notitle "Theoretical" w l ls 1 

set output "./figures/size_effect_2D_different_Euler_behaviors_l8.eps"
plot "size_effect_2D_different_Euler_behaviors_l8.dat" u ($1):($2) notitle "Theoretical" w l ls 1 



set output


