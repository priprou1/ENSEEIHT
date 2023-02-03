%--------------------------------------------------------------------------
% fonction kppv.m
%
% Données :
% images : les données d'apprentissage (connues)
% Label  : les labels des données d'apprentissage
% imageCherche  : les données de test (on veut trouver leur label)
%
% Résultat :
% figure  : numéro de la figure correspondant à l'image la plus proche de
%           l'image test
% posture : numéro de la posture correspondant à l'image la plus proche de
%           l'image test
%--------------------------------------------------------------------------
function [figure, posture] = kppv(images, label, imageCherche)

    % Calcul des distances entre le vecteur de test 
    % et les vecteurs d'apprentissage (voisins)
    distances = sum((images'-imageCherche').^2, 1)';
    
    % On ne garde que les indices des K + proches voisins
    [~, kprochevoisins] = sort(distances, "ascend");
    
    figure = label(kprochevoisins(1),1);
    posture = label(kprochevoisins(1),2);

end
