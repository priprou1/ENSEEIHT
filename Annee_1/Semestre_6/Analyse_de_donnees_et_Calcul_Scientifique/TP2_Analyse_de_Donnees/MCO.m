function beta_chapeau = MCO(x,y)
%MCO Summary of this function goes here
%   Detailed explanation goes here
n = length(x);
A = [x.^2 x.*y y.^2 x y ones(n,1); 1 0 1 0 0 0]; % la dernière ligne correspond à l'ajout de la contrainte
B = [zeros(n,1); 1];
beta_chapeau = pinv(A) * B;
beta_chapeau = beta_chapeau;
end

