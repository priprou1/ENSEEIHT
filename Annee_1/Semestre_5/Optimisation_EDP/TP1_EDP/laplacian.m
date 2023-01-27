function L = laplacian(nu,dx1,dx2,N1,N2)
%
%  Cette fonction construit la matrice de l'opérateur Laplacien 2D anisotrope
%
%  Inputs
%  ------
%
%  nu : nu=[nu1;nu2], coefficients de diffusivité dans les dierctions x1 et x2. 
%
%  dx1 : pas d'espace dans la direction x1.
%
%  dx2 : pas d'espace dans la direction x2.
%
%  N1 : nombre de points de grille dans la direction x1.
%
%  N2 : nombre de points de grilles dans la direction x2.
%
%  Outputs:
%  -------
%
%  L      : Matrice de l'opérateur Laplacien (dimension N1N2 x N1N2)
%
% 

% Initialisation
    nu1=nu(1);
    nu2=nu(2);
    T=N1*N2; % Taille de la matrice A
    L=sparse(T,T);
    e=ones(T,1);

% % Calcul de L via construction basique:
%     L=spdiags([(-nu2/(dx2^2))*e (2*((nu1/(dx1^2))+(nu2/(dx2^2)))*e) (-nu2/(dx2^2))*e],-1:1,T,T);
%     L=L+spdiags([(-nu1/(dx1^2))*e],N2,T,T);
%     L=L+spdiags([(-nu1/(dx1^2))*e],-N2,T,T);
%     for c=N2:N2:(T-1) % met à 0 les valeurs pour j=0 et j=N2+1
%         for l=N2:N2:(T-1)
%             L(l,c+1)=0; % j=N2+1
%             L(l+1,c)=0; % j=0
%         end
%     end

% % Calcul de L via produit de Kronecker:
    C1 = spdiags([-1/(dx1^2)], 0,1,1);
    C2 = spdiags([e -2*e e],-1:1,N2,N2);
    B1 = spdiags([e],N2,T,T)+spdiags([e],-N2,T,T);
    B2 = (-1/(dx2^2))*spdiags([e],0,N1,N1);
    L = nu1*kron(B1,C1)+nu2*kron(B2,C2);

end    
