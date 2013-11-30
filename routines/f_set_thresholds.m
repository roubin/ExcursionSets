function thresholds=f_set_thresholds(min_value,max_value,delta_value, varargin)

if(nargin==4)
    switch varargin{1}
        case 'log10'            
            thresholds=10.^transpose(min_value:delta_value:max_value);
        otherwise
        thresholds=transpose(min_value:delta_value:max_value);
        warning('Set threshold option unknown.')
    end
else
    thresholds=transpose(min_value:delta_value:max_value);
end



end
