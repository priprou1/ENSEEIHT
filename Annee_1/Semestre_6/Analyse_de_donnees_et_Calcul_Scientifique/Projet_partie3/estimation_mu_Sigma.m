function [mu,Sigma] = estimation_mu_Sigma(X)
    mu = X' * ones(length(X),1)/length(X);
    Sigma = (X - mu')' *(X - mu')/length(X);
end