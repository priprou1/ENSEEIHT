% Télécommunication Séquence 3 : Etude de l'impact du bruit, filtrage
% adapté, taux d'erreur binaire, efficacité en puissance
% Auteurs : Yessine JMAL et Priscilia GONTHIER
% Groupe : 1SN-M

clear;
close all;

%# Données du problème :
Fe = 24000; % Fréquence d'échantillonnage
Rb = 3000; % Débit binaire
Te = 1/Fe; % Période d'échantillonnage
Tb = 1/Rb; % Période binaire

%# Information binaire à transmettre :
nb_bits = 10000; % Nombre de bits générés
bits = randi([0,1],1,nb_bits); % Message de nb_bits bits

%# 1. Implantation du modulateur
%## Données spécifiques à la modulation en bande de base 1 :
M = 2; % Ordre de modulation
l = log2(M); % Nombre de bits codants par symbole
Ts = l * Tb; % Période symbole
Rs = 1/Ts; % Débit symbole
Ns = Ts / Te; % Nombre de bit par symbole
long = nb_bits * Ns / l; % Longueur du signal
T = long * Te; % Durée du signal

%## Mapping binaire à moyenne nulle : 0->-1, 1->1
Symboles = 2*bits-1;

%## Suréchantillonnage :
Suite_diracs = kron(Symboles, [1 zeros(1,Ns-1)]); % Suite de Diracs pondérés par les symboles

%## Filtrage de mise en forme :
h = ones(1,Ns); % Réponse impulsionnelle du filtre (rectangulaire de durée Ts)
x = filter(h,1,Suite_diracs); % Signal transmis

%# Génération du bruit gaussien
SNR = 0.1; % Rapport signal sur bruit Eb/N0
n = genereBruit(x, SNR, Ns, M);

%# Implantation du démodulateur
h_r =  fliplr(h); % Réponse impulsionnelle du filtre de réception (rectangulaire de durée Ts)
z = filter(h_r,1,x + n);

%# Détermination de l'instant n0 optimal
% On veut n0 tel que g(n0) /= 0 et g(n0 + pNs) = 0 p€Z*, on peut voir sur
% la courbe que cela correspond à n0 = 8 = Ns (là où la courbe est maximum), et
n0 = Ns;

%# Tracé du diagramme de l'oeil en sortie du filtre de réception
z_bis = reshape(z,Ns,length(z)/Ns);
figure("Name", "Diagramme de l'oeil");
plot(z_bis(:,2:end)); % à partir de 2 pour éviter de voir le premier symbole émis
xlabel("Indice");
ylabel("z (v)");
title("Diagramme de l'oeil en sortie du filtre de réception");
grid on;


n2 = genereBruit(x, 1, Ns, M);
z2 = filter(h_r,1,x+n2);
z_bis2 = reshape(z2,Ns,length(z2)/Ns);

n3 = genereBruit(x, 10, Ns, M);
z3 = filter(h_r,1,x+n3);
z_bis3 = reshape(z3,Ns,length(z3)/Ns);

n4 = genereBruit(x, 100, Ns, M);
z4 = filter(h_r,1,x+n4);
z_bis4 = reshape(z4,Ns,length(z4)/Ns);
% Comparaison des bruits
figure("Name", "Diagramme de l'oeil");
subplot(2,2,1);
plot(z_bis(:,2:end)); % à partir de 2 pour éviter de voir le premier symbole émis
xlabel("Indice");
ylabel("z (v)");
title("SNR = 0.1");
grid on;

subplot(2,2,2);
plot(z_bis2(:,2:end)); % à partir de 2 pour éviter de voir le premier symbole émis
xlabel("Indice");
ylabel("z (v)");
title("SNR = 1");
grid on;

subplot(2,2,3);
plot(z_bis3(:,2:end)); % à partir de 2 pour éviter de voir le premier symbole émis
xlabel("Indice");
ylabel("z (v)");
title("SNR = 10");
grid on;

subplot(2,2,4);
plot(z_bis4(:,2:end)); % à partir de 2 pour éviter de voir le premier symbole émis
xlabel("Indice");
ylabel("z (v)");
title("SNR = 100");
grid on;

%# Echantillonnage du signal en sortie de filtre de réception
z_echant = z(n0:Ns:end); % z(t0 + mTs) m€N
BitsRecuperes = (sign(z_echant)+1)/2; % Demapping
erreur = abs(bits - BitsRecuperes); % Vecteur de la même taille que l'information binaire, contenant des 0 si pas d'erreur et des 1 sinon
TEB = mean(erreur); % Taux d'erreur binaire, TEB = nombre de bits reçus erronés / nombre de bits transmis

SNRdB = linspace(0,8,16);
TEB = zeros(1,length(SNRdB));
SNR = 10 .^ (SNRdB / 10);
TEBtheo = zeros(1,length(SNRdB));
TEB_moy = zeros(1,100);

%## Tracé du TEB en fonction du SNR
for i = 1:length(SNR)
    for j=1:100
        n = genereBruit(x, SNR(i), Ns, M);
        z = filter(h_r,1,x + n);
        z_echant = z(n0:Ns:end); % z(t0 + mTs) m€N
        BitsRecuperes = (sign(z_echant) + 1) / 2; % Demapping
        erreur = abs(bits - BitsRecuperes); % Vecteur de la même taille que l'information binaire, contenant des 0 si pas d'erreur et des 1 sinon
        TEB_moy(j) = mean(erreur);
    end
    TEB(i) = mean(TEB_moy);
    TEBtheo(i) = 1 - normcdf(sqrt(2 * SNR(i)));
end

figure("Name", "TEB en fonction de SNR");
semilogy(SNRdB, TEB);
xlabel("SNR (dB)");
ylabel("TEB");
title("TEB en fonction de SNR");
grid on;

figure("Name", "TEB en fonction de SNR");
semilogy(SNRdB, TEB);
hold on;
semilogy(SNRdB, TEBtheo);
xlabel("SNR (dB)");
ylabel("TEB");
title("TEB en fonction de SNR");
leg = legend('TEB',...
                 'TEBtheo',...
                 'Location','NorthWest');
grid on;


%% 5.3.1) Implantation de la chaine sans bruit
h_r = [ones(1,Ns/2) zeros(1, Ns/2)]; % Réponse impulsionnelle du filtre (rectangulaire de durée Ts/2)
z = filter(h_r,1,x);


%# Tracé du diagramme de l'oeil en sortie du filtre de réception
z_bis = reshape(z,Ns,length(z)/Ns);
figure("Name", "Diagramme de l'oeil");
plot(z_bis(:,2:end)); % à partir de 2 pour éviter de voir le premier symbole émis
xlabel("Indice");
ylabel("z (v)");
title("Diagramme de l'oeil en sortie du filtre de réception");
grid on;

% Instants optimaux théoriques : t0 \in [Ts/2, Ts]
% Instants optimaux trouvés : n0 \in [4, 8], correspond au théo

n0 = 4;

%# Echantillonnage du signal en sortie de filtre de réception
z_echant =z(n0:Ns:end); % z(t0 + mTs) m€N
BitsRecuperes=(sign(z_echant)+1)/2; % Demapping
erreur = abs(bits-BitsRecuperes); % Vecteur de la même taille que l'information binaire, contenant des 0 si pas d'erreur et des 1 sinon
TEB = mean(erreur); % Taux d'erreur binaire, TEB = nombre de bits reçus erronés / nombre de bits transmis

%## Le TEB est bien nul

%% 5.3.2) Implantation de la chaine avec bruit

%# Génération du bruit gaussien
SNR = 0.1; % Rapport signal sur bruit Eb/N0
n = genereBruit(x, SNR, Ns, M);
z_b = filter(h_r,1,x+n);

z_bbis1 = reshape(z_b,Ns,length(z_b)/Ns);

n2 = genereBruit(x, 1, Ns, M);
z_b2 = filter(h_r,1,x+n2);
z_bbis2 = reshape(z_b2,Ns,length(z_b2)/Ns);

n3 = genereBruit(x, 10, Ns, M);
z_b3 = filter(h_r,1,x+n3);
z_bbis3 = reshape(z_b3,Ns,length(z_b3)/Ns);

n4 = genereBruit(x, 100, Ns, M);
z_b4 = filter(h_r,1,x+n4);
z_bbis4 = reshape(z_b4,Ns,length(z_b4)/Ns);

figure("Name", "Diagramme de l'oeil");
subplot(2,2,1);
plot(z_bbis1(:,2:end)); % à partir de 2 pour éviter de voir le premier symbole émis
xlabel("Indice");
ylabel("z (v)");
title("SNR = 0.1");
grid on;

subplot(2,2,2);
plot(z_bbis2(:,2:end)); % à partir de 2 pour éviter de voir le premier symbole émis
xlabel("Indice");
ylabel("z (v)");
title("SNR = 1");
grid on;

subplot(2,2,3);
plot(z_bbis3(:,2:end)); % à partir de 2 pour éviter de voir le premier symbole émis
xlabel("Indice");
ylabel("z (v)");
title("SNR = 10");
grid on;

subplot(2,2,4);
plot(z_bbis4(:,2:end)); % à partir de 2 pour éviter de voir le premier symbole émis
xlabel("Indice");
ylabel("z (v)");
title("SNR = 100");
grid on;

% Tracé pour un signal bruité
SNRdB = linspace(0,8,16);
TEB = zeros(1,length(SNRdB));
SNR = 10 .^ (SNRdB / 10);
TEBtheo = zeros(1,length(SNRdB));
TEB_moy = zeros(1,100);
TEBref = zeros(1,length(SNRdB));


%## Tracé du TEB en fonction du SNR
for i = 1:length(SNR)
    for j=1:100
        n = genereBruit(x, SNR(i), Ns, M);
        z = filter(h_r,1,x + n);
        z_echant = z(n0:Ns:end); % z(t0 + mTs) m€N
        BitsRecuperes = (sign(z_echant) + 1) / 2; % Demapping
        erreur = abs(bits - BitsRecuperes); % Vecteur de la même taille que l'information binaire, contenant des 0 si pas d'erreur et des 1 sinon
        TEB_moy(j) = mean(erreur);
    end
    TEB(i) = mean(TEB_moy);
    TEBtheo(i) = 1 - normcdf(sqrt(SNR(i)));
    TEBref(i) = 1 - normcdf(sqrt(2 * SNR(i)));
    
end

figure("Name", "TEB en fonction de SNR");
semilogy(SNRdB, TEB);
xlabel("SNR (dB)");
ylabel("TEB");
title("TEB en fonction de SNR");
grid on;

figure("Name", "TEB en fonction de SNR comparé au théorique");
semilogy(SNRdB, TEB);
hold on;
semilogy(SNRdB, TEBtheo);
xlabel("SNR (dB)");
ylabel("TEB");
title("TEB en fonction de SNR");
leg = legend('TEB',...
                 'TEBtheo',...
                 'Location','NorthWest');
grid on;

figure("Name", "TEB en fonction de SNR comparé au ref");
semilogy(SNRdB, TEB);
hold on;
semilogy(SNRdB, TEBref);
xlabel("SNR (dB)");
ylabel("TEB");
title("TEB en fonction de SNR");
leg = legend('TEB',...
                 'TEBref',...
                 'Location','NorthWest');
grid on;



%% 5.4) Implantation de la chaine de référence
%# Modulateur
%## Données spécifiques à la modulation en bande de base 2 :
M2 = 4; % Ordre de modulation
l2 = log2(M2); % Nombre de bits codants par symbole
Ts2 = l2 * Tb; % Période symbole
Rs2 = 1/Ts2; % Débit symbole
Ns2 = Ts2 / Te; % Nombre de bit par symbole
%Ns2 = 8;
long2 = nb_bits * Ns2 / l2; % Longueur du signal
T2 = long2 * Te; % Durée du signal

%## Mapping 4-aire à moyenne nulle : 00->-3, 10->-1, 01->1, 11->3;
Symboles2 = (2*bi2de(reshape(bits,2,length(bits)/2).')-3).';

%## Suréchantillonnage :
Suite_diracs2 = kron(Symboles2, [1 zeros(1,Ns2-1)]); % Suite de Diracs pondérés par les symboles

%## Filtrage de mise en forme :
h2 = ones(1,Ns2); % Réponse impulsionnelle du filtre (rectangulaire de durée Ts2)
x2 = filter(h2,1,Suite_diracs2); % Signal transmis

h_r =  fliplr(h2); % Réponse impulsionnelle du filtre de réception (rectangulaire de durée Ts)
z = filter(h_r,1,x2);

oeil = eyediagram(z,2*Ns2,2*Ns2,Ns2-1); % affichage du diagramme de l'oeil depuis la fonction matlab
%# Tracé du diagramme de l'oeil en sortie du filtre de réception
z_bis = reshape(z,Ns2,length(z)/Ns2);
figure("Name", "Diagramme de l'oeil");
plot(z_bis(:,2:end)); % à partir de 2 pour éviter de voir le premier symbole émis
xlabel("Indice");
ylabel("z (v)");
title("Diagramme de l'oeil en sortie du filtre de réception");
grid on;


% 1) les temps optimaux sont 16
n0 = 16;

%# Echantillonnage du signal en sortie de filtre de réception
z_echant =z(n0:Ns2:end); % z(t0 + mTs) m€N
symboles_decides = zeros(1,length(z_echant));
for i=1:length(z_echant)
    if (z_echant(i) >= 0)
        if (z_echant(i) <= 2*Ns2)
            symboles_decides(i) = 1;
        elseif (z_echant(i) > 2*Ns2)
            symboles_decides(i) = 3;
        end
    elseif (z_echant(i) < 0)
        if ( -2*Ns2 <= z_echant(i))
            symboles_decides(i) = -1;
        elseif (z_echant(i) < -2*Ns2)
            symboles_decides(i) = -3;
        end
    end
end
SymbolesDecides = (-3) * (z_echant < -32) + (-1) * (z_echant >= -32 & z_echant < 0) + 1 * (z_echant >= 0 & z_echant <= 32) + 3 * (z_echant > 32);
BitsDecides = reshape(de2bi((symboles_decides + 3)/2).', 1, length(bits)); % Demapping
erreur = abs(bits-BitsDecides); % Vecteur de la même taille que l'information binaire, contenant des 0 si pas d'erreur et des 1 sinon
TEB = mean(erreur); % Taux d'erreur binaire, TEB = nombre de bits reçus erronés / nombre de bits transmis

%% 5.6)

Px2 = mean(abs(x2).^2); % Puissance du signal à bruiter

% Tracé pour un signal bruité
SNRdB = linspace(0,8,16);
TEB = zeros(1, length(SNRdB));
TEBtheo = zeros(1, length(SNRdB));
TEBref = zeros(1, length(SNRdB));
TEB_moy = zeros(1, 100);
TES = zeros(1, length(SNRdB));
SNR = 10 .^ (SNRdB / 10);
TEStheo = zeros(1, length(SNRdB));

%## Tracé du TES en fonction du SNR
for i = 1:length(SNR)
    for j=1:100
        n = genereBruit(x2, SNR(i), Ns2, M2);
        z = filter(h_r,1,x2 + n);
        z_echant = z(n0:Ns2:end); % z(t0 + mTs) m€N
        SymbolesDecides = (-3) * (z_echant < -32) + (-1) * (z_echant >= -32 & z_echant < 0) + 1 * (z_echant >= 0 & z_echant <= 32) + 3 * (z_echant > 32);
        TEB_moy(j)=mean(length(find(SymbolesDecides~=Symboles2))/(2*length(Symboles2)));
    end
    TEB(i) = mean(TEB_moy);

    TES(i) = TEB(i) * l2;
    TEStheo(i) = 3/2 *(1 - normcdf(sqrt(4 / 5 * SNR(i))));
    TEBref(i) = 1 - normcdf(sqrt(2 * SNR(i)));
    TEBtheo(i) = 3 / 4 * (1 - normcdf(sqrt(4 / 5 * SNR(i))));
end

%Affichages des TES
TEBtheo = (3/4) *qfunc(sqrt((4/5)*(10.^(SNRdB/10))));
figure("Name", "TES en fonction de SNR");
semilogy(SNRdB, TES);
xlabel("SNR (dB)");
ylabel("TES");
title("TES en fonction de SNR");
grid on;

figure("Name", "TES en fonction de SNR comparé au théorique");
semilogy(SNRdB, TES);
hold on;
semilogy(SNRdB, TEStheo);
xlabel("SNR (dB)");
ylabel("TES");
title("TES en fonction de SNR");
leg = legend('TES',...
                 'TEStheo',...
                 'Location','NorthWest');
grid on;

% 4) Affichage du TEB en fonction du rapport sur bruit avec la chaine
% théorique
figure("Name", "TEB en fonction de SNR");
semilogy(SNRdB, TEB);
hold on;
semilogy(SNRdB, TEBtheo);
xlabel("SNR (dB)");
ylabel("TEB");
title("TEB en fonction de SNR");
leg = legend('TEBchaine',...
                 'TEBtheo',...
                 'Location','NorthWest');
grid on;

% 5) Affichage du TEB en fonction du rapport sur bruit avec la chaine de
% référence
figure("Name", "TEB en fonction de SNR");
semilogy(SNRdB, TEB);
hold on;
semilogy(SNRdB, TEBref);
xlabel("SNR (dB)");
ylabel("TEB");
title("TEB en fonction de SNR");
leg = legend('TEBchaine',...
                 'TEBref',...
                 'Location','NorthWest');
grid on;
