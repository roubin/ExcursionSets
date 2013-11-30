function random_fields=f_read_random_field(file_folder, file_name)

display(['---> Reading Random Field file: ' file_folder '/' file_name])
fid = fopen([file_folder '/' file_name]);
rf_header=regexp(strrep(fgetl(fid),' ',''),',','split');
rf_field=textscan(fid, '%s\n', 'CommentStyle', '%', 'bufsize',4956000);
fclose(fid);

rf_size=str2double(rf_header{1});
rf_dimension=uint16(str2double(rf_header{2}));

tmp=regexp(strrep(rf_field{1}{1},' ',''),',','split');
n_rea=size(tmp,2);
n_points=size(rf_field{1},1);

random_fields=struct('Dimension', rf_dimension, 'Type', 'cube', 'Size', rf_size, 'NRealisations', n_rea, 'NPoints', n_points, 'Values', zeros(n_points, n_rea));
display(['         Spatial Dimension      : ' num2str(rf_dimension)])
display(['         Specimen size          : ' num2str(rf_size)])
display(['         Number of realizations : ' num2str(n_rea)])
display(['         Number of points       : ' num2str(n_points)])
display(' ')

display('     --> Formating data...')

switch rf_dimension
 case {1, 2}
  for i=1:n_points
    tmp=regexp(strrep(rf_field{1}{i},' ',''),',','split');
    for j=1:n_rea
      random_fields.Values(i,j)=str2double(tmp{j});
    end
  end
  if(rf_dimension==1)
    random_fields.Points=linspace(0,random_fields.Size,random_fields.NPoints);
  end
 otherwise
  error('This dimension is not implemented yet')
end


