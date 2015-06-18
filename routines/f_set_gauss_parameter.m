function p=f_set_gauss_parameter(p)

switch p.rf_distribution.type
    case 'lognormal'
        p.rf_distribution.variance=log(1+p.rf_distribution.rvariance/p.rf_distribution.rmean^2);
        p.rf_distribution.mean=log(p.rf_distribution.rmean)-0.5*p.rf_distribution.variance;
    otherwise
        error(['Set underlying Gaussian distribution parameter for "' p.rf_distribution.type '" distribution.'])
end

