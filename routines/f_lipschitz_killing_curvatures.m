function lkc=f_lipschitz_killing_curvatures(number, geometrical)

error_lkc_not_exist=['LKC number ' num2str(number) ' does not exit in ' num2str(geometrical.spatial_dimension) 'D.'];
error_dimension_not_implemented=['LKC in dimension ' num2str(geometrical.spatial_dimension) ' is not implemented for a "' geometrical.specimen '".'];
error_specimen_not_implemented=['Specimen ' geometrical.specimen ' not implemented yet.'];

switch geometrical.specimen
    %% Cube
    case 'cube'        
        switch geometrical.spatial_dimension
            case {1, 2, 3}
                if(number<=geometrical.spatial_dimension && number>=0)                    
                    lkc=double(nchoosek(double(geometrical.spatial_dimension), double(number))*geometrical.size.^double(number));
                else
                    error(error_lkc_not_exist)
                end
            otherwise
                error(error_dimension_not_implemented)
        end
        
    %% Other Specimens
    otherwise
        error(error_specimen_not_implemented)
end

end
