%% Initial
clear all; addpath('../../routines');
input_file_folder='input';

%% 
input_file_name='gaussian_tail.es';
p=f_read_input(input_file_folder, input_file_name);
p.hitting_set.thresholds=f_set_thresholds(-5,5,0.01);

gmf= @(k) f_gaussian_minkowski_functionals(k,p.rf_distribution,p.hitting_set);
dgmf=@(k) f_gaussian_minkowski_functionals_derivatives(k,p.rf_distribution,p.hitting_set);

%% Plot
figure(1); plot(p.hitting_set.thresholds, [gmf(0) dgmf(0)], [-5 5], [0 0], 'k'); legend('gmf0','dgmf0');
figure(2); plot(p.hitting_set.thresholds, [gmf(1) dgmf(1)], [-5 5], [0 0], 'k'); legend('gmf1','dgmf1');
figure(3); plot(p.hitting_set.thresholds, [gmf(2) dgmf(2)], [-5 5], [0 0], 'k'); legend('gmf2','dgmf2');
figure(4); plot(p.hitting_set.thresholds, [gmf(3) dgmf(3)], [-5 5], [0 0], 'k'); legend('gmf3','dgmf3');
