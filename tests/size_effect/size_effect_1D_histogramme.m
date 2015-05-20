%% Initial
clear all; addpath('../../routines');
input_file_folder='input';
output_file_folder='output';

%% th ELKC
input_file_name='lognormal_1D.es';
p=f_read_input(input_file_folder, input_file_name); p=f_set_gauss_parameter(p);


lengths=f_set_thresholds(-8, 3, 0.1, 'log10');
for l=1:size(lengths,1)
    p.geometrical.size=lengths(l,1);    
    p.hitting_set.thresholds=f_set_thresholds(-5, 3, 0.01, 'log10');
    th_elkc= @(j,hs) f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, hs);
    th_delkc=@(j,hs) f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, hs, 'derivative');

    %display(['Size=' num2str(p.geometrical.size)])
    
    %% FIND MAX
    tabtresh=p.hitting_set.thresholds;
    tabeuler=f_elkc(0, p.geometrical, p.rf_distribution, p.rf_correlation, p.hitting_set);
    [maxtab, mintab]=peakdet(tabeuler, 1e-14, tabtresh);
    if(size(maxtab)>0);
        
        %% FIND FIRST ONE
        th_elkc_one =@(t) f_elkc(0, p.geometrical, p.rf_distribution, p.rf_correlation, struct('type',p.hitting_set.type,'thresholds',t))-1.0;
        [x_01, y_01]=fzero(th_elkc_one,[min(tabtresh) maxtab(1,1)]);
        
        %% RERANGE
        p.hitting_set.thresholds=f_set_thresholds(-5, log10(x_01), 0.0001, 'log10');
        
    end
    
    tabdif_y=diff([0; th_elkc(0,p.hitting_set)]);
    tabdif_x=diff([0; p.hitting_set.thresholds]);
    tabdif=tabdif_y./tabdif_x;
    
    %tabint=zeros(size(p.hitting_set.thresholds));
    %for i=1:size(p.hitting_set.thresholds,1)
    %    integ=@(t) f_elkc(0, p.geometrical, p.rf_distribution, p.rf_correlation, struct('type',p.hitting_set.type,'thresholds',t), 'derivative');
    %    tabint(i)=integral(integ,0,max(p.hitting_set.thresholds(1:i)));
    %end
    %% PLOT
    %figure(1); semilogx(p.hitting_set.thresholds,th_elkc(1,p.hitting_set));
    %figure(2); semilogx(p.hitting_set.thresholds,th_elkc(0,p.hitting_set), '-*',p.hitting_set.thresholds,tabint, '-*');
    %figure(1); semilogx(p.hitting_set.thresholds,th_delkc(0,p.hitting_set), '-*', p.hitting_set.thresholds, tabdif);
    figure(1); plot(p.hitting_set.thresholds, tabdif, '-*');
    %xlim([10^(-3) 10^3])
    %ylim([0 max(th_delkc(0,p.hitting_set))])
end

