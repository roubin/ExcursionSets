function [L1 L3] = get_union(tab_L1, tab_L3)


N = size(tab_L3,1);
L3 = tab_L3(1,1); % Premiere longueure de correlation
L1 = tab_L1(1,1);

for k=2:N
    %display(['Lc  k = ' num2str(k) ' to N = ' num2str(N)])
    %calcul de l'union de L3 (formule de poincare)
    L3uni = 0.0;    
    for l=1:k-1
        %display(['  Union  l = ' num2str(l) ' to k = ' num2str(k)])        
        cb = nchoosek(1:k-1,l); % liste des combinaisons possibles
        N_e = size(cb,1); % nombre d'element
        N_s = size(cb,2); % taille de chaque element
        %display(['     Il y a ' num2str(N_e) ' element(s) de ' num2str(N_s) ' sub_elem(s)'])
        sig = (-1)^(l-1);
        L3elem = 0.0;
        for e=1:N_e           
            L3sub_elem = 1.0;
            for s=1:N_s           
                L3sub_elem = L3sub_elem.*tab_L3(cb(e,s),1); % intersection des Ai
                %display(['     * ' num2str(cb(e,s))])
            end  
            %display('       + ')
            L3elem = L3elem + L3sub_elem; % somme des intersection
        end
        %display(['       contribution : ' num2str(sig)])
        L3uni = L3uni + sig*L3elem;
    end

    L1 = L1 + tab_L1(k,1)*(1-L3uni);
    L3 = L3 + tab_L3(k,1)*(1-L3uni);
end
