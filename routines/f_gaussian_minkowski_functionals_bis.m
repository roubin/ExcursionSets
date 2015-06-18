function gmf=f_gaussian_minkowski_functionals(number, rf_distribution, hitting_set)

error_gmf_not_imlemented=['Gaussian Minkowsky functional number ' num2str(number) ' not implemented for hitting set "' hitting_set.type '".'];
error_hitting_set_not_implemented=['Hitting "' hitting_set.type '" set not implemented for distribution ' rf_distribution.type '.'];

mean=rf_distribution.mean;
std=sqrt(rf_distribution.variance);
kappa=hitting_set.thresholds;

switch rf_distribution.type
 case {'gaussian', 'lognormal'}        
  if(strcmp(rf_distribution.type,'lognormal'))
    if(find(kappa<=0))
      switch number
        case 0
          switch hitting_set.type
            case 'tail'
              gmf=1.0;
            case 'cumulative'
              gmf=0.0;
            otherwise
              error(error_gmf_not_imlemented)
         end
      otherwise
        gmf=0.0;
      end
      warning(['Threshold values for "lognormal" distribution must be strictly positive. Return value of gmf is ' num2str(gmf)])
      return
    end    
    kappa=log(kappa);        
  end
  switch hitting_set.type
   case 'tail'
    switch number            
     case 0
      gmf=0.5*(1-erf((kappa-mean)/(sqrt(2)*std)));
     case 1
      gmf=exp(-(kappa-mean).^2/(2*std^2))/(sqrt(2*pi)*std);
     case 2
      gmf=(kappa-mean)/std.*exp(-(kappa-mean).^2/(2*std^2))/(sqrt(2*pi)*std^2);
     case 3
      gmf=((kappa-mean).^2/std^2-1).*exp(-(kappa-mean).^2/(2*std^2))/(sqrt(2*pi)*std^3);  
     case 4
      gmf=((kappa-mean).^3/std^3-3*(kappa-mean)/std).*exp(-(kappa-mean).^2/(2*std^2))/(sqrt(2*pi)*std^4);
     otherwise
      error(error_gmf_not_imlemented)
    end
   case 'cumulative'
     switch number            
      case 0
       gmf=0.5*(1+erf((kappa-mean)/(sqrt(2)*std)));
%      case 1
%       gmf=exp(-(kappa-mean).^2/(2*std^2))/(sqrt(2*pi)*std);
%      case 2
%       gmf=-(kappa-mean)/std.*exp(-(kappa-mean).^2/(2*std^2))/(sqrt(2*pi)*std^2);
%      case 3
%       gmf=((kappa-mean).^2/std^2-1).*exp(-(kappa-mean).^2/(2*std^2))/(sqrt(2*pi)*std^3);
%      case 4
%       gmf=-((kappa-mean).^3/std^3-3*(kappa-mean)/std).*exp(-(kappa-mean).^2/(2*std^2))/(sqrt(2*pi)*std^3);
      otherwise
       j=number; ks=(kappa-mean)/std;
       gmf=(-1)^(j+1)*exp(-ks.^2/2).*f_probabilistic_hermite_polynomials(j-1,ks)./(std^j*sqrt(2*pi));
      end
   otherwise
    error(error_hitting_set_not_implemented)
  end
  
%    case 'chi_square'
%        k=rf_distribution.degree_of_freedom;   
%        switch number
%            case 0
%                gmf=gammainc(kappa/(2*std^2),k/2,'upper');
%            case 1
%                tmp=2^(1-k/2)*exp(-kappa/(2*std^2))/(gamma(k/2)*std^k);
%                gmf=u.^((k-1)/2).*tmp;
%            case 2
%                tmp=2^(1-k/2)*exp(-kappa/(2*std^2))/(gamma(k/2)*std^k);
%                gmf=u.^(k/2-1).*(kappa/std^2-(k-1)).*tmp;
%            case 3
%                tmp=2^(1-k/2)*exp(-kappa/(2*std^2))/(gamma(k/2)*std^k);                
%                gmf=kappa.^((k-3)/2).*(kappa.^2/std^4-(2*k-1)*kappa/std^2+(k^2-3*k+2)).*tmp;
%            otherwise
%                error(['Gaussian Minkowsky functional number ' num2str(number) ' not implemented.'])
%        end
    
        
    %% Other distributions
 otherwise
  error(['Parameter "rf_distribution.type" is not implemented yet for the value = ' num2str(rf_distribution.type) '.'])
end


