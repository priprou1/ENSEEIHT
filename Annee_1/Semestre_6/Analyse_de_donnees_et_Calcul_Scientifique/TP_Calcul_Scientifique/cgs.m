%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Calcul scientifique
% TP1 - Orthogonalisation de Gram-Schmidt
% cgs.m
%--------------------------------------------------------------------------

function [K,Q] = cgs(A)

    % Recuperation du nombre de colonnes de A
    [~, m] = size(A);
    
    % Initialisation de la matrice Q avec la matrice A
    Q = A;
    
    % Algorithme de Gram-Schmidt classique
    %Méthode avec une 2eme boucle for
    for i = 1:m
        y = A(:,i);
        for j = 1:i-1
            y = y - dot(A(:,i), Q(:,j)) * Q(:,j);
        end
        Q(:,i) = y/norm(y);
    end

%     % Méthode sans 2eme boucle for
%     for i = 1:m
%         Q(:,i) = Q(:,i) - Q(:,1:i-1) * dot(repmat(A(:,i),1,i-1), Q(:,1:i-1))';
%         Q(:,i) = Q(:,i)/norm(Q(:,i));
%     end
    K = cond(Q);

end