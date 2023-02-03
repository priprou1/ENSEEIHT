clear;
close all;

load eigenfaces_part3;

% Tirage aléatoire d'une image de test :
personne = randi(nb_personnes)
posture = randi(nb_postures)
% si on veut tester/mettre au point, on fixe l'individu
%personne = 10 
%posture = 3

ficF = strcat('./Data/', liste_personnes{personne}, liste_postures{posture}, '-300x400.gif')
img = imread(ficF);
image_test = double(transpose(img(:)));
 


% Nombre q de composantes principales à prendre en compte 
q = n_ev;

% dans un second temps, q peut être calculé afin d'atteindre le pourcentage
% d'information avec q valeurs propres (contraste)
% Pourcentage d'information 
% per = 0.75;

%...

C = X_centre * W;

compo = C(:, 1:q);		% q premières composantes principales
eigen = W(:, 1:q);		% q premières eigenfaces
X_reconstruit = compo * eigen' + individu_moyen ;

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

%% Construction de la matrice de confusion de kppv
groupeReconstruit = [];

for k = 1:nb_personnes
    for i = 1:nb_postures
        ficF = strcat('./Data/', liste_personnes{k}, liste_postures{i}, '-300x400.gif');
        img = imread(ficF);
        image_test = double(transpose(img(:)));
        [personne_proche, posture_proche] = kppv(X_reconstruit, [listepersonne listeposture], image_test);
        groupeReconstruit = [groupeReconstruit [liste_personnes_base_num(personne_proche), liste_postures_base(posture_proche)]'];
    end
end
listepersonne = kron([1:nb_personnes], ones(1, nb_postures))';
listeposture = repmat([1:nb_postures]', nb_personnes, 1);
MatriceConfusionPersonnekppv = confusionmat(groupeReconstruit(1, :), listepersonne')
MatriceConfusionPosturekppv = confusionmat(groupeReconstruit(2, :), listeposture')


%% Bayesien ne fonctionne pas

groupeReconstruit = [];

for k = 1:nb_personnes
    for i = 1:nb_postures
        ficF = strcat('./Data/', liste_personnes{k}, liste_postures{i}, '-300x400.gif');
        img = imread(ficF);
        image_test = double(transpose(img(:)));
        [personne_proche, posture_proche] = bayesien(compo, eigen, [listepersonne listeposture], image_test);
        groupeReconstruit = [groupeReconstruit [liste_personnes_base_num(personne_proche), liste_postures_base(posture_proche)]'];
    end
end
listepersonne = kron([1:nb_personnes], ones(1, nb_postures))';
listeposture = repmat([1:nb_postures]', nb_personnes, 1);
MatriceConfusionPersonnekppv = confusionmat(groupeReconstruit(1, :), listepersonne')
MatriceConfusionPosturekppv = confusionmat(groupeReconstruit(2, :), listeposture')


