#SET LINE STYLE
set style line 1 lt 1 lw 7 pt 2 pi 0 ps 1 lc rgb '#0060ad' #--blue
set style line 2 lt 2 lw 7 pt 5 pi 0 ps 1 lc rgb '#dd181f' #--red
set style line 3 lt 3 lw 7 pt 9 pi 0 ps 1.3 lc rgb '#008800' #--green
set style line 9 lt 9 lw 2 pt 9 pi 0 ps 1 lc rgb '#444444' #--gray

#set term epslatex;
set term postscrip eps color;

set xzeroaxis
set yzeroaxis

set xlabel 'Scale ratio $\rlinv = \Msize/\Lc$'
set ylabel 'Critical probability of percolation $\Vfc$'

set xrange [1:1e3]
set yrange [0:1.05]
set logscale x
set key b r



set output './figures/percolation_critical_probabilities_4D.eps'
set ytics add ('' 0.1587, '' 0.8413)
set label 1 at 100,0.5 '$\EC<0$'
set label 2 at 50,0.95 '$\EC>0$' 
set label 3 at 2,0.3 '$\EC>0$' 
set label 4 at 270,0.185 '0.1587\dots'
set label 5 at 270,0.805 '0.8413\dots'
plot 0.1587 notitle w l ls 9, 0.8413 notitle w l ls 9,\
     'percolation_4D_roots12.dat'  u ($1):($5)  title '$\Vfc(\lsetPm)$' w l ls 1,\
     'percolation_4D_roots12.dat'  u ($1):($3)  title '$\Vfc(\lsetPp)$' w l ls 2


set output './figures/percolation_critical_probabilities_3D.eps'
set ytics add ('' 0.1587, '' 0.8413)
set label 1 at 100,0.5 '$\EC<0$'
set label 2 at 50,0.95 '$\EC>0$' 
set label 3 at 2,0.3 '$\EC>0$' 
set label 4 at 270,0.185 '0.1587\dots'
set label 5 at 270,0.805 '0.8413\dots'
plot 0.1587 notitle w l ls 9, 0.8413 notitle w l ls 9,\
     'percolation_3D.dat'  u ($1):($5)  title '$\Vfc(\lsetPm)$' w l ls 1,\
     'percolation_3D.dat'  u ($1):($3)  title '$\Vfc(\lsetPp)$' w l ls 2


set output './figures/percolation_critical_probabilities_2D.eps'
unset ytics
set yrange [0.4:1.05]
set ytics
set ytics add ('0.5' 0.5)
set label 1 at 100,0.8 '$\EC<0$' 
set label 2 at 1.5,0.95 '$\EC>0$' 
set label 3 at 4,0.6 '$\EC>0$' 
unset label 4
unset label 5
plot 0.5 notitle w l ls 9, 1 notitle w l ls 9,\
     'percolation_2D.dat'  u ($1):($5)  title '$\Vfc(\lsetPm)$' w l ls 1,\
     'percolation_2D.dat'  u ($1):($3)  title '$\Vfc(\lsetPp)$' w l ls 2



set output
