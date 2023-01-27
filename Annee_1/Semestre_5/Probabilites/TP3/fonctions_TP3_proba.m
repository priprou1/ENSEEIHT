
% TP3 de Probabilites : fonctions a completer et rendre sur Moodle
% Nom : Gonthier
% Prénom : Priscilia
% Groupe : 1SN-M

function varargout = fonctions_TP3_proba(varargin)

    switch varargin{1}
        
        case 'matrice_inertie'
            
            [varargout{1},varargout{2}] = feval(varargin{1},varargin{2:end});
            
        case {'ensemble_E_recursif','calcul_proba'}
            
            [varargout{1},varargout{2},varargout{3}] = feval(varargin{1},varargin{2:end});
    
    end
end

% Fonction ensemble_E_recursif (exercie_1.m) ------------------------------
function [E,contour,G_somme] = ...
    ensemble_E_recursif(E,contour,G_somme,i,j,voisins,G_x,G_y,card_max,cos_alpha)
    contour(i,j) = 0;
    for k=1:8 
        i_v=i+voisins(k,1);
        j_v=j+voisins(k,2);
        
        if contour(i_v,j_v)==1
            if size(E,2)<=card_max
                G_ij_v=[G_x(i_v,j_v),G_y(i_v,j_v)];
                G_ijv_norm=norm(G_ij_v);
                G_somme_norme=norm(G_somme);
                cos_G = (G_ij_v/G_ijv_norm)*(G_somme/G_somme_norme)';
    
                if cos_G>=cos_alpha
                    G_somme = G_somme+G_ij_v;
                    E = [E; i_v,j_v];
                    [E,contour,G_somme] = ensemble_E_recursif(E,contour,G_somme,i_v,j_v,voisins,G_x,G_y,card_max,cos_alpha);
                end
            end
        end
    end  
end

% Fonction matrice_inertie (exercice_2.m) ---------------------------------
function [M_inertie,C] = matrice_inertie(E,G_norme_E)
    E_f=fliplr(E);
    E_f=[E_f(:,1).*G_norme_E, E_f(:,2).*G_norme_E];
    Pi=sum(G_norme_E);
    C=[(sum(E_f,1))/Pi];
    
    E_f=fliplr(E);
    E_f=E_f-C;
    M_inertie=zeros(2,2);
    M_inertie(1,1)=sum((E_f(:,1).^2).*G_norme_E)/Pi;
    M_inertie(1,2)=sum((E_f(:,1).*E_f(:,2)).*G_norme_E)/Pi;
    M_inertie(2,1)=M_inertie(1,2);
    M_inertie(2,2)=sum((E_f(:,2).^2).*G_norme_E)/Pi;
end

% Fonction calcul_proba (exercice_2.m) ------------------------------------
function [x_min,x_max,probabilite] = calcul_proba(E_nouveau_repere,p)
    Min=min(E_nouveau_repere,[],1);
    x_min=Min (1);
    y_min=Min (2);
    Max =max(E_nouveau_repere,[],1);
    x_max=Max (1);
    y_max=Max (2);
    n=size(E_nouveau_repere,1);
    N=round((x_max-x_min)*(y_max-y_min));
    probabilite=1-binocdf(n-1,N,p);

end
