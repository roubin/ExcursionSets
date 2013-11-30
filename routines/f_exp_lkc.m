function lkc=f_exp_lkc(random_fields, hitting_set, varargin)

display('---> Experimental Calculation of LKC')
display(' ')

if(nargin==3 && strcmp(varargin{1}, 'skipEC'))
    skipl0=true;
else
    skipl0=false;
end


thresholds=hitting_set.thresholds;

if(~skipl0)
    display('     --> Calculating LKC...')
else
    display('     --> Calculating LKC (skipping LKC0)...')
end
n_thresholds=size(thresholds,1);
rf_dimension=random_fields.Dimension;
rf_size=random_fields.Size;
n_rea=random_fields.NRealisations;
n_points=random_fields.NPoints;
display(['         Hitting set: ' hitting_set.type])
display(['         Number of thresholds: ' num2str(n_thresholds)])
switch rf_dimension
    case 1
        lkc=struct('ELKC0',zeros(n_thresholds,3),'ELKC1',zeros(n_thresholds,3), 'LKC0',zeros(n_thresholds,n_rea),'LKC1',zeros(n_thresholds,n_rea));        
        for i_threshold=1:n_thresholds
            display(['         Threshold number ' num2str(i_threshold) '/' num2str(n_thresholds)])
            for i_rea=1:n_rea
                switch hitting_set.type
                    case 'tail'
                        points_in=find(random_fields.Values(:,i_rea)>thresholds(i_threshold));
                    case 'cumulative'
                        points_in=find(random_fields.Values(:,i_rea)<thresholds(i_threshold));
                    otherwise
                        error(['Hitting set ' hitting_set.type ' is not implemented yet.]'])
                end
                n_points_in=size(points_in,1);
                lkc.LKC1(i_threshold,i_rea)=rf_size*n_points_in./n_points;
                if(~skipl0)
                    n_seg_in=0;
                    for j=1:n_points_in
                        if(find((points_in(j)-1)==points_in))
                            n_seg_in=n_seg_in+1;
                        end
                    end
                    lkc.LKC0(i_threshold,i_rea)=n_points_in-n_seg_in;
                end
            end
            lkc.ELKC1(i_threshold,1)=min(lkc.LKC1(i_threshold,:));
            lkc.ELKC1(i_threshold,2)=mean(lkc.LKC1(i_threshold,:));
            lkc.ELKC1(i_threshold,3)=max(lkc.LKC1(i_threshold,:));
            if(~skipl0)
                lkc.ELKC0(i_threshold,1)=min(lkc.LKC0(i_threshold,:));
                lkc.ELKC0(i_threshold,2)=mean(lkc.LKC0(i_threshold,:));
                lkc.ELKC0(i_threshold,3)=max(lkc.LKC0(i_threshold,:));
                fid=fopen('./output_f_exp_lkc0.dat', 'w');
                fprintf(fid,'%f %f %f %f\n', [thresholds lkc.ELKC0].');
                fclose(fid);
            end
        end
        
    case 2 % WARNING in 2D points_in is defined by and array of 1 and 0
        lkc=struct('ELKC0',zeros(n_thresholds,3),'ELKC1',zeros(n_thresholds,3), 'ELKC2',zeros(n_thresholds,3), 'LKC0',zeros(n_thresholds,n_rea), 'LKC1',zeros(n_thresholds,n_rea), 'LKC2',zeros(n_thresholds,n_rea));        
        for i_threshold=1:n_thresholds
            display(['         Threshold number ' num2str(i_threshold) '/' num2str(n_thresholds)])
            for i_rea=1:n_rea
                switch hitting_set.type
                    case 'tail'
                        points_in=random_fields.Values(:,i_rea)>thresholds(i_threshold);
                    case 'cumulative'
                        points_in=random_fields.Values(:,i_rea)<thresholds(i_threshold);
                    otherwise
                        error(['Hitting set ' hitting_set.type ' is not implemented yet.]'])
                end
                n_points_in=sum(points_in,1);
                lkc.LKC2(i_threshold,i_rea)=rf_size.^2*n_points_in./n_points;

                if(~skipl0)
                    S=0; % number of vertices
                    A=0; % number of edges
                    F=0; % number of faces 
                    N=round(n_points^(1/2));
                    for a2=1:N
                        for a1=1:N
                            % p   status the current point
                            % px  status the next point following x
                            % py  status the next point following y
                            % pxy status the next point following x&y
                            p=points_in(a1+N*(a2-1));
                            S=S+p; % add vertice
                            if(p)
                                if(a1<N) % check x border and add edge
                                    px=points_in(a1+N*(a2-1)+1); 
                                    A=A+px;
                                end
                                if(a2<N) % check y border and add edge
                                    py=points_in(a1+N*a2);
                                    A=A+py;
                                end
                                if((a1<N)&&(a2<N)) % check x&y border and add face
                                    pxy=points_in(a1+N*a2+1);
                                    F=F+(p*px*py*pxy);
                                end
                            end
                        end
                    end
                    lkc.LKC0(i_threshold,i_rea)=S-A+F;
                end
            end
            lkc.ELKC2(i_threshold,1)=min(lkc.LKC2(i_threshold,:));
            lkc.ELKC2(i_threshold,2)=mean(lkc.LKC2(i_threshold,:));
            lkc.ELKC2(i_threshold,3)=max(lkc.LKC2(i_threshold,:));
            if(~skipl0)
                lkc.ELKC0(i_threshold,1)=min(lkc.LKC0(i_threshold,:));
                lkc.ELKC0(i_threshold,2)=mean(lkc.LKC0(i_threshold,:));
                lkc.ELKC0(i_threshold,3)=max(lkc.LKC0(i_threshold,:));
                fid=fopen('./output_f_exp_lkc0.dat', 'w');
                fprintf(fid,'%f %f %f %f\n', [thresholds lkc.ELKC0].');
                fclose(fid);
            end    
        end
        
    otherwise
        error(['Experimental calculation of LKC are not implemented for spatial dimension ' num2str(rf_dimension) '.'])
end

end
