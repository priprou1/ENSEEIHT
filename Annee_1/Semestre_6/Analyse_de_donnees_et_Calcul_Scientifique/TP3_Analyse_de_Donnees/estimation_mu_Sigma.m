% Définition des fonctions
function [mu, sigma] = estimation_mu_Sigma(x)
    [nb_l, nb_c] = size(x);
    mu = mean(x,1);
    x_c = x - repmat(mu, nb_l, 1);
    mu = mu';
    sigma = x_c' * x_c / nb_l;
end
