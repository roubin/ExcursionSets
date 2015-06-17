%% Initial
clear all; addpath('../../routines');
input_file_folder='input';
output_file_folder='output';

%% th ELKC
input_file_name='gaussian_4D.es';
p=f_read_input(input_file_folder, input_file_name);

th_elkc=@(j,hs) f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, hs);

%% Plot
p.hitting_set.thresholds=f_set_thresholds(-6,6,0.1);
figure(1); plot(p.hitting_set.thresholds,th_elkc(4,p.hitting_set));
figure(2); plot(p.hitting_set.thresholds,th_elkc(3,p.hitting_set));
figure(3); plot(p.hitting_set.thresholds,th_elkc(2,p.hitting_set));
figure(4); plot(p.hitting_set.thresholds,th_elkc(1,p.hitting_set));
figure(5); plot(p.hitting_set.thresholds,th_elkc(0,p.hitting_set));


% Gnuplot Output
%output_file_name=[p.rf_distribution.type '_' num2str(p.geometrical.spatial_dimension) 'D_Lc' num2str(p.rf_correlation.correlation_length) '_' num2str(p.geometrical.sizeX) 'x' num2str(p.geometrical.sizeY) 'x' num2str(p.geometrical.sizeZ) '_th.dat'];
%txt1=['Theoretical ELKC ' num2str(p.geometrical.spatial_dimension) 'D with distribution=' p.rf_distribution.type ', hitting set= ' num2str(p.hitting_set.type) ' mean=' num2str(p.rf_distribution.mean) ', v=' num2str(p.rf_distribution.variance) ', Lc=' num2str(p.rf_correlation.correlation_length) ' in a cube of size ' num2str(p.geometrical.sizeX) 'x' num2str(p.geometrical.sizeY) 'x' num2str(p.geometrical.sizeZ) '.'];
output_file_name=[p.rf_distribution.type '_' num2str(p.geometrical.spatial_dimension) 'D_Lc' num2str(p.rf_correlation.correlation_length) '_l' num2str(p.geometrical.size) '_th.dat'];
txt1=['Theoretical ELKC ' num2str(p.geometrical.spatial_dimension) 'D with distribution=' p.rf_distribution.type ', hitting set= ' num2str(p.hitting_set.type) ' mean=' num2str(p.rf_distribution.mean) ', v=' num2str(p.rf_distribution.variance) ', Lc=' num2str(p.rf_correlation.correlation_length) ' in a cube of size ' num2str(p.geometrical.size) '.'];
txt2='threshold ELKC0 ELKC1 ELKC2 ELKC3';
f_write_gnuplot_output(output_file_folder, output_file_name, p.hitting_set.thresholds, [th_elkc(0, p.hitting_set), th_elkc(1, p.hitting_set), th_elkc(2, p.hitting_set), th_elkc(3, p.hitting_set)], txt1, txt2);
