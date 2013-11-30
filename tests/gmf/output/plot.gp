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
set key t r
set xzeroaxis
set yzeroaxis


set xlabel "$\\lset$"
set xtics nomirror
set ytics nomirror

#set yrange [0:8000]
set xrange [-5:5]

#set term postscrip eps color; set output "./figures/gmf_gaussian_tail.eps";
set term epslatex; set output "./figures/gmf_gaussian_tail.eps"
set ylabel "$\\GMFa_j(\\HST)$" rotate by 90
plot "gaussian_tail.dat" u ($1):(0.25*$2) title "$j=0$ ($\\bullet/4$)" w l ls 1 ,\
     "gaussian_tail.dat" u ($1):($3) title "$j=1$" w l ls 2 ,\
     "gaussian_tail.dat" u ($1):($4) title "$j=2$" w l ls 3, \
     "gaussian_tail.dat" u ($1):($5) title "$j=3$" w l ls 4, \
     "gaussian_tail.dat" u ($1):($6) title "$j=4$" w l ls 5


set term epslatex; set output "./figures/gmf_gaussian_cumulative.eps"
set ylabel "$\\GMFa_j(\\HSC)$" rotate by 90
set key t l
plot "gaussian_cumulative.dat" u ($1):(0.25*$2) title "$j=0$ ($\\bullet/4$)" w l ls 1 ,\
     "gaussian_cumulative.dat" u ($1):($3) title "$j=1$" w l ls 2 ,\
     "gaussian_cumulative.dat" u ($1):($4) title "$j=2$" w l ls 3, \
     "gaussian_cumulative.dat" u ($1):($5) title "$j=3$" w l ls 4 ,\
     "gaussian_cumulative.dat" u ($1):($6) title "$j=4$" w l ls 5



set xrange [1e-3:20]
set logscale x
set term epslatex; set output "./figures/gmf_lognormal_tail.eps"
set ylabel "$\\GMFa_j(\\HST)$" rotate by 90
set key t r
plot "lognormal_tail.dat" u ($1):(0.25*$2) title "$j=0$ ($\\bullet/4$)" w l ls 1 ,\
     "lognormal_tail.dat" u ($1):($3) title "$j=1$" w l ls 2 ,\
     "lognormal_tail.dat" u ($1):($4) title "$j=2$" w l ls 3, \
     "lognormal_tail.dat" u ($1):($5) title "$j=3$" w l ls 4, \
     "lognormal_tail.dat" u ($1):($6) title "$j=4$" w l ls 5


set term epslatex; set output "./figures/gmf_lognormal_cumulative.eps"
set ylabel "$\\GMFa_j(\\HSC)$" rotate by 90
set key t l
plot "lognormal_cumulative.dat" u ($1):(0.25*$2) title "$j=0$ ($\\bullet/4$)" w l ls 1 ,\
     "lognormal_cumulative.dat" u ($1):($3) title "$j=1$" w l ls 2 ,\
     "lognormal_cumulative.dat" u ($1):($4) title "$j=2$" w l ls 3, \
     "lognormal_cumulative.dat" u ($1):($5) title "$j=3$" w l ls 4 ,\
     "lognormal_cumulative.dat" u ($1):($6) title "$j=4$" w l ls 5



set output
