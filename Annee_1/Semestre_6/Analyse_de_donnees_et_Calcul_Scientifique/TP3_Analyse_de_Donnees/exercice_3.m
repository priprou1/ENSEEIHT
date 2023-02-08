%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Analyse de données
% TP3 - Classification bayésienne
% exercice_3.m
%--------------------------------------------------------------------------

clear
close all
clc

% Chargement des données de l'exercice 2
load resultats_ex2

%% Classifieur par maximum de vraisemblance
% code_classe est la matrice contenant des 1 pour les chrysanthemes
%                                          2 pour les oeillets
%                                          3 pour les pensees
% l'attribution de 1,2 ou 3 correspond au maximum des trois vraisemblances
code_classe1 = (V_chrysanthemes >= V_pensees & V_chrysanthemes >= V_oeillets) * 1;
code_classe2 = (V_oeillets >= V_pensees & V_oeillets > V_chrysanthemes) * 2;
code_classe3 = (V_pensees > V_oeillets & V_pensees > V_chrysanthemes) * 3;
code_classe = code_classe1 + code_classe2 + code_classe3;


%% Affichage des classes

figure('Name','Classification par maximum de vraisemblance',...
       'Position',[0.25*L,0.1*H,0.5*L,0.8*H])
axis equal ij
axis([r(1) r(end) v(1) v(end)]);
hold on
%affichage des classes
imagesc(r,v,code_classe)
carte_couleurs = [.45 .45 .65 ; .45 .65 .45 ; .65 .45 .45];
colormap(carte_couleurs)
%affichage des fleurs
plot(X_pensees(:,1),X_pensees(:,2),'r*','MarkerSize',10,'LineWidth',2)
plot(X_oeillets(:,1),X_oeillets(:,2),'go','MarkerSize',10,'LineWidth',2)
plot(X_chrysanthemes(:,1),X_chrysanthemes(:,2),'b+','MarkerSize',10,'LineWidth',2)
hx = xlabel('$\overline{r}$','FontSize',20);
set(hx,'Interpreter','Latex')
hy = ylabel('$\bar{v}$','FontSize',20);
set(hy,'Interpreter','Latex')
view(-90,90)

%% Comptage des images correctement classees
% Poour chrysanteme :
[V_chr_pensees, denominateur_classe_chr_pensees]  = vraisemblance(X_chrysanthemes(:,1), X_chrysanthemes(:,2), mu_pensees, Sigma_pensees, -1);
