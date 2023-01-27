
% TP1 de Probabilites : fonctions a completer et rendre sur Moodle
% Nom : Gonthier
% Prénom : Priscilia
% Groupe : 1SN-M

function varargout = fonctions_TP1_proba(varargin)

    switch varargin{1}     
        case 'ecriture_RVB'
            varargout{1} = feval(varargin{1},varargin{2:end});
        case {'vectorisation_par_colonne','decorrelation_colonnes'}
            [varargout{1},varargout{2}] = feval(varargin{1},varargin{2:end});
        case 'calcul_parametres_correlation'
            [varargout{1},varargout{2},varargout{3}] = feval(varargin{1},varargin{2:end}); 
    end

end

% Fonction ecriture_RVB (exercice_0.m) ------------------------------------
% (Copiez le corps de la fonction ecriture_RVB du fichier du meme nom)
function image_RVB = ecriture_RVB(image_originale)
    [nb_lignes nb_colonnes]=size(image_originale);
    image_RVB = zeros( nb_lignes/2 , nb_colonnes/2,3);
    image_RVB (:,:,1)=image_originale(1:2:end,2:2:end);%matrice des rouges
    image_RVB (:,:,2)=(image_originale(1:2:end,1:2:end)+image_originale(2:2:end,2:2:end))/2;%matrice des verts
    image_RVB (:,:,3)=image_originale(2:2:end,1:2:end);%matrice des bleus
end

% Fonction vectorisation_par_colonne (exercice_1.m) -----------------------
function [Vd,Vg] = vectorisation_par_colonne(I)
    [nb_lignes nb_colonnes]=size(I);

    Vg= I(:,1:nb_colonnes-1);%matrice contenant tous les pixels gauches
    Vd= I(:,2:nb_colonnes);%matrice contenant tous les pixels droits
    Vd=Vd(:);%vecteur contenant tous les pixels droits
    Vg=Vg(:);%vecteur contenant tous les pixels gauches
end

% Fonction calcul_parametres_correlation (exercice_1.m) -------------------
function [r,a,b] = calcul_parametres_correlation(Vd,Vg)
    md=sum(Vd)/length(Vd);%la moyenne de Vd
    mg=sum(Vg)/length(Vg);%la moyenne de Vg
    
    vard=(Vd'*Vd-(md^2))/length(Vd);%variance de Vd
    varg=(Vg'*Vg-(mg^2))/length(Vg);%variance de Vg
    
    ecd=sqrt(vard);%écart-type de Vd
    ecg=sqrt(varg);%écart-type de Vg
    
    cov=(Vd'*Vg - md'*mg)/length(Vd);%covariance entre Vd et Vg
    
    r=cov/(ecd*ecg);
    
    a=cov/(ecd^2);
    b=mg-a*md;

end

% Fonction decorrelation_colonnes (exercice_2.m) --------------------------
function [I_decorrelee,I_min] = decorrelation_colonnes(I,I_max)
    [nb_lignes nb_colonnes]=size(I);
    I_decorrelee= I;
    I_decorrelee(:,2:nb_colonnes)= I_decorrelee(:,2:nb_colonnes)-I(:,1:nb_colonnes-1);
    I_min=-255;
    
end



