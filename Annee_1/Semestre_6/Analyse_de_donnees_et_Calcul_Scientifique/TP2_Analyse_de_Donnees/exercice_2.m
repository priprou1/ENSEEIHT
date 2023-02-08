clear;
close all;

% Récupération des données :
load("Data_Exo_2/ImSG1.mat");
load("Data_Exo_2/SG1.mat");

% Résolution via les moindres carrés
I_c = Data;
I_c = I_c(:);
J = DataMod;
J = J(:);
J =  log(J);
n = length(I_c);
A = [-I_c ones(n,1)];
Beta = A\J;

% Reconstitution de l'image originale
[l,c] = size(ImMod);
J_im = log(ImMod(:));
I_trouve = ((Beta(2)*ones(length(J_im),1)) - J_im) / Beta(1);
I_trouve = reshape(I_trouve,l,c);

% Erreur des moindres carrés
RMSE = sqrt(mean(mean((I - I_trouve).^2)));

%Affichage de l'image
figure();				% Premiere fenetre d'affichage
subplot(3,1,1);				% La fenetre comporte 2 lignes et 2 colonnes
imagesc(I);
axis off;
axis equal;
title('Image originale','FontSize',20);

subplot(3,1,2);				% La fenetre comporte 2 lignes et 2 colonnes
imagesc(I_trouve);
axis off;
axis equal;
title('Image reconstruite','FontSize',20);

subplot(3,1,3);				% La fenetre comporte 2 lignes et 2 colonnes
imagesc(ImMod);
axis off;
axis equal;
title('Image modifiée','FontSize',20);

