function flag=f_flag_coef(n, j)

%volume of the unit ball
n=double(n); j=double(j);
ubv_n=pi^(n/2)/gamma(1.+n/2.);
ubv_j=pi^(j/2)/gamma(1.+j/2.);
ubv_nj=pi^((n-j)/2)/gamma(1+(n-j)/2);
flag=nchoosek(n, j)*ubv_n/(ubv_nj*ubv_j);

end
