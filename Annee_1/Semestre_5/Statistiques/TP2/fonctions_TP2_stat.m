
% TP2 de Statistiques : fonctions a completer et rendre sur Moodle
% Nom : Gonthier
% Prénom : Priscilia
% Groupe : 1SN-M

function varargout = fonctions_TP2_stat(varargin)

    [varargout{1},varargout{2}] = feval(varargin{1},varargin{2:end});

end

% Fonction centrage_des_donnees (exercice_1.m) ----------------------------
function [x_G, y_G, x_donnees_bruitees_centrees, y_donnees_bruitees_centrees] = ...
                centrage_des_donnees(x_donnees_bruitees,y_donnees_bruitees)
    x_G = mean(x_donnees_bruitees);
    y_G = mean(y_donnees_bruitees);
    x_donnees_bruitees_centrees = x_donnees_bruitees - x_G;
    y_donnees_bruitees_centrees = y_donnees_bruitees - y_G;   
     
end

% Fonction estimation_Dyx_MV (exercice_1.m) -------------------------------
function [a_Dyx,b_Dyx] = ...
           estimation_Dyx_MV(x_donnees_bruitees,y_donnees_bruitees,n_tests)
    
    [x_G, y_G, x_donnees_bruitees_centrees, y_donnees_bruitees_centrees] = centrage_des_donnees(x_donnees_bruitees,y_donnees_bruitees);

    nb_donnees = length(x_donnees_bruitees_centrees);
    psi = rand(n_tests,1);%uniformément réparti sur [0;1]
    psi = psi * 2 -1;%réparti entre -1 et 1;
    psi = psi * (pi/2); %entre -pi/2 et pi/2

    X=repmat(x_donnees_bruitees_centrees,n_tests,1);
    Y=repmat(y_donnees_bruitees_centrees,n_tests,1);
    Psi = repmat(psi,1,nb_donnees);

    Somme = (Y-tan(Psi).*X).^2;
    Somme = sum(Somme,2);
    [mini, indice] = min(Somme);

    psi_Dyx = psi(indice);
    a_Dyx = tan(psi_Dyx);
    b_Dyx = y_G - a_Dyx * x_G;  

end

% Fonction estimation_Dyx_MC (exercice_2.m) -------------------------------
function [a_Dyx,b_Dyx] = ...
                   estimation_Dyx_MC(x_donnees_bruitees,y_donnees_bruitees)
    nb_donnees = length(x_donnees_bruitees);
    A = [x_donnees_bruitees ; ones(1,nb_donnees)]';
    B = y_donnees_bruitees';
    X = (inv(A' * A) * A') * B;
    a_Dyx = X(1);
    b_Dyx = X(2);

    
end

% Fonction estimation_Dorth_MV (exercice_3.m) -----------------------------
function [theta_Dorth,rho_Dorth] = ...
         estimation_Dorth_MV(x_donnees_bruitees,y_donnees_bruitees,n_tests)
    
    nb_donnees = length(x_donnees_bruitees);
    [x_G, y_G, x_donnees_bruitees_centrees, y_donnees_bruitees_centrees] = centrage_des_donnees(x_donnees_bruitees,y_donnees_bruitees);
    theta = rand(n_tests,1);%uniformément réparti sur [0;1]
    theta = theta * 2 -1;%réparti entre -1 et 1;
    theta = theta * (pi/2); %entre -pi/2 et pi/2
    
    X=repmat(x_donnees_bruitees_centrees,n_tests,1);
    Y=repmat(y_donnees_bruitees_centrees,n_tests,1);
    Theta = repmat(theta,1,nb_donnees);

    Somme = (X.*cos(Theta) + Y .* sin(Theta)).^2;
    Somme = sum(Somme,2);
    [mini, indice] = min(Somme);
    theta_Dorth = theta(indice);
    rho_Dorth = x_G * cos(theta_Dorth) + y_G * sin(theta_Dorth);

end

% Fonction estimation_Dorth_MC (exercice_4.m) -----------------------------
function [theta_Dorth,rho_Dorth] = ...
                 estimation_Dorth_MC(x_donnees_bruitees,y_donnees_bruitees)

    [x_G, y_G, x_donnees_bruitees_centrees, y_donnees_bruitees_centrees] = centrage_des_donnees(x_donnees_bruitees,y_donnees_bruitees);
    C = [x_donnees_bruitees_centrees; y_donnees_bruitees_centrees]';
    [VP, D] = eig(C' * C);
    D = sum(D,2);
    [mini,indice] = min(D);
    Y = VP(:,indice);

    theta_Dorth = atan(Y(2)/Y(1));
    rho_Dorth = x_G * cos(theta_Dorth) + y_G * sin(theta_Dorth);

end
