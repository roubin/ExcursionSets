%% Initial
clear all; addpath('../../routines');
input_file_folder='input';

%% 
input_file_name='lognormal_cumulative.es';
p=f_read_input(input_file_folder, input_file_name);
p=f_set_gauss_parameter(p);
p.hitting_set.thresholds=f_set_thresholds(-4,4,0.01, 'log10');

gmf= @(k) f_gaussian_minkowski_functionals(k,p.rf_distribution,p.hitting_set);
dgmf=@(k) f_gaussian_minkowski_functionals_derivatives(k,p.rf_distribution,p.hitting_set);

figure(1); semilogx(p.hitting_set.thresholds, [gmf(0) dgmf(0)], [0 1], [0 0], 'k'); legend('gmf0','dgmf0');
figure(2); semilogx(p.hitting_set.thresholds, [gmf(1) dgmf(1)], [0 1], [0 0], 'k'); legend('gmf1','dgmf1');
figure(3); semilogx(p.hitting_set.thresholds, [gmf(2) dgmf(2)], [0 1], [0 0], 'k'); legend('gmf2','dgmf2');
figure(4); semilogx(p.hitting_set.thresholds, [gmf(3) dgmf(3)./30], [0 0.1], [0 0], 'k'); legend('gmf3','dgmf3');

%% find maximums
input_file_name='lognormal_cumulative.es';
p=f_read_input(input_file_folder, input_file_name);
p=f_set_gauss_parameter(p);
p.hitting_set.thresholds=f_set_thresholds(-4,4,0.01, 'log10');

gmf= @(k) f_gaussian_minkowski_functionals(k,p.rf_distribution,p.hitting_set);
gmfx= @(k,x) f_gaussian_minkowski_functionals(k,p.rf_distribution, struct('type', p.hitting_set.type, 'thresholds', x));

dgmf=@(k,x) f_gaussian_minkowski_functionals_derivatives(k,p.rf_distribution,struct('type', p.hitting_set.type, 'thresholds', x));
x1 =fzero(@(x) dgmf(1,x),[0.0001 5]);
x21=fzero(@(x) dgmf(2,x),[0.0001 0.1]); x22=fzero(@(x) dgmf(2,x),[x21+0.001 5]);
x31=fzero(@(x) dgmf(3,x),[0.0001,0.05]); x32=fzero(@(x) dgmf(3,x),[x31+0.001 0.5]); x33=fzero(@(x) dgmf(3,x),[x32+0.001 5]);

figure(2); semilogx(p.hitting_set.thresholds, gmf(1), [0 5], [0 0], 'k', x1, gmfx(1,x1),'r+'); legend('gmf1');
figure(3); semilogx(p.hitting_set.thresholds, gmf(2), [0 5], [0 0], 'k', x21, gmfx(2,x21),'r+', x22, gmfx(2,x22),'r+'); legend('gmf2');
figure(4); semilogx(p.hitting_set.thresholds, gmf(3), [0 0.1], [0 0], 'k', x31, gmfx(3,x31),'r+', x32, gmfx(3,x32),'r+', x33, gmfx(3,x33),'r+'); legend('gmf3');

