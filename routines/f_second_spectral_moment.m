function lam2=f_second_spectral_moment(rf_distribution,rf_correlation)

switch rf_correlation.type
    case 'gaussian'
        v=rf_distribution.variance; lc=rf_correlation.correlation_length;
        lam2=2*v/lc^2;
    otherwise
        error('Distribution non implemented yet.')
end

