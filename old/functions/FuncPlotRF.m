function FuncPlotRF( X, RF, n, T, test_plot, FieldName)
  if (test_plot(1) || test_plot(2) || test_plot(3))
    %--------------------------------------------------------> VTK <---------%
    if (test_plot(1))
      file = ['./' FieldName '.vtk'];
      fid = fopen(file, 'w');
      fseek(fid,0, -1);
      str1 = '# vtk DataFile Version 2.0';
      str2 = 'RF';
      str4 = 'DATASET STRUCTURED_GRID';
      fprintf(fid,'%s\n%s\n%s\n%s\n%s %d %d %d\n%s %d %s\n',str1,str2,'ASCII',str4,'DIMENSIONS', n, n, n, 'POINTS', n^3, 'float');
      fprintf(fid,'%f %f %f\n', X.');
      str2 = ['SCALARS ' FieldName ' float 1'];
      str3 = 'LOOKUP_TABLE default';
      fprintf(fid,'\n%s %d\n%s\n%s\n','POINT_DATA',n^3,str2,str3);
      fprintf(fid,'%f\n', RF.');
%      str2 = ['SCALARS chi2 float 1'];
%      str3 = 'LOOKUP_TABLE default';
%      fprintf(fid,'\n%s\n%s\n',str2,str3);
%      fprintf(fid,'%f\n', (RF.^2).');
      fclose(fid);
    end
    %--------------------------------------------------------> TXT <---------%
    if (test_plot(2))      
      file = ['./' FieldName '.txt'];
      fid = fopen(file, 'w');
      fseek(fid,0, -1);
      fprintf(fid,'%f\n', T);
      fprintf(fid,'%f\n', RF.');
      fclose(fid);      
    end
    %------------% Sortie pour New_Mc_Gibbs %----------------> DAT <---------%
    if (test_plot(3))
      file = ['./' FieldName '.dat'];
      fid = fopen(file, 'w');
      fseek(fid,0, -1);
      fprintf(fid,'%f,%f,%f\n', X.');
      fprintf(fid,'FIELD\n');
      fprintf(fid,'%f\n', RF.');
      fclose(fid);
    end
  end
