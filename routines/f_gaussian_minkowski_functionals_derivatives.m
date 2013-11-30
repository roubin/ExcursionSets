function dgmf=f_gaussian_minkowski_functionals_derivatives(number, rf_distribution, hitting_set)

error_hitting_set_not_implemented=['Hitting "' hitting_set.type '" set not implemented for distribution ' rf_distribution.type '.'];

switch rf_distribution.type
    case 'gaussian'     
        switch hitting_set.type
            case 'tail'
                dgmf=-f_gaussian_minkowski_functionals(number+1, rf_distribution, hitting_set);
            case 'cumulative'
                dgmf=f_gaussian_minkowski_functionals(number+1, rf_distribution, hitting_set);                
            otherwise
                error(error_hitting_set_not_implemented)
        end
        
    case 'lognormal'
        if(strcmp(rf_distribution.type,'lognormal'))
            if(find(hitting_set.thresholds<=0)); error('Threshold values for "lognormal" distribution must be strictly positive.'); end;
            mean=rf_distribution.mean;
            std=sqrt(rf_distribution.variance);
            kappa=hitting_set.thresholds;
            j=double(number);
            Hj=f_probabilistic_hermite_polynomials(j,(log(kappa)-mean)./std);
        end
        switch hitting_set.type
            case 'tail'
                dgmf=-Hj.*exp(-(log(kappa)-mean).^2/2*std^2)./(kappa*std^(j+1)*sqrt(2*pi));
            case 'cumulative'
                dgmf=(-1)^j*Hj.*exp(-(log(kappa)-mean).^2/2*std^2)./(kappa*std^(j+1)*sqrt(2*pi));
            otherwise
                error(error_hitting_set_not_implemented) 
        end
                        
    %% Other distributions
    otherwise
        error(['Parameter "rf_distribution.type" is not implemented yet for the value = ' num2str(rf_distribution.type) '.'])
end


end

