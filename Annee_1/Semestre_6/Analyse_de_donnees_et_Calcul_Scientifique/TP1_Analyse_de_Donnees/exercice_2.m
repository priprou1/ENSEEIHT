clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
figure('Name','Separation des canaux RVB','Position',[0,0,0.67*L,0.67*H]);
figure('Name','Nuage de pixels dans le repere RVB','Position',[0.67*L,0,0.33*L,0.45*H]);

% Lecture et affichage d'une image RVB :
I = imread('ishihara-0.png');
figure(1);				% Premiere fenetre d'affichage
subplot(2,2,1);				% La fenetre comporte 2 lignes et 2 colonnes
imagesc(I);
axis off;
axis equal;
title('Image RVB','FontSize',20);

% Decoupage de l'image en trois canaux et conversion en doubles :
R = double(I(:,:,1));
V = double(I(:,:,2));
B = double(I(:,:,3));

% Affichage du canal R :
colormap gray;				% Pour afficher les images en niveaux de gris
subplot(2,2,2);
imagesc(R);
axis off;
axis equal;
title('Canal R','FontSize',20);

% Affichage du canal V :
subplot(2,2,3);
imagesc(V);
axis off;
axis equal;
title('Canal V','FontSize',20);

% Affichage du canal B :
subplot(2,2,4);
imagesc(B);
axis off;
axis equal;
title('Canal B','FontSize',20);

% Affichage du nuage de pixels dans le repere RVB :
figure(2);				% Deuxieme fenetre d'affichage
plot3(R,V,B,'b.');
axis equal;
xlabel('R');
ylabel('V');
zlabel('B');
rotate3d;

% Matrice des donnees :
X = [R(:),V(:),B(:)];			% Les trois canaux sont vectorises et concatenes
[l, c] = size(X);

% Centrer la matrice des données :
Xc = X - mean(X,1);

% Matrice de variance/covariance :
Sigma = (1/l) * Xc' * Xc;

% Coefficients de correlation lineaire :
rRV = Sigma(1,2)/sqrt(Sigma(1,1) * Sigma(2,2));
rRB = Sigma(1,3)/sqrt(Sigma(1,1) * Sigma(3,3));
rBV = Sigma(2,3)/sqrt(Sigma(2,2) * Sigma(3,3));

% Proportions de contraste :
cR = Sigma(1,1)/(Sigma(1,1) + Sigma(2,2) + Sigma(3,3));
cV = Sigma(2,2)/(Sigma(1,1) + Sigma(2,2) + Sigma(3,3));
cB = Sigma(3,3)/(Sigma(1,1) + Sigma(2,2) + Sigma(3,3));

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

% Matrice des donnees :
X1 = [CR(:),CV(:),CB(:)];			% Les trois canaux sont vectorises et concatenes
[l, c] = size(X1);

% Centrer la matrice des données :
Xc1 = X1 - mean(X1,1);

% Matrice de variance/covariance :
Sigma1 = (1/l) * Xc1' * Xc1;


% Coefficients de correlation lineaire :
rcRV = Sigma1(1,2)/sqrt(Sigma1(1,1) * Sigma1(2,2));
rcRB = Sigma1(1,3)/sqrt(Sigma1(1,1) * Sigma1(3,3));
rcBV = Sigma1(2,3)/sqrt(Sigma1(2,2) * Sigma1(3,3));

% Proportions de contraste :
ccR = Sigma1(1,1)/(Sigma1(1,1) + Sigma1(2,2) + Sigma1(3,3));
ccV = Sigma1(2,2)/(Sigma1(1,1) + Sigma1(2,2) + Sigma1(3,3));
ccB = Sigma1(3,3)/(Sigma1(1,1) + Sigma1(2,2) + Sigma1(3,3));

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
