%% Initial
clear all; addpath('../../routines');
input_file_folder='input';

%% th ELKC and derivatives
input_file_name='gaussian_2D.es';
p=f_read_input(input_file_folder, input_file_name);
p.hitting_set.thresholds=f_set_thresholds(-5,5,0.01);

elkc=@(j) f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, p.hitting_set);
delkc=@(j) f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, p.hitting_set, 'derivative');

%% Plot
figure(1); plot(p.hitting_set.thresholds,[elkc(2) delkc(2)], [-5 5], [0 0], '--k', [0 0], [-4000 10000], '--k');
figure(2); plot(p.hitting_set.thresholds,[elkc(1) delkc(1)], [-5 5], [0 0], '--k', [0 0], [-400 1000], '--k');
figure(3); plot(p.hitting_set.thresholds,[elkc(0) delkc(0)], [-5 5], [0 0], '--k', [0 0], [-30 40], '--k');
