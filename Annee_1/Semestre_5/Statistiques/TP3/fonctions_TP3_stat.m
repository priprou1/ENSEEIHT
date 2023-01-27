
% TP3 de Statistiques : fonctions a completer et rendre sur Moodle
% Nom : Gonthier
% Prenom : Priscilia
% Groupe : 1SN-M

function varargout = fonctions_TP3_stat(varargin)

    [varargout{1},varargout{2}] = feval(varargin{1},varargin{2:end});

end

% Fonction estimation_F (exercice_1.m) ------------------------------------
function [rho_F,theta_F,ecart_moyen] = estimation_F(rho,theta)

    A = [cos(theta) , sin(theta)];
    B = rho;
    X = pinv(A) * B;
    x_F = X(1);
    y_F = X(2);
    rho_F = sqrt(x_F^2 + y_F^2);
    theta_F = atan2(y_F,x_F); 

    % A modifier lors de l'utilisation de l'algorithme RANSAC (exercice 2)
    ecart_moyen = (1/length(theta))*sum(abs(rho - rho_F*cos(theta-theta_F)));
   

end

% Fonction RANSAC_2 (exercice_2.m) ----------------------------------------
function [rho_F_estime,theta_F_estime] = RANSAC_2(rho,theta,parametres)
    S1 = parametres(1);
    S2 = parametres(2);
    kmax = parametres(3);
    n = length(theta);
    critere_min = Inf;
    for i = 1:kmax
        droite = randperm(n,2);
        [rho_I,theta_I,ecart_moyen] = estimation_F(rho(droite),theta(droite));
        rho_conforme = rho(abs(rho-rho_I*cos(theta-theta_I))<S1);
        theta_conforme = theta(abs(rho-rho_I*cos(theta-theta_I))<S1);
        if (length(theta_conforme)/n)>S2
            [rho_F,theta_F,ecart_moyen] = estimation_F(rho_conforme,theta_conforme);
            if ecart_moyen<critere_min
                critere_min = ecart_moyen;
                rho_F_estime = rho_F;
                theta_F_estime = theta_F;
            end

        end

    end    
    
end

% Fonction G_et_R_moyen (exercice_3.m, bonus, fonction du TP1) ------------
function [G, R_moyen, distances] = ...
          G_et_R_moyen(x_donnees_bruitees,y_donnees_bruitees)
    nb_donnees = length(x_donnees_bruitees);
    G_x = (1/nb_donnees) * sum(x_donnees_bruitees);
    G_y = (1/nb_donnees) * sum(y_donnees_bruitees);
    G= [G_x G_y];
    distances = sqrt((x_donnees_bruitees - G_x).^2 + (y_donnees_bruitees - G_y).^2);
    R_moyen = (1/nb_donnees) * sum(distances);
end

% Fonction estimation_C_et_R (exercice_3.m, bonus, fonction du TP1) -------
function [C_estime,R_estime,critere] = ...
         estimation_C_et_R(x_donnees_bruitees,y_donnees_bruitees,n_tests,C_tests,R_tests)
     
    % Attention : par rapport au TP1, le tirage des C_tests et R_tests est 
    %             considere comme etant déjà effectue 
    %             (il doit etre fait au debut de la fonction RANSAC_3)

    [G, R_moyen, distances] = G_et_R_moyen(x_donnees_bruitees,y_donnees_bruitees);
    nb_donnees = length(x_donnees_bruitees);
    
    X_c = repmat(C_tests(:,1),1,nb_donnees);
    Y_c = repmat(C_tests(:,2),1,nb_donnees);

    X_db = repmat(x_donnees_bruitees,n_tests,1);
    Y_db = repmat(y_donnees_bruitees,n_tests,1);

    Distance = sqrt((X_db - X_c).^2 + (Y_db - Y_c).^2);
    Distance = (Distance - R_tests).^2;
    Somme = sum(Distance,2);
     
    [mini, indice] = min(Somme);
    C_estime = C_tests(indice, 1 : 2);
    R_estime = R_tests(indice);
    critere = mini;


end

% Fonction RANSAC_3 (exercice_3, bonus) -----------------------------------
function [C_estime,R_estime] = ...
         RANSAC_3(x_donnees_bruitees,y_donnees_bruitees,parametres)
     
    % Attention : il faut faire les tirages de C_tests et R_tests ici

    %paramètres
    S1 = parametres(1);
    S2 = parametres(2);
    kmax = parametres(3);

    [G, R_moyen, distances] = G_et_R_moyen(x_donnees_bruitees,y_donnees_bruitees);
    nb_donnees = length(x_donnees_bruitees);

    

    n = length(x_donnees_bruitees);
    critere_min = inf;
    for i = 1:kmax
        
        indice = randperm(length(x_donnees_bruitees),3);


        [C,R] = estimation_cercle_3points(x_donnees_bruitees(indice),y_donnees_bruitees(indice));

        X_I = x_donnees_bruitees(abs(R-sqrt((x_donnees_bruitees-C(1)).^2+(y_donnees_bruitees-C(2)).^2))<S1);
        Y_I = y_donnees_bruitees(abs(R-sqrt((x_donnees_bruitees-C(1)).^2+(y_donnees_bruitees-C(2)).^2))<S1);

            

        if (length(X_I)/n)>S2
            R_test = rand(kmax,1); %vecteur de taille n_tests de données aléatoires de moyenne 0 et écart-type 1
            R_test = R_test * 2 - 1; %centré en 0 et entre -1 et 1
            R_test = R_test * (R_moyen/2) + R_moyen;% centré en R_moyen et entre R_moyen/2 et 3*R_moyen/2
            
            x_c = rand(kmax,1);
            y_c = rand(kmax,1);
            x_c = x_c * 2 - 1; %centré en 0 et entre -1 et 1
            y_c = y_c * 2 - 1;
            x_c = x_c * R_moyen + G(1); %centré en G et entre G-R_moyen et G+R_moyen;
            y_c = y_c * R_moyen + G(2);
            
            C_test = [x_c, y_c];


            [C_F,R_F,critere] = estimation_C_et_R(X_I,Y_I,kmax,C_test,R_test);
         
            if critere<critere_min
                critere_min = critere;
                C_estime = C_F;
                R_estime = R_F;
            end

        end

    end

end
