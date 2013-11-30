function EC = FuncECPoly_3D( Morpho )
N3D=size(Morpho);
N=round(N3D(1)^(1/3));

%Calcul du nombre de sommets
S = 0;
%Calcul du nombre d'arretes
A = 0;
%Calcul du nombre de face
F = 0;
%Calcul du nombre de cube
V = 0;
for a3=1:N
  for a2=1:N
    for a1=1:N
      S = S + Morpho(a1+N*(a2-1)+N^2*(a3-1)); 
      if( Morpho(a1+N*(a2-1)+N^2*(a3-1)) )
        if( a1 < N )
          A = A + Morpho(a1+1+N*(a2-1)+N^2*(a3-1));
        end
        if( a2 < N )
          A = A + Morpho(a1+N*a2+N^2*(a3-1));
        end
        if( a3 < N )
          A = A + Morpho(a1+N*(a2-1)+N^2*a3);
        end
      end
      if( (a1<N) && (a2<N) )
        %Face du plan XY
        F = F+(Morpho(a1+N*(a2-1)+N^2*(a3-1))*Morpho(a1+1+N*(a2-1)+N^2*(a3-1))*Morpho(a1+N*a2+N^2*(a3-1))*Morpho(a1+1+N*a2+N^2*(a3-1)));
      end
      if( (a3<N) && (a2<N) )
        %Face du plan YZ
        F = F+(Morpho(a1+N*(a2-1)+N^2*(a3-1))*Morpho(a1+N*(a2-1)+N^2*a3)*Morpho(a1+N*a2+N^2*(a3-1))*Morpho(a1+N*a2+N^2*a3));
      end
      if( (a1<N) && (a3<N) )
        %Face du plan XZ
        F = F+(Morpho(a1+N*(a2-1)+N^2*(a3-1))*Morpho(a1+1+N*(a2-1)+N^2*(a3-1))*Morpho(a1+N*(a2-1)+N^2*a3)*Morpho(a1+1+N*(a2-1)+N^2*a3));
        if ( a2<N )
          V = V+Morpho(a1+N*(a2-1)+N^2*(a3-1))*Morpho(a1+N*(a2-1)+N^2*a3)*Morpho(a1+N*a2+N^2*(a3-1))*Morpho(a1+N*a2+N^2*a3)*Morpho(a1+1+N*(a2-1)+N^2*(a3-1))*Morpho(a1+1+N*(a2-1)+N^2*a3)*Morpho(a1+1+N*a2+N^2*(a3-1))*Morpho(a1+1+N*a2+N^2*a3);
        end
      end
    end
  end
end

%Calcul de la caracteristique d Euler
EC = S-A+F-V;






% OLD


%%Excursion=zeros(N,N,N);
%for k=1:N
%  for j=1:N
%    for i=1:N
%      Excursion(i,j,k)=Morpho(i+N*(j-1)+N^2*(k-1));
%    end
%  end
%end
%      if( Excursion(a1,a2,a3) )
%        if( a1 < N )
%          A = A+Excursion(a1+1,a2,a3);
%%        end
%%        if( a2 < N )
%          A = A+Excursion(a1,a2+1,a3);
%	end
%        if( a3 < N )
%          A = A+Excursion(a1,a2,a3+1);
%        end
%      end
%      if( (a1<N) && (a2<N) )
%        %Face du plan XY
%        F = F+(Excursion(a1,a2,a3)*Excursion(a1+1,a2,a3)*Excursion(a1,a2+1,a3)*Excursion(a1+1,a2+1,a3));
%      end
%      if( (a3<N) && (a2<N) )
%        %Face du plan YZ
%        F = F+(Excursion(a1,a2,a3)*Excursion(a1,a2,a3+1)*Excursion(a1,a2+1,a3)*Excursion(a1,a2+1,a3+1));
%      end
%      if( (a1<N) && (a3<N) )
%        %Face du plan XZ
%        F = F+(Excursion(a1,a2,a3)*Excursion(a1+1,a2,a3)*Excursion(a1,a2,a3+1)*Excursion(a1+1,a2,a3+1));
%        if ( a2<N )
%          V = V+Excursion(a1,a2,a3)*Excursion(a1,a2,a3+1)*Excursion(a1,a2+1,a3)*Excursion(a1,a2+1,a3+1)*Excursion(a1+1,a2,a3)*Excursion(a1+1,a2,a3+1)*Excursion(a1+1,a2+1,a3)*Excursion(a1+1,a2+1,a3+1);
%        end
%      end
%
