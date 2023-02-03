% Télécommunication Séquence 1 : Etude de transmissions en bande de base
% Noms : Jmal Yessine et Gonthier Priscilia
% Groupe : 1SN-M

clear;
close all;

%# Données du problème :
Fe = 24000; % Fréquence d'échantillonnage
Rb = 3000; % Débit binaire
Te = 1/Fe; % Période d'échantillonnage
Tb = 1/Rb; % Période binaire

%# Information binaire à transmettre :
nb_bits = 1000; % Nombre de bits générés
bits = randi([0,1],1,nb_bits); % Message de nb_bits bits

%% Modulation en bande de base 1 :
%## Données spécifiques à la modulation en bande de base 1 :
M1 = 2; % Ordre de modulation
l1 = log2(M1); % Nombre de bits codants par symbole
Ts1 = l1 * Tb; % Période symbole
Rs1 = 1/Ts1; % Débit symbole
Ns1 = Ts1 / Te; % Nombre de bit par symbole
long1 = nb_bits * Ns1 / l1; % Longueur du signal
T1 = long1 * Te; % Durée du signal

%## Mapping binaire à moyenne nulle : 0->-1, 1->1
Symboles1 = 2*bits-1;

%## Suréchantillonnage :
Suite_diracs1 = kron(Symboles1, [1 zeros(1,Ns1-1)]); % Suite de Diracs pondérés par les symboles

%## Filtrage de mise en forme :
h1 = ones(1,Ns1); % Réponse impulsionnelle du filtre (rectangulaire de durée Ts1)
x1 = filter(h1,1,Suite_diracs1); % Signal transmis

%## Affichages demandés :
%### Tracé du signal :
figure("Name", "Modulation 1 : Signal");
plot([0:Te:T1-Te],x1);
xlabel("temps(s)");
ylabel("x1(v)");
title("Signal transmis après le modulateur 1");
grid on;

%### Tracé de la Densité Spectrale de Puissance du signal :
DSP_x1 = pwelch(x1,[],[],[],Fe,'twosided'); % Densité Spectrale de Puissance du signal transmis
f1 = linspace(-Fe/2, Fe/2, length(DSP_x1)); % Echelle de fréquence

figure("Name", "Modulation 1 : DSP");
semilogy(f1,fftshift(abs(DSP_x1)));
xlabel("fréquence(Hz)");
ylabel("Module de la DSP");
title("Densité Spectrale de Puissance du signal transmis après le modulateur 1");
grid on;

%### Comparaison de la DSP du signal transmis avec la DSP théorique :
sigma1 = 1; % Variance sigma_a pour le calcul théorique de la DSP
DSP_th1 = sigma1 * Ts1 * sinc (f1 * Ts1) .^2; % Densité Spectrale de Puissance théorique
figure("Name", "Modulation 1 : DSP théorique");
semilogy(f1,fftshift(abs(DSP_x1)),f1,abs(DSP_th1));
xlabel("fréquence(Hz)");
ylabel("Module de la DSP");
title("Comparaison de la DSP du signal transmis avec la DSP théorique après le modulateur 1");
legend('DSP du signal', 'DSP théorique');
axis([-inf inf 10^(-10) 10^(-2)]); % Permet de donner un axe des ordonnées plus cohérent
grid on;

%% Modulation en bande de base 2 :
%## Données spécifiques à la modulation en bande de base 2 :
M2 = 4; % Ordre de modulation
l2 = log2(M2); % Nombre de bits codants par symbole
Ts2 = l2 * Tb; % Période symbole
Rs2 = 1/Ts2; % Débit symbole
Ns2 = Ts2 / Te; % Nombre de bit par symbole
long2 = nb_bits * Ns2 / l2; % Longueur du signal
T2 = long2 * Te; % Durée du signal

%## Mapping 4-aire à moyenne nulle : 00->-3, 10->-1, 01->1, 11->3;
Symboles2 = reshape(bits,2,nb_bits/2);
Symboles2 = bi2de(Symboles2');
Symboles2 = Symboles2 * 2 - 3;

%## Suréchantillonnage :
Suite_diracs2 = kron(Symboles2', [1 zeros(1,Ns2-1)]); % Suite de Diracs pondérés par les symboles

%## Filtrage de mise en forme :
h2 = ones(1,Ns2); % Réponse impulsionnelle du filtre (rectangulaire de durée Ts2)
x2 = filter(h2,1,Suite_diracs2); % Signal transmis

%## Affichages demandés :
%### Tracé du signal :
figure("Name", "Modulation 2 : Signal");
plot([0:Te:T2-Te],x2);
xlabel("temps(s)");
ylabel("x2(v)");
title("Signal transmis après le modulateur 2");
grid on;

%### Tracé de la Densité Spectrale de Puissance du signal :
DSP_x2 = pwelch(x2,[],[],[],Fe,'twosided'); % Densité Spectrale de Puissance du signal transmis
f2 = linspace(-Fe/2, Fe/2, length(DSP_x2)); % Echelle de fréquence

figure("Name", "Modulation 2 : DSP");
semilogy(f2,fftshift(abs(DSP_x2)));
xlabel("fréquence(Hz)");
ylabel("Module de la DSP");
title("Densité Spectrale de Puissance du signal transmis après le modulateur 2");
grid on;

%### Comparaison de la DSP du signal transmis avec la DSP théorique :
sigma2 = ((-1)^2 + (-3)^2 + 1^2 + 3^2)/4; % Variance sigma_a pour le calcul théorique de la DSP
DSP_th2 = sigma2 * Ts2 * sinc (f2 * Ts2) .^2; % Densité Spectrale de Puissance théorique
figure("Name", "Modulation 2 : DSP théorique");
semilogy(f2,fftshift(abs(DSP_x2)),f2,abs(DSP_th2));
xlabel("fréquence(Hz)");
ylabel("Module de la DSP");
title("Comparaison de la DSP du signal transmis avec la DSP théorique après le modulateur 2");
legend('DSP du signal', 'DSP théorique');
axis([-inf inf 10^(-10) 10^(-2)]); % Permet de donner un axe des ordonnées plus cohérent
grid on;

%% Modulation en bande de base 3 :
%## Données spécifiques à la modulation en bande de base 3 :
M3 = 2; % Ordre de modulation
l3 = log2(M3); % Nombre de bits codants par symbole
Ts3 = l3 * Tb; % Période symbole
Rs3 = 1/Ts3; % Débit symbole
Ns3 = Ts3 / Te; % Nombre de bit par symbole
long3 = nb_bits * Ns3 / l3; % Longueur du signal
T3 = long3 * Te; % Durée du signal
alpha = 0.5; % roll-off : paramètre qui fixe la largeur de bande
L = 4; % Paramètre qui fixe la longueur de la réponse impultionnelle du filtre, plus il est grand, plus l'ordre du filtre sera élevé

%## Mapping binaire à moyenne nulle : 0->-1, 1->1
Symboles3 = 2*bits-1;

%## Suréchantillonnage :
Suite_diracs3 = kron(Symboles3, [1 zeros(1,Ns3-1)]); % Suite de Diracs pondérés par les symboles

%## Filtrage de mise en forme :
h3 = rcosdesign(alpha,L,Ns3); % Réponse impulsionnelle du filtre (en racine de cosinus surelévé)
x3 = filter(h3,1,Suite_diracs3); % Signal transmis

%## Affichages demandés :
%### Tracé du signal :
figure("Name", "Modulation 3 : Signal");
plot([0:Te:T2-Te],x3);
xlabel("temps(s)");
ylabel("x3(v)");
title("Signal transmis après le modulateur 3");
grid on;

%### Tracé de la Densité Spectrale de Puissance du signal :
DSP_x3 = pwelch(x3,[],[],[],Fe,'twosided'); % Densité Spectrale de Puissance du signal transmis
f3 = linspace(-Fe/2, Fe/2, length(DSP_x3)); % Echelle de fréquence

figure("Name", "Modulation 3 : DSP");
semilogy(f3,fftshift(abs(DSP_x3)));
xlabel("fréquence(Hz)");
ylabel("Module de la DSP");
title("Densité Spectrale de Puissance du signal transmis après le modulateur 3");
grid on;

%### Comparaison de la DSP du signal transmis avec la DSP théorique :
% Calcul de la Densité Spectrale de Puissance théorique
sigma3 = 1; % Variance sigma_a pour le calcul théorique de la DSP
S1 = sigma3 * Ts3 * ones(1 , length(f3));
S2 = sigma3 * Ts3 * ((1 + cos((pi * Ts3)/alpha * (abs(f3) - ((1 - alpha)/(2 * Ts3)))))/2).^2;
DSP_th3 = S1 .* (abs(f3) <= (1-alpha)/(2*Ts3)) + S2 .* (abs(f3) >= (1-alpha)/(2*Ts3) & abs(f3) <= (1+alpha)/(2*Ts3));

figure("Name", "Modulation 3 : DSP théorique");
semilogy(f3,fftshift(abs(DSP_x3)),f3,abs(DSP_th3));
xlabel("fréquence(Hz)");
ylabel("Module de la DSP");
title("Comparaison de la DSP du signal transmis avec la DSP théorique après le modulateur 3");
legend('DSP du signal', 'DSP théorique');
grid on;

%% Comparaison des différents modulateurs
%# Tracé des DSP pour les différents modulateurs
figure("Name", "Comparaison des modulateurs");
semilogy(f1,fftshift(abs(DSP_x1)),f2,fftshift(abs(DSP_x2)),f3,fftshift(abs(DSP_x3))); % On normalise pour pouvoir comparer les courbes
xlabel("fréquence(Hz)");
ylabel("Module de la DSP");
title("Comparaison de la DSP du signal transmis après les différents modulateurs");
legend('DSP pour le modulateur 1', 'DSP pour le modulateur 2', 'DSP pour le modulateur 3');
grid on;


