clear;
close all;

load eigenfaces_part3m;

% Tirage aléatoire d'une image de test :
personne = randi(nb_personnes)
posture = randi(nb_postures)
% si on veut tester/mettre au point, on fixe l'individu
%personne = 31
%posture = 4

% Dimensions du masque
ligne_min = 200;
ligne_max = 350;
colonne_min = 60;
colonne_max = 290;

ficF = strcat('./Data/', liste_personnes{personne}, liste_postures{posture}, '-300x400.gif')
img = imread(ficF);
img(ligne_min:ligne_max,colonne_min:colonne_max) = 0; %Ajout du masque
image_test = double(transpose(img(:)));
 


% Nombre q de composantes principales à prendre en compte 
q = n_evm;

% dans un second temps, q peut être calculé afin d'atteindre le pourcentage
% d'information avec q valeurs propres (contraste)
% Pourcentage d'information 
% per = 0.75;

%...

C = Xm_centre * Wm;

compo = C(:, 1:q);		% q premières composantes principales
eigen = Wm(:, 1:q);		% q premières eigenfaces
X_reconstruit = compo * eigen' + individu_moyenm;

% individu pseudo-résultat pour l'affichage (A CHANGER)
% personne_proche = 1;
% posture_proche = 1;
listepersonne = kron(1:nb_personnes_base, ones(1, nb_postures_base))';
listeposture = repmat((1:nb_postures_base)', nb_personnes_base, 1);
[personne_proche, posture_proche] = kppv(X_reconstruit, [listepersonne listeposture], image_test);




figure('Name','Image tiree aleatoirement avec plusproche voisin','Position',[0.2*L,0.2*H,0.8*L,0.5*H]);

subplot(1, 2, 1);
% Affichage de l'image de test :
colormap gray;
imagesc(img);
title({['Individu de test : posture ' num2str(posture) ' de ', liste_personnes{personne}]}, 'FontSize', 20);
axis image;

ficF = strcat('./Data/', liste_personnes_base{personne_proche}, liste_postures{posture_proche}, '-300x400.gif')
img2 = imread(ficF);
        
subplot(1, 2, 2);
imagesc(img2);
title({['Individu la plus proche : posture ' num2str(posture_proche) ' de ', liste_personnes_base{personne_proche}]}, 'FontSize', 20);
axis image;

image_reconstruite = reshape(image_test,[400,300]);
image_reconstruite(ligne_min:ligne_max,colonne_min:colonne_max) = img2(ligne_min:ligne_max,colonne_min:colonne_max);

figure('Name','Individu reconstruit avec plus proche voisin','Position',[0.2*L,0.2*H,0.8*L,0.5*H]);

subplot(1, 2, 1);
% Affichage de l'image de test :
colormap gray;
imagesc(img);
title({['Individu de test : posture ' num2str(posture) ' de ', liste_personnes{personne}]}, 'FontSize', 20);
axis image;
        
subplot(1, 2, 2);
imagesc(image_reconstruite);
title({['Individu recontruit']}, 'FontSize', 20);
axis image;


%% Bayesien ne fonctionne pas 
[personne_probable, posture_probable] = bayesien(compo, eigen, [listepersonne listeposture], image_test)


figure('Name','Image tiree aleatoirement avec bayésien','Position',[0.2*L,0.2*H,0.8*L,0.5*H]);

subplot(1, 2, 1);
% Affichage de l'image de test :
colormap gray;
imagesc(img);
title({['Individu de test : posture ' num2str(posture) ' de ', liste_personnes{personne}]}, 'FontSize', 20);
axis image;

ficF = strcat('./Data/', liste_personnes_base{personne_probable}, liste_postures{posture_probable}, '-300x400.gif')
img3 = imread(ficF);
        
subplot(1, 2, 2);
imagesc(img3);
title({['Individu la plus proche : posture ' num2str(posture_probable) ' de ', liste_personnes_base{personne_probable}]}, 'FontSize', 20);
axis image;

image_reconstruite = reshape(image_test,[400,300]);
image_reconstruite(ligne_min:ligne_max,colonne_min:colonne_max) = img3(ligne_min:ligne_max,colonne_min:colonne_max);

figure('Name','Individu reconstruit avec plus proche voisin','Position',[0.2*L,0.2*H,0.8*L,0.5*H]);

subplot(1, 2, 1);
% Affichage de l'image de test :
colormap gray;
imagesc(img);
title({['Individu de test : posture ' num2str(posture) ' de ', liste_personnes{personne}]}, 'FontSize', 20);
axis image;
        
subplot(1, 2, 2);
imagesc(image_reconstruite);
title({['Individu recontruit']}, 'FontSize', 20);
axis image;