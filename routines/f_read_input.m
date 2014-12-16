function parameters=f_read_input(file_folder, file_name)

display(['---> Reading parameter file: ' file_folder '/' file_name])
display(' ')

parameters=struct();

%% Read datafile
comment='%'; % comment line start with
delimiter='->'; % delimitation between "type" and "field" and between "field" and "value"

fid = fopen([file_folder '/' file_name]);
data=textscan(fid, '%s %s %s\n', 'CommentStyle',comment,'Delimiter',delimiter,'MultipleDelimsAsOne',1);
fclose(fid);

%% Set parameter for each non commented line
number_of_lines=size(data{1},1);
for i_line=1:number_of_lines    
  param_type=strrep(data{1}{i_line},' ','');
  param_field=strrep(data{2}{i_line},' ','');    
  param_value=strrep(data{3}{i_line},' ','');
    
  switch param_type
    %% geometrical parameters
   case 'geometrical'
    switch param_field
     case 'spatial_dimension'                    
      parameters.geometrical.spatial_dimension=uint16(str2double(param_value));
     case 'specimen'                    
      parameters.geometrical.specimen=param_value;
     case 'size'                    
      parameters.geometrical.size=str2double(param_value);
     case 'sizeX'                    
      parameters.geometrical.sizeX=str2double(param_value);
     case 'sizeY'                    
      parameters.geometrical.sizeY=str2double(param_value);
     case 'sizeZ'                    
      parameters.geometrical.sizeZ=str2double(param_value);
     otherwise
      warning(['Parameter field "' param_type '.' param_field '" on line ' num2str(i_line) ' is not implemented yet. The line is ignored'])
    end
	    
    %% Parameter of the random field distribution
   case 'rf_distribution'
    switch param_field
     case 'type'                    
      parameters.rf_distribution.type=param_value;
     case 'mean'                    
      parameters.rf_distribution.mean=str2double(param_value);
     case 'variance'
      parameters.rf_distribution.variance=str2double(param_value);
     case 'rmean'                    
      parameters.rf_distribution.rmean=str2double(param_value);
     case 'rvariance'
      parameters.rf_distribution.rvariance=str2double(param_value);
     case 'degree_of_freedom'
      parameters.rf_distribution.degree_of_freedom=uint16(str2double(param_value));
     otherwise
      warning(['Parameter field "' param_type '.' param_field '" on line ' num2str(i_line) ' is not implemented yet. The line is ignored'])
    end


    %% Parameter of the random field correlation
   case 'rf_correlation'
    switch param_field
     case 'type'                    
      parameters.rf_correlation.type=param_value;
     case 'correlation_length'                    
      parameters.rf_correlation.correlation_length=str2double(param_value);
     otherwise
      warning(['Parameter field "' param_type '.' param_field '" on line ' num2str(i_line) ' is not implemented yet. The line is ignored'])
    end


    %% Parameter of the hitting set
   case 'hitting_set'
    switch param_field
     case 'type'                    
      parameters.hitting_set.type=param_value;
     otherwise
      warning(['Parameter field "' param_type '.' param_field '" on line ' num2str(i_line) ' is not implemented yet. The line is ignored'])
    end
	    
    
            
            
    %% Non implemented parameters
   otherwise
    warning(['Parameter type "' param_type '" on line ' num2str(i_line) ' is not implemented yet. The line is ignored.'])
  end
end


%% check geometrical parameters
%if(~isfield(parameters,'geometrical'))
%    error('Non geometrical parameter set.')
%else
%    % spatial dimension
%    if(~isfield(parameters.geometrical,'spatial_dimension'))
%        error('Parameter field "geometrical.spatial_dimension" is not set.')
%    else
%        if(parameters.geometrical.spatial_dimension<1)
%            error(['Parameter "geometrical.spatial_dimension" must be greater then zero. Here it is ' num2str(parameters.geometrical.spatial_dimension) '.'])
%        end
%        if(parameters.geometrical.spatial_dimension>1)
%            error(['Parameter "geometrical.spatial_dimension" is not implemented yet for the value = ' num2str(parameters.geometrical.spatial_dimension) '.'])
%        end    
%    end
    % specimen
%    if(~isfield(parameters.geometrical,'specimen'))
%        error('Parameter field "geometrical.specimen" is not set.')
%    else
%        switch parameters.geometrical.specimen
%            case 'cube'                
%            otherwise
%                error(['Parameter "geometrical.specimen" is not implemented yet for "' parameters.geometrical.specimen '".'])
%        end
%    end
%    % size
%    if(~isfield(parameters.geometrical,'size'))
%        error('Parameter field "geometrical.size" is not set.')
%    else
%        if(parameters.geometrical.size<=0.0)
%            error(['Parameter "geometrical.size" must be positive. Here it is ' num2str(parameters.geometrical.size) '.'])
%        end    
%    end
%end

%% check random field distribution parameter
%if(~isfield(parameters,'rf_distribution'))
%    warning('Non rf_distribution parameter set.')
%else
 %   if(~isfield(parameters.rf_distribution,'type'))
 %       error('Parameter field "rf_distribution.type" is not set.')
 %   else
 %       switch parameters.rf_distribution.type
%            case 'gaussian'
%                tmp_checks = {'mean', 'variance'};
%                for i_check = 1:size(tmp_checks,2)
%                    if(~isfield(parameters.rf_distribution,tmp_checks{i_check}))
%                      error(['Parameter field "rf_distribution.' tmp_checks{i_check} ' " is not set.'])
%                    end
%                end
%            case 'chi_square'
%                tmp_checks = {'mean', 'variance', 'degree_of_freedom'};
%                for i_check = 1:size(tmp_checks,2)
%                    if(~isfield(parameters.rf_distribution,tmp_checks{i_check}))
%                      error(['Parameter field "rf_distribution.' tmp_checks{i_check} ' " is not set.'])
%                    end
%                end
%                if(parameters.rf_distribution.degree_of_freedom<1)
%                    error(['Parameter "rf_distribution.degree_of_freedom" must be greater then zero. Here it is ' num2str(parameters.rf_distribution.degree_of_freedom) '.'])
%                end
%            otherwise
%                error(['Parameter field "rf_distribution.type" is not implemented yet for the value = ' num2str(parameters.rf_distribution.type) '.'])
%        end
%    end  
%end

%% check random field correlation parameter
%if(~isfield(parameters,'rf_correlation'))
%    error('Non rf_correlation parameter set.')
%else
%    if(~isfield(parameters.rf_correlation,'type'))
%        error('Parameter field "rf_correlation.type" is not set.')
%    else
%        switch parameters.rf_correlation.type
%            case 'gaussian'
%                tmp_checks = {'correlation_length'};
%                for i_check = 1:size(tmp_checks,2)
%                    if(~isfield(parameters.rf_correlation,tmp_checks{i_check}))
%                      error(['Parameter field "rf_correlation.' tmp_checks{i_check} ' " is not set.'])
%                    end
%                end
%                if(parameters.rf_correlation.correlation_length<=0.0)
%                    error(['Parameter "rf_correlation.correlation_length" must be greater then zero. Here it is ' num2str(parameters.rf_correlation.correlation_length) '.'])
%                end
%            otherwise
%                error(['Parameter field "rf_correlation.type" is not implemented yet for the value = ' num2str(parameters.rf_correlation.type) '.'])
%        end
%    end  
%end


%% Display
field_names=fieldnames(parameters);
for i_disp=1:size(field_names,1)
  display(['     --> ' field_names{i_disp}])
  display(getfield(parameters,field_names{i_disp}))
end

