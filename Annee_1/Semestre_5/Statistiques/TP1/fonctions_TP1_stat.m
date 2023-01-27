
% TP1 de Statistiques : fonctions a completer et rendre sur Moodle
% Nom : Gonthier
% Prénom : Priscilia
% Groupe : 1SN-M

function varargout = fonctions_TP1_stat(varargin)

    [varargout{1},varargout{2}] = feval(varargin{1},varargin{2:end});

end

% Fonction G_et_R_moyen (exercice_1.m) ----------------------------------
function [G, R_moyen, distances] = ...
         G_et_R_moyen(x_donnees_bruitees,y_donnees_bruitees)
    nb_donnees = length(x_donnees_bruitees);
    G_x = (1/nb_donnees) * sum(x_donnees_bruitees);
    G_y = (1/nb_donnees) * sum(y_donnees_bruitees);
    G= [G_x G_y];
    distances = sqrt((x_donnees_bruitees - G_x).^2 + (y_donnees_bruitees - G_y).^2);
    R_moyen = (1/nb_donnees) * sum(distances);

end

% Fonction estimation_C_uniforme (exercice_1.m) ---------------------------
function [C_estime, R_moyen] = ...
         estimation_C_uniforme(x_donnees_bruitees,y_donnees_bruitees,n_tests)
    [G, R_moyen, distances] = G_et_R_moyen(x_donnees_bruitees,y_donnees_bruitees);
    nb_donnees = length(x_donnees_bruitees);
    x_c = rand(n_tests,1);
    y_c = rand(n_tests,1);
    x_c = x_c * 2 - 1; %centré en 0 et entre -1 et 1;
    y_c = y_c * 2 - 1;
    x_c = x_c * R_moyen + G(1); %centré en G et entre G-R_moyen et G+R_moyen;
    y_c = y_c * R_moyen + G(2);
     
    C_test = [x_c, y_c];

    X_c = repmat(x_c,1,nb_donnees);
    Y_c = repmat(y_c,1,nb_donnees);

    X_db = repmat(x_donnees_bruitees,n_tests,1);
    Y_db = repmat(y_donnees_bruitees,n_tests,1);

    Distance = sqrt((X_db - X_c).^2 + (Y_db - Y_c).^2);
    Distance = (Distance - R_moyen).^2;
    Somme = sum(Distance,2);
     
    [mini, indice] = min(Somme);
    C_estime = C_test(indice, 1 : 2);
end

% Fonction estimation_C_et_R_uniforme (exercice_2.m) ----------------------
function [C_estime, R_estime] = ...
         estimation_C_et_R_uniforme(x_donnees_bruitees,y_donnees_bruitees,n_tests)
    
    [G, R_moyen, distances] = G_et_R_moyen(x_donnees_bruitees,y_donnees_bruitees);
    nb_donnees = length(x_donnees_bruitees);
    
    R_test = rand(n_tests,1); %vecteur de taille n_tests de données aléatoires de moyenne 0 et écart-type 1
    R_test = R_test * 2 - 1; %centré en 0 et entre -1 et 1
    R_test = R_test * (R_moyen/2) + R_moyen;% centré en R_moyen et entre R_moyen/2 et 3*R_moyen/2
    
    x_c = rand(n_tests,1);
    y_c = rand(n_tests,1);
    x_c = x_c * 2 - 1; %centré en 0 et entre -1 et 1
    y_c = y_c * 2 - 1;
    x_c = x_c * R_moyen + G(1); %centré en G et entre G-R_moyen et G+R_moyen;
    y_c = y_c * R_moyen + G(2);
    
    C_test = [x_c, y_c];
    
    X_c = repmat(x_c,1,nb_donnees);
    Y_c = repmat(y_c,1,nb_donnees);

    X_db = repmat(x_donnees_bruitees,n_tests,1);
    Y_db = repmat(y_donnees_bruitees,n_tests,1);

    Distance = sqrt((X_db - X_c).^2 + (Y_db - Y_c).^2);
    Distance = (Distance - R_test).^2;
    Somme = sum(Distance,2);
     
    [mini, indice] = min(Somme);
    C_estime = C_test(indice, 1 : 2);
    R_estime = R_test(indice);
end

% Fonction occultation_donnees (donnees_occultees.m) ----------------------
function [x_donnees_bruitees, y_donnees_bruitees] = ...
         occultation_donnees(x_donnees_bruitees, y_donnees_bruitees, theta_donnees_bruitees)
    Theta = rand(2,1);
    Theta = Theta * 2 * pi;
    if Theta(1)<Theta(2)
        Indice = find(Theta(1)<=theta_donnees_bruitees);
        x_donnees_bruitees = x_donnees_bruitees(Indice);
        y_donnees_bruitees = y_donnees_bruitees(Indice);
        theta_donnees_bruitees = theta_donnees_bruitees(Indice);
        Indice = find(theta_donnees_bruitees<=Theta(2));
        x_donnees_bruitees = x_donnees_bruitees(Indice);
        y_donnees_bruitees = y_donnees_bruitees(Indice);
    else
        Indice_1 = find(Theta(1)<=theta_donnees_bruitees);
        Indice_2 = find(theta_donnees_bruitees<=Theta(2));
        Indice = [Indice_1 Indice_2];
        x_donnees_bruitees = x_donnees_bruitees(Indice);
        y_donnees_bruitees = y_donnees_bruitees(Indice);
    end
    
end

% Fonction estimation_C_et_R_normale (exercice_4.m, bonus) ----------------
function [C_estime, R_estime] = ...
         estimation_C_et_R_normale(x_donnees_bruitees,y_donnees_bruitees,n_tests)
    [G, R_moyen, distances] = G_et_R_moyen(x_donnees_bruitees,y_donnees_bruitees);
    nb_donnees = length(x_donnees_bruitees);
    
    R_test = randn(n_tests,1); %vecteur de taille n_tests de données aléatoires de moyenne 0 et écart-type 1
    R_test = R_test*(R_moyen/2) + R_moyen;% met la moyenne à R_moyen et l'écart_type à R_moyen/2
    
    x_c = randn(n_tests,1);
    y_c = randn(n_tests,1);

    x_c = x_c * R_moyen + G(1); %met la moyenne à G et l'écart_type à R_moyen
    y_c = y_c * R_moyen + G(2);
    
    C_test = [x_c, y_c];
    
    X_c = repmat(x_c,1,nb_donnees);
    Y_c = repmat(y_c,1,nb_donnees);

    X_db = repmat(x_donnees_bruitees,n_tests,1);
    Y_db = repmat(y_donnees_bruitees,n_tests,1);

    Distance = sqrt((X_db - X_c).^2 + (Y_db - Y_c).^2);
    Distance = (Distance - R_test).^2;
    Somme = sum(Distance,2);
     
    [mini, indice] = min(Somme);
    C_estime = C_test(indice, 1 : 2);
    R_estime = R_test(indice);
end
