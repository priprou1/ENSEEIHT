% Auteur : J. Gergaud
% décembre 2017
% -----------------------------
% 



function Jac= diff_finies_centree(fun, x, option)
%
% Cette fonction calcule les différences finies centrées sur un schéma
% Paramètres en entrées
% fun : fonction dont on cherche à calculer la matrice jacobienne
%       fonction de IR^n à valeurs dans IR^m
% x   : point où l'on veut calculer la matrice jacobienne
% option : précision du calcul de fun (ndigit)
%
% Paramètre en sortie
% Jac : Matrice jacobienne approximé par les différences finies
%        real(m,n)
% ------------------------------------
    omega=max(eps, 10^(-option));
    Jac=zeros(length(fun(x)),length(x));
    xhv1=x;
    xhv2=x;
    for i=1:length(x)
        h=omega^(1/3)*max(abs(x(i)),1)*sgn(x(i));
        xhv1(i)=x(i)+h;
        xhv2(i)=x(i)-h;
        g=(fun(xhv1)-fun(xhv2))/(2*h);
        Jac(:,i) = g;
        xhv1(i)=x(i);
        xhv2(i)=x(i);
    end
end

function s = sgn(x)
% fonction signe qui renvoie 1 si x = 0
if x==0
  s = 1;
else 
  s = sign(x);
end
end





