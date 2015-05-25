%% Initial
clear all; addpath('../../routines');

%% th ELKC
input_file_folder='input'; input_file_name='lognormal_1D.es';
p=f_read_input(input_file_folder, input_file_name);

p.rf_distribution.rmean;
p.rf_distribution.rvariance;
p=f_set_gauss_parameter(p);


lengths=f_set_thresholds(-2, 3, 0.1, 'log10');
thresh_max=zeros(size(lengths));
euler_max=zeros(size(lengths));

for l=1:size(lengths,1)
    p.geometrical.size=lengths(l,1);
    th_elkc=@(j,hs) f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, hs);
    
    %% Plot
    p.hitting_set.thresholds=f_set_thresholds(0.01,5,0.01);
    %figure(1); plot(p.hitting_set.thresholds,th_elkc(1,p.hitting_set));
    %figure(2); plot(p.hitting_set.thresholds,th_elkc(0,p.hitting_set));
    
    
    %% find maximum
    s=sqrt(p.rf_distribution.variance); mu=p.rf_distribution.mean; beta=p.geometrical.size/p.rf_correlation.correlation_length;
    x_max=exp(s*sqrt(pi)/beta+mu); hs=p.hitting_set; hs.thresholds=x_max;
    y_max=th_elkc(0,hs);
    display(['Find maximum value of LKC0: x_max=' num2str(x_max) ' y_max=' num2str(y_max)])
    
    semilogx(p.hitting_set.thresholds,th_elkc(0,p.hitting_set), x_max, y_max, '+');
    thresh_max(l,1)=x_max;
    euler_max(l,1)=y_max;
end
loglog(lengths, thresh_max)

% Gnuplot Output
output_file_folder='.'; output_file_name=['size_effect_1D_max_m' num2str(p.rf_distribution.rmean) '_v' num2str(p.rf_distribution.rvariance) '.dat'];
f_write_gnuplot_output(output_file_folder, output_file_name, lengths, [thresh_max, euler_max]);
