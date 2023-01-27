function [beta, norm_grad_f_beta, f_beta, norm_delta, nb_it, exitflag] ...
          = Algo_Gauss_Newton(residu, J_residu, beta0, option)
%*****************************************************************
% Fichier  ~gergaud/ENS/Optim1a/TP-optim-20-21/TP-ref/GN_ref.m   *
% Novembre 2020                                                  *
% Université de Toulouse, INP-ENSEEIHT                           *
%*****************************************************************
%
% GN resout par l'algorithme de Gauss-Newton les problemes aux moindres carres
% Min 0.5||r(beta)||^2
% beta \in \IR^p
%
% Paramètres en entrés
% --------------------
% residu : fonction qui code les résidus
%          r : \IR^p --> \IR^n
% J_residu : fonction qui code la matrice jacobienne
%            Jr : \IR^p --> real(n,p)
% beta0 : point de départ
%         real(p)
% option(1) : Tol_abs, tolérance absolue
%             real
% option(2) : Tol_rel, tolérance relative
%             real
% option(3) : n_itmax, nombre d'itérations maximum
%             integer
%
% Paramètres en sortie
% --------------------
% beta      : beta
%             real(p)
% norm_gradf_beta : ||gradient f(beta)||
%                   real
% f_beta : f(beta)
%          real
% r_beta : r(beta)
%          real(n)
% norm_delta : ||delta||
%              real
% nb_it : nombre d'itérations
%        integer
% exitflag   : indicateur de sortie
%              integer entre 1 et 4
% exitflag = 1 : ||gradient f(beta)|| < max(Tol_rel||gradient f(beta0)||,Tol_abs)
% exitflag = 2 : |f(beta^{k+1})-f(beta^k)| < max(Tol_rel|f(beta^k)|,Tol_abs)
% exitflag = 3 : ||delta)|| < max(Tol_rel delta^k),Tol_abs)
% exitflag = 4 : nombre maximum d'itérations atteint
%      
% ---------------------------------------------------------------------------------

% TO DO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %initialisation des variables:
    Tol_abs=option(1);
    Tol_rel=option(2);
    n_itmax=option(3);
    beta = beta0;
    norm_grad_f_beta = 0;
    norm_delta = 0;
    nb_it = 0;
    exitflag = 0;
    continuer= true;
    
    %Calcul des valeurs utiles pour les tests d'arrêts:
    J=J_residu(beta0);
    r_beta= residu(beta0);
    f_beta=0.5*(r_beta'*r_beta);%pour permettre le calcul de f_beta_k dès la 1ere itération
    grad_f_beta0=(J'*r_beta);
    norm_grad_f_beta0= norm(grad_f_beta0);
   
    while continuer
        delta= (J'*J)\(J'*r_beta);%remplace l'inverse car calcul plus court
        beta_k=beta;%Garde en mémoire la valeur de beta à la kieme itération pour les tests d'arrêt
        norm_beta_k=norm(beta_k);%Norme de beta à la kieme itération pour les tests d'arrêt
        beta = beta -delta ;%beta à la k+1eme itération
        norm_delta=norm(delta);
        nb_it = nb_it+1;
        J=J_residu(beta);
        r_beta= residu(beta);
        f_beta_k=f_beta;%Garde en mémoire la valeur de f à la kieme itération pour les tests d'arrêt
        norm_f_beta_k= norm(f_beta_k);%Norme de f à la kieme itération pour les tests d'arrêt
        f_beta=0.5*(r_beta'*r_beta);
        grad_f_beta=(J'*r_beta);
        norm_grad_f_beta = norm(grad_f_beta);
        
        %Tests d'arrêts:
        if norm_grad_f_beta <= max(Tol_rel*norm_grad_f_beta0,Tol_abs)
            continuer=false;
            exitflag=1;
        
        elseif norm(f_beta-f_beta_k) <= max(Tol_rel*norm_f_beta_k,Tol_abs)%si f_beta_k tend vers 0, marche pas et pour corriger on remplace ce max par Tol_rel*(abs(f_beta_k)+Tol_abs) 
           
            continuer=false;
            exitflag=2;
       
        elseif norm_delta <= max(Tol_rel*norm_beta_k,Tol_abs)%si f_beta_k tend vers 0, marche pas et pour corriger on remplace ce max par Tol_rel*(abs(f_beta_k)+Tol_abs)
            continuer=false;
            exitflag=3;
        
        elseif nb_it >= n_itmax
            continuer=false;
            exitflag=4;
        end
    
    end
  
end
