function f_write_gnuplot_output(output_file_folder, output_file_name, x, y, varargin)

%% checks
n_points=size(x,1); n_func=size(y,2);
if(n_points~=size(y,1))
  error('Different number of points in X and Y.')
end

fid=fopen([output_file_folder '/' output_file_name], 'w');

if(nargin>4)
  for t=1:size(varargin,2)        
    fprintf(fid,'#%s\n', varargin{t}); 
  end
end

%fseek(fid,0, -1);

switch n_func
 case 1
  fprintf(fid,'%f %f\n', [x y].');
 case 2
  fprintf(fid,'%f %f %0.50f\n', [x y].');
 case 3
  fprintf(fid,'%f %f %f %f\n', [x y].');
 case 4
  fprintf(fid,'%f %f %f %f %f\n', [x y].');
 case 5
  fprintf(fid,'%f %f %f %f %f %f\n', [x y].');
 case 6
  fprintf(fid,'%f %f %f %f %f %f %f\n', [x y].');
 case 7
  fprintf(fid,'%f %f %f %f %f %f %f %f\n', [x y].');
 case 8
  fprintf(fid,'%f %f %f %f %f %f %f %f %f\n', [x y].');
 case 9
  fprintf(fid,'%f %f %f %f %f %f %f %f %f %f\n', [x y].');
 case 10
  fprintf(fid,'%f %f %f %f %f %f %f %f %f %f %f\n', [x y].');
 case 11
  fprintf(fid,'%f %f %f %f %f %f %f %f %f %f %f %f\n', [x y].');
 case 12
  fprintf(fid,'%f %f %f %f %f %f %f %f %f %f %f %f %f\n', [x y].');

    otherwise
  warning(['Ploting ' num2str(n_func) ' is not implemented yet'])
end
        
fclose(fid);

