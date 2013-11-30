function ELKC = FuncThLKC_3D(T,sigma,esp,Lc,u,k)
Nt=size(u,2);
ELKC = zeros(4,Nt);
lambda = 2*sigma^2/Lc^2;

u = u-esp;

if k == 0
  %Champ Gaussien
  M0 = (1-erf(u/(sqrt(2)*sigma)))/2;
  M1 = exp(-u.^2/(2*sigma^2))/(sqrt(2*pi)*sigma);
  M2 = u/sigma.*exp(-u.^2/(2*sigma^2))/(sqrt(2*pi)*sigma^2);
  M3 = (u.^2/sigma^2-1).*exp(-u.^2/(2*sigma^2))/(sqrt(2*pi)*sigma^3);
else
  %Champ Khi^2_k
  M0 = gammainc(u/(2*sigma^2),k/2,'upper');
  MM = 2^(1-k/2)*exp(-u/(2*sigma^2))/(gamma(k/2)*sigma^k);
  M1 = u.^((k-1)/2).*MM;
  M2 = u.^(k/2-1).*(u/sigma^2-(k-1)).*MM;
  M3 = u.^((k-3)/2).*(u.^2/sigma^4-(2*k-1)*u/sigma^2+(k^2-3*k+2)).*MM;
end
%Volume specifique
ELKC(1,:) = M0;
%Surface
ELKC(2,:) = 2*( sqrt(2*lambda/pi)*T^3*M1 + 3*T^2*M0 );
%Caliper Diametre
ELKC(3,:) = lambda*T^3/pi*M2 + 3*sqrt(pi*lambda/2)*T^2/2*M1 + 3*T*M0;
%Carac Euler
ELKC(4,:) = (lambda/(2*pi))^(3/2)*T^3*M3 + 3*lambda*T^2/(2*pi)*M2 + 3*sqrt(lambda/(2*pi))*T*M1 + M0;
