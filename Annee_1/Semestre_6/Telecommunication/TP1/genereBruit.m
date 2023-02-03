function n = genereBruit(x, SNR, Ns, M)
%GENEREBRUIT Summary of this function goes here
%   Génère un bruit gaussien d'après un rapport signal sur bruit et un
%   signal
%   n Bruit gaussien
Px = mean(abs(x).^2);
sigma_n2 = (Px * Ns) / (2 * log2(M) * SNR);
sigma_n = sqrt(sigma_n2);
n = sigma_n * randn(1, length(x));
end

