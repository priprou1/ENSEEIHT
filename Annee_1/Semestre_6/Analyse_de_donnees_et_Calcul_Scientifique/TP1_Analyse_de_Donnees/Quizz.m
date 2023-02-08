clear;
close all;

% Lecture et affichage d'une image RVB :
I = imread('Quizz_GroupeMN/ishihara-30.png');

% Decoupage de l'image en trois canaux et conversion en doubles :
R = double(I(:,:,1));
V = double(I(:,:,2));
B = double(I(:,:,3));

% Matrice des donnees :
X = [R(:),V(:),B(:)];			% Les trois canaux sont vectorises et concatenes
[l, c] = size(X);

% Centrer la matrice des données :
Xc = X - mean(X,1);

% Matrice de variance/covariance :
Sigma = (1/l) * Xc' * Xc;


%# Méthode ACP
% Calcul des valeurs-propres de Sigma
[W,D] = eig(Sigma);
[D, Indice] = sort(diag(D),'descend');
D = D  .* eye(3);
W = W(:,Indice);

% Calcul de la matrice des composantes principales
C = Xc * W;
C = reshape(C, size(I));

%# Corrélation
CR = C(:,:,1);
CV = C(:,:,2);
CB = C(:,:,3);

% Lecture et affichage d'une image ACP :
figure(3);				% Premiere fenetre d'affichage
subplot(2,2,1);				% La fenetre comporte 2 lignes et 2 colonnes
imagesc(C);
axis off;
axis equal;
title('Image ACP','FontSize',20);


% Affichage du canal R :
colormap gray;				% Pour afficher les images en niveaux de gris
subplot(2,2,2);
imagesc(CR);
axis off;
axis equal;
title('Canal R','FontSize',20);

% Affichage du canal V :
subplot(2,2,3);
imagesc(CV);
axis off;
axis equal;
title('Canal V','FontSize',20);

% Affichage du canal B :
subplot(2,2,4);
imagesc(CB);
axis off;
axis equal;
title('Canal B','FontSize',20);
