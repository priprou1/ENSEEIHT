%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Analyse de donnees
% TP4 - Reconnaissance de chiffres manuscrits par k plus proches voisins
% fonction kppv.m
%
% Données :
% DataA      : les données d'apprentissage (connues)
% LabelA     : les labels des données d'apprentissage
%
% DataT      : les données de test (on veut trouver leur label)
% Nt_test    : nombre de données tests qu'on veut labelliser
%
% K          : le K de l'algorithme des k-plus-proches-voisins
% ListeClass : les classes possibles (== les labels possibles)
%
% Résultat :
% Partition : pour les Nt_test données de test, le label calculé
%
%--------------------------------------------------------------------------
function [Partition, Confusion, TauxErreur] = kppv(DataA, LabelA, DataT, LabelT, Nt_test, K, ListeClass)

[Na,~] = size(DataA);

% Initialisation du vecteur d'étiquetage des images tests
Partition = zeros(Nt_test,1);
Confusion = zeros(length(ListeClass), length(ListeClass));

disp(['Classification des images test dans ' num2str(length(ListeClass)) ' classes'])
disp(['par la methode des ' num2str(K) ' plus proches voisins:'])

% Boucle sur les vecteurs test de l'ensemble de l'évaluation
for i = 1:Nt_test
    
    disp(['image test n°' num2str(i)])

    % Calcul des distances entre le vecteur de test
    % et les vecteurs d'apprentissage (voisins)
    distances = sqrt(sum((DataA - DataT(i, :)).^2,2));
    
    % On ne garde que les indices des K + proches voisins
    [~, indices] = sort(distances, 'ascend');
    indices = indices(1:K);
    
    % Comptage du nombre de voisins appartenant à chaque classe
    nbVoisinClasse = zeros(length(ListeClass),1);
    for j = 1:K 
            nbVoisinClasse(LabelA(indices(j)) + 1) = nbVoisinClasse(LabelA(indices(j)) + 1) + 1;
    end
    
    % Recherche des classes contenant le maximum de voisins
    [maxi, imax] = max(nbVoisinClasse,[],'all');
    
    % Si l'image test a le plus grand nombre de voisins dans plusieurs
    % classes différentes, alors on lui assigne celle du voisin le + proche,
    % sinon on lui assigne l'unique classe contenant le plus de voisins
    if length(imax) >= 1
        classe = LabelA(indices(1));
    else
            classe = imax - 1;
    end
    
    % Assignation de l'étiquette correspondant à la classe trouvée au point
    % correspondant à la i-ème image test dans le vecteur "Partition"
    Partition(i) = classe;
    Confusion(LabelT(i) + 1, Partition(i) + 1) = Confusion(LabelT(i) + 1, Partition(i) + 1) + 1;
end
Erreur = Confusion - Confusion .* eye(length(ListeClass));
TauxErreur = sum(sum(Erreur))/Nt_test;


