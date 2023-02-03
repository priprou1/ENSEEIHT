%--------------------------------------------------------------------------
% fonction bayesien.m
%
% Données :
% images : les données d'apprentissage (connues)
% imagesProj : 
% eigen : vecteurs propres
% Label  : les labels des données d'apprentissage
% imageCherche  : les données de test (on veut trouver leur label)
%
% Résultat :
% figure  : numéro de la figure correspondant à l'image la plus proche de
%           l'image test
% posture : numéro de la posture correspondant à l'image la plus proche de
%           l'image test
%--------------------------------------------------------------------------
function [figure, posture] = bayesien(imagesProj, eigen, labels, imageCherche)
    N= size(imagesProj, 2);
    probaImages = zeros(1, N);
    imageChercheP = imageCherche * eigen;
    for i = 1:N
        [mu, sigma] = estimation_mu_Sigma(imagesProj(i, :)');
        probaImages(1, i) = gaussienne(imageChercheP, mu, sigma);
    end
    [~, indice] = max(probaImages);
    figure = labels(indice,1);
    posture = labels(indice,2);
end
