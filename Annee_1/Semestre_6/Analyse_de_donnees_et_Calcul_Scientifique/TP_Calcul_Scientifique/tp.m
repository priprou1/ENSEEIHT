%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Calcul scientifique
% TP1 - Orthogonalisation de Gram-Schmidt
% tp.m
%--------------------------------------------------------------------------

clear
close all
clc

taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

%% Calcul de la perte d'orthogonalite

% Rang de la matrice
n = 4;

% Puissance de 10 maximale pour le conditionnement
k = 16;

% Matrice U de test
U = gallery('orthog',n);
%U = single(U); k = 8;

% Matrice de reference
D = eye(n);

% Initialisation de la matrice pour recuperer les pertes d'orthogonalite
po = zeros(2,k);

for i = 1:k
  
  % Conditionnement de la matrice A
  %TO DO: modifier D pour obtenir A tel K(A)=10^i
  D(1,1) = 10^i;
  A = U*D*U';
  
  % Perte d'orthogonalite avec algorithme classique
  [K,Qcgs] = cgs(A);
  po(1,i) = norm(eye(n)-Qcgs'*Qcgs);
  CondQ(1,i) = K;

  % Perte d'orthogonalite avec algorithme modifie
  [K,Qmgs] = mgs(A);
  po(2,i) = norm(eye(n)-Qmgs'*Qmgs);
  CondQ(2,i) = K;

  % Perte d'orthogonalite avec algorithme classique 2 fois
  [K,Qcgs] = cgs(Qcgs);
  po(3,i) = norm(eye(n)-Qcgs'*Qcgs);
  CondQ(3,i) = K;
  
  % Perte d'orthogonalite avec algorithme modifie 2 fois
  [K,Qmgs] = mgs(Qmgs);
  po(4,i) = norm(eye(n)-Qmgs'*Qmgs);
  CondQ(4,i) = K;

  % Perte d'orthogonalite avec algorithme classique 3 fois
  [K,Qcgs] = cgs(Qcgs);
  po(5,i) = norm(eye(n)-Qcgs'*Qcgs);
  CondQ(5,i) = K;

  % Perte d'orthogonalite avec algorithme classique 4 fois
  [K,Qcgs] = cgs(Qcgs);
  po(6,i) = norm(eye(n)-Qcgs'*Qcgs);
  CondQ(6,i) = K;
  
end

%% Affichage des courbes d'erreur

x = 10.^(1:k);

figure('Position',[0.1*L,0.1*H,0.8*L,0.75*H])
subplot(2,1,1);
    loglog(x,po(1,:),'r','lineWidth',2)
    hold on
    loglog(x,po(2,:),'b','lineWidth',2)
    hold on
    loglog(x,po(3,:),'g','lineWidth',2)
    hold on
    loglog(x,po(4,:),'y','lineWidth',2)
    hold on
    loglog(x,po(5,:),'m','lineWidth',2)
    hold on
    loglog(x,po(6,:),'c','lineWidth',2)
    grid on
    leg = legend('Gram-Schmidt classique',...
                 'Gram-Schmidt modifie',...
                 'Gram-Schmidt classique effectué 2 fois',...
                 'Gram-Schmidt modifie effectué 2 fois',...
                 'Gram-Schmidt classique effectué 3 fois',...
                 'Gram-Schmidt classique effectué 4 fois',...
                 'Location','NorthWest');
    set(leg,'FontSize',14);
    xlim([x(1) x(end)])
    hx = xlabel('\textbf{Conditionnement $\mathbf{\kappa(A_k)}$}',...
                'FontSize',14,'FontWeight','bold');
    set(hx,'Interpreter','Latex')
    hy = ylabel('$\mathbf{|| I - Q_k^\top Q_k ||}$','FontSize',14,'FontWeight','bold');
    set(hy,'Interpreter','Latex')
    title('Evolution de la perte d''orthogonalite en fonction du conditionnement',...
          'FontSize',20)

    subplot(2,1,2);
    loglog(x,CondQ(1,:),'r','lineWidth',2)
    hold on
    loglog(x,CondQ(2,:),'b','lineWidth',2)
    hold on
    loglog(x,CondQ(3,:),'g','lineWidth',2)
    hold on
    loglog(x,CondQ(4,:),'y','lineWidth',2)
    hold on
    loglog(x,CondQ(5,:),'m','lineWidth',2)
    hold on
    loglog(x,CondQ(6,:),'c','lineWidth',2)
    grid on
    leg = legend('Gram-Schmidt classique',...
                 'Gram-Schmidt modifie',...
                 'Gram-Schmidt classique effectué 2 fois',...
                 'Gram-Schmidt modifie effectué 2 fois',...
                 'Gram-Schmidt classique effectué 3 fois',...
                 'Gram-Schmidt classique effectué 4 fois',...
                 'Location','NorthWest');
    set(leg,'FontSize',14);
    xlim([x(1) x(end)])
    hx = xlabel('\textbf{Conditionnement $\mathbf{\kappa(A_k)}$}',...
                'FontSize',14,'FontWeight','bold');
    set(hx,'Interpreter','Latex')
    hy = ylabel('\textbf{Conditionnement $\mathbf{\kappa(Q_k)}$}',...
                'FontSize',14,'FontWeight','bold');
    set(hy,'Interpreter','Latex')
    title('Evolution du conditionnemnet de Q en fonction du conditionnement de A',...
          'FontSize',20)



% Réponse question 4:
% Plus le conditionnement est grand plus il y a des erreurs
% d'orthogonnalité
