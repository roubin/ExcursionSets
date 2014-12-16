function lkc=f_lipschitz_killing_curvatures(number, geometrical)

error_lkc_not_exist=['LKC number ' num2str(number) ' does not exit in ' num2str(geometrical.spatial_dimension) 'D.'];
error_dimension_not_implemented=['LKC in dimension ' num2str(geometrical.spatial_dimension) ' is not implemented for a "' geometrical.specimen '".'];
error_specimen_not_implemented=['Specimen ' geometrical.specimen ' not implemented yet.'];

switch geometrical.specimen
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
        
    case 'para'
        switch geometrical.spatial_dimension
            case 3
                switch number
                    case 0
                        lkc=0;
                    case 1
                        lkc=geometrical.sizeX+geometrical.sizeY+geometrical.sizeZ;
                    case 2
                        lkc=geometrical.sizeX*geometrical.sizeY+geometrical.sizeX*geometrical.sizeZ+geometrical.sizeY*geometrical.sizeZ;
                    case 3
                        lkc=geometrical.sizeX*geometrical.sizeY*geometrical.sizeZ;
                    otherwise
                        error(error_lkc_not_exist)
                end
            otherwise
                error(error_dimension_not_implemented)
        end
        
        %% Other Specimens
    otherwise
        error(error_specimen_not_implemented)
end

