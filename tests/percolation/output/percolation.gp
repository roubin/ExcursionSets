#set term epslatex;
set term postscrip eps color;


#SET LINE STYLE
set style line 1 lt 1 lw 4 pt 2 pi 0 ps 1 lc rgb '#0060ad' #--blue
set style line 2 lt 2 lw 4 pt 5 pi 0 ps 1 lc rgb '#dd181f' #--red
set style line 3 lt 5 lw 4 pt 9 pi 0 ps 1.3 lc rgb '#008800' #--green
set style line 9 lt 9 lw 2 pt 9 pi 0 ps 1 lc rgb '#444444' #--gray

set xzeroaxis
set yzeroaxis

set xlabel 'Scale ratio $\rlinv = \Msize/\Lc$'
set ylabel 'Critical percolation fraction volume $\Vfc$'

set xrange [1:1e3]
set yrange [0:1.05]
set logscale x
set key b r


set output './figures/percolation_3D.eps'
set ytics add ('0.1587' 0.1587, '0.8413' 0.8413)
set label 1 at 100,0.5 "$\EC<0" 
set label 2 at 1.5,0.95 "$\EC>0" 
set label 3 at 2,0.3 "$\EC>0" 
plot 0.1587 notitle w l ls 9, 0.8413 notitle w l ls 9,\
     'percolation_3D.dat'  u ($1):($5)  title '\Vfc(\lsetPm)' w l ls 1,\
     'percolation_3D.dat'  u ($1):($3)  title '\Vfc(\lsetPp)' w l ls 2


set output './figures/percolation_2D.eps'
unset ytics
set yrange [0.4:1.05]
set ytics
set ylabel 'Critical percolation fraction surface $\Vfc$'

set ytics add ('0.5' 0.5)
set label 1 at 100,0.8 "$\EC<0" 
set label 2 at 1.5,0.95 "$\EC>0" 
set label 3 at 4,0.6 "$\EC>0" 
plot 0.5 notitle w l ls 9, 1 notitle w l ls 9,\
     'percolation_2D.dat'  u ($1):($5)  title '\Vfc(\lsetPm)' w l ls 1,\
     'percolation_2D.dat'  u ($1):($3)  title '\Vfc(\lsetPp)' w l ls 2



set output
