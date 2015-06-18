%% Initial
clear all; addpath('../../routines');

x=f_set_thresholds(-3,6,0.11);
h=@(j) f_probabilistic_hermite_polynomials(j,x);


figure(1);
plot(x, [h(0) h(1) h(2) h(3) h(4) h(5)], [0 0], [-10 20], '--k', [-3 6], [0 0], '--k');
axis([-3 6 -10 20]); legend('H0','H1','H2','H3','H4','H5')