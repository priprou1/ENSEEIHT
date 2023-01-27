function [beta, norm_grad_f_beta, f_beta, norm_delta, nb_it, exitflag] ...
          = Algo_Newton(Hess_f_C14, beta0, option)
%************************************************************
% Fichier  ~gergaud/ENS/Optim1a/TP-optim-20-21/Newton_ref.m *
% Novembre 2020                                             *
% Universit√© de Toulouse, INP-ENSEEIHT                      *
%************************************************************
%
% Newton rÈsout par l'algorithme de Newton les problemes aux moindres carres
% Min 0.5||r(beta)||^2
% beta \in R^p
%
% Parametres en entrees
% --------------------
% Hess_f_C14 : fonction qui code la hessiennne de f
%              Hess_f_C14 : R^p --> matrice (p,p)
%              (la fonction retourne aussi le residu et la jacobienne)
% beta0  : point de d√©part
%          real(p)
% option(1) : Tol_abs, tol√©rance absolue
%             real
% option(2) : Tol_rel, tol√©rance relative
%             real
% option(3) : nitimax, nombre d'it√©rations maximum
%             integer
%
% Parametres en sortie
% --------------------
% beta      : beta
%             real(p)
% norm_gradf_beta : ||gradient f(beta)||
%                   real
% f_beta    : f(beta)
%             real
% res       : r(beta)
%             real(n)
% norm_delta : ||delta||
%              real
% nbit       : nombre d'it√©rations
%              integer
% exitflag   : indicateur de sortie
%              integer entre 1 et 4
% exitflag = 1 : ||gradient f(beta)|| < max(Tol_rel||gradient f(beta0)||,Tol_abs)
% exitflag = 2 : |f(beta^{k+1})-f(beta^k)| < max(Tol_rel|f(beta^k)|,Tol_abs)
% exitflag = 3 : ||delta)|| < max(Tol_rel delta^k),Tol_abs)
% exitflag = 4 : nombre maximum d'it√©rations atteint
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
    
    %Calcul des valeurs utiles pour les tests d'arrÍts:
    [H_f, r_beta, J]=Hess_f_C14(beta0);
    
    f_beta=0.5*(r_beta'*r_beta);%pour permettre le calcul de f_beta_k dËs la 1ere itÈration
    grad_f_beta0=(J'*r_beta);
    norm_grad_f_beta0= norm(grad_f_beta0);
   
   
    while continuer
   
        delta= (H_f)\(J'*r_beta);%remplace l'inverse car calcul plus court
        beta_k=beta;%Garde en mÈmoire la valeur de beta ‡ la kieme itÈration pour les tests d'arrÍt
        norm_beta_k=norm(beta_k);%Norme de beta ‡ la kieme itÈration pour les tests d'arrÍt
        beta = beta -delta ;%beta ‡ la k+1eme itÈration
        norm_delta=norm(delta);
        nb_it = nb_it+1;
        [H_f, r_beta, J]=Hess_f_C14(beta);
       
        f_beta_k=f_beta;%Garde en mÈmoire la valeur de f ‡ la kieme itÈration pour les tests d'arrÍt
        norm_f_beta_k= norm(f_beta_k);%Norme de f ‡ la kieme itÈration pour les tests d'arrÍt
        f_beta=0.5*(r_beta'*r_beta);
        grad_f_beta=(J'*r_beta);
        norm_grad_f_beta = norm(grad_f_beta);
        
        
        %Tests d'arrÍts:
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
