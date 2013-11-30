function h=f_probabilistic_hermite_polynomials(n,x)

switch n
 case 0
  h=ones(size(x));
 case 1
  h=x;
 case 2
  h=x.^2-1;
 case 3
  h=x.^3-3*x;
 case 4
  h=x.^4-6*x.^2+3;
 case 5
  h=x.^5-10*x.^3+15*x;
 otherwise
  error(['Probabilistic Hermite polynomial number ' num2str(n) ' not implemented yet.'])
end


