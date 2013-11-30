%% Initial
clear all; addpath('../../routines');

%% th ELKC and derivatives
input_file_folder='.'; input_file_name='gaussian_1D.es';
p=f_read_input(input_file_folder, input_file_name);
p.hitting_set.thresholds=f_set_thresholds(-5,5,0.01);

elkc=@(j) f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, p.hitting_set);
delkc=@(j) f_elkc_derivatives(j, p.geometrical, p.rf_distribution, p.rf_correlation, p.hitting_set);

%% Plot
figure(1); plot(p.hitting_set.thresholds,[elkc(1) delkc(1)], [-5 5], [0 0], '--k', [0 0], [0 100], '--k');
figure(2); plot(p.hitting_set.thresholds,[elkc(0) delkc(0)], [-5 5], [0 0], '--k', [0 0], [-2 6], '--k');
