function elkc=f_elkc(j_lkc, geometrical, rf_distribution, rf_correlation, hitting_set, varargin)



%display(['---> Computing expectation of LKC: ' num2str(j_lkc)])

lam2 =       f_second_spectral_moment(rf_distribution,rf_correlation); % second spectral moment
if nargin==6 && strcmp(varargin{1}, 'derivative')
    gmf  = @(i)  f_gaussian_minkowski_functionals_derivatives(i, rf_distribution, hitting_set); % handle GMF
else
    gmf  = @(i)  f_gaussian_minkowski_functionals(i, rf_distribution, hitting_set); % handle GMF
end
lkc  = @(ij) f_lipschitz_killing_curvatures(ij, geometrical); % hande LKC of the specimen

elkc=zeros(size(hitting_set.thresholds));
for i_gmf=0:(geometrical.spatial_dimension-j_lkc)
    elkc=elkc+f_flag_coef(i_gmf+j_lkc,i_gmf)*(lam2/(2.0*pi))^(double(i_gmf)/2.0)*lkc(i_gmf+j_lkc)*gmf(i_gmf);
end

