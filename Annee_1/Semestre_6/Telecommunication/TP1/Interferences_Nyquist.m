% Télécommunication Séquence 2 : Etude des interférences entre symbole et
% du critère de Nyquist
% Auteurs Yessine JMAL et Priscilia GONTHIER
% Groupe : 1SN-M

clear;
close all;

%# Données du problème :
Fe = 24000; % Fréquene d'échantillonnage
Rb = 3000; % Débit binaire
Te = 1/Fe; % Période d'échantillonnage
Tb = 1/Rb; % Période binaire

%# Information binaire à transmettre :
nb_bits = 1000; % Nombre de bits générés
bits = randi([0,1],1,nb_bits); % Message de nb_bits bits

%% Etude sans canal de propagation
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

%# Implantation du démodulateur
h_r =  fliplr(h); % Réponse impulsionnelle du filtre de réception (rectangulaire de durée Ts)
z=filter(h_r,1,x);

%# 2. Tracé du signal :
figure("Name", "Modulation/Démodulation : Signal reçu");
plot([0:Te:T-Te],z);
xlabel("temps(s)");
ylabel("x(v)");
title("Signal en sortie du filtre de réception");
grid on;


%# Réponse impulsionnelle globale de la chaine de transmission g
g = conv(h,h_r); % g = h(t) conv h_r(t) car il n'y a pas de canal de propagation

%## 3.Tracé de la réponse impulsionnelle globale de la chaine de transmission :
figure("Name", "RI g");
plot(g);
xlabel("Indice");
ylabel("g (v)");
title("Réponse impulsionnelle globale de la chaine de transmission");
grid on;


%# 4. Détermination de l'instant n0 optimal
% On veut n0 tel que g(n0) /= 0 et g(n0 + pNs) = 0 p€Z*, on peut voir sur
% la courbe que cela correspond à n0 = 8 = Ns (là où la courbe est maximum)
n0 = Ns;

%# 5. Tracé du diagramme de l'oeil en sortie du filtre de réception
z_bis = reshape(z,Ns,length(z)/Ns);
figure("Name", "Diagramme de l'oeil");
plot(z_bis(:,2:end));% à partir de 2 pour éviter de voir le premier symbole émis
xlabel("Indice");
ylabel("z (v)");
title("Diagramme de l'oeil en sortie du filtre de réception");
grid on;


%# 7. Echantillonnage du signal en sortie de filtre de réception
z_echant =z(n0:Ns:end);% z(t0 + mTs) m€N
BitsRecuperes=(sign(z_echant)+1)/2; % Demapping
erreur = abs(bits-BitsRecuperes); % Vecteur de la même taille que l'information binaire, contenant des 0 si pas d'erreur et des 1 sinon
TEB = mean(erreur); % Taux d'erreur binaire, TEB = nombre de bits reçus erronés / nombre de bits transmis

%# 8. Echantillonnage du signal en sortie de filtre de réception pour n0 = 3
z_echant3 = z(3:Ns:end);
BitsRecuperes3=(sign(z_echant3)+1)/2; % Demapping
erreur3 = abs(bits-BitsRecuperes3); % Vecteur de la même taille que l'information binaire, contenant des 0 si pas d'erreur et des 1 sinon
TEB3 = mean(erreur3); % Taux d'erreur binaire, TEB = nombre de bits reçus erronés / nombre de bits transmis

%% Etude avec canal de propagation
%# Canal de propagation 1:
%# Implantation du modulateur
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

%# Implantation du canal de propagation 1
N = 101; % Ordre du filtre
fc1 = 8000; % Fréquence de coupure du canal 1
h_c1 = (2 * fc1 / Fe) * sinc(2 * (fc1 / Fe) * linspace(-(N-1)/2, (N-1)/2)); % Réponse impultionnelle du canal 1
x_f = [x zeros(1, (N-1)/2)]; % ajout de zero à la fin pour enlever le retard 
r = filter(h_c1,1,x_f);
r = r((N-1)/2+1:end); % supression des zeros au début pour enlever le retard 

%# Implantation du démodulateur
h_r =  fliplr(h); % Réponse impulsionnelle du filtre de réception (rectangulaire de durée Ts)
z = filter(h_r,1,r);

%# Réponse impulsionnelle globale de la chaine de transmission g
g1 = conv(conv(h, h_r),h_c1); % g = h(t) conv h_r(t) conv h_c(t)

%## Tracé de la réponse impulsionnelle globale de la chaine de transmission :
figure("Name", "RI g1");
plot(g1);
xlabel("Indice");
ylabel("g1 (v)");
title("Réponse impulsionnelle globale de la chaine de transmission avec canal de propagation 1");
grid on;

%# Détermination de l'instatn n0 optimal
% On veut n0 tel que g(n0) /= 0 et g(n0 + pNs) = 0 p€Z*, on peut voir sur
% la courbe que cela correspond à n0 = 8 = Ns (là où la courbe est maximum)
n0 = Ns;

%# Tracé du diagramme de l'oeil en sortie du filtre de réception
z_bis = reshape(z,Ns,length(z)/Ns);
figure("Name", "Diagramme de l'oeil");
plot(z_bis(:,2:end));% à partir de 2 pour éviter de voir le premier symbole émis
xlabel("Indice");
ylabel("z (v)");
title("Diagramme de l'oeil en sortie du filtre de réception");
grid on;

%# Représentation des filtres
H = fft(h, 1024);
Hr = fft(h_r, 1024);
Hc1 = fft(h_c1, 1024);
abs_H_Hr = abs(H .* Hr);

figure("Name", "Représentation des filtres en fréquence");
hold on;
plot(linspace(-Fe/2,Fe/2,1024), fftshift(abs_H_Hr / max(abs_H_Hr)));
plot(linspace(-Fe/2,Fe/2,1024), fftshift(abs(Hc1) / max(abs(Hc1))));
plot(linspace(-Fe/2,Fe/2,1024), fftshift(H/max(H)));
leg = legend('|H(f)Hr(f)|',...
                 '|Hc(f)|',...
                 'H(f)',...
                 'Location','NorthWest');
set(leg,'FontSize',14);
xlabel("Fréquences");
ylabel("Filtres");
title("Représentation des filtres en fréquence");
grid on;

%# Echantillonnage du signal en sortie de filtre de réception
z_echant =z(n0:Ns:end);% z(t0 + mTs) m€N
BitsRecuperes=(sign(z_echant)+1)/2; % Demapping
erreur = abs(bits-BitsRecuperes); % Vecteur de la même taille que l'information binaire, contenant des 0 si pas d'erreur et des 1 sinon
TEBc1 = mean(erreur); % Taux d'erreur binaire, TEB = nombre de bits reçus erronés / nombre de bits transmis
% Explication du résultat ....

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# Canal de propagation 2:
%# Implantation du modulateur
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


%# Implantation du canal de propagation 1
N = 101; % Ordre du filtre
fc2 = 1000; % Fréquence de coupure du canal 1
h_c2 = (2 * fc2 / Fe) * sinc(2 * (fc2 / Fe) * linspace(-(N-1)/2, (N-1)/2)); % Réponse impultionnelle du canal 1
x_f = [x zeros(1, (N-1)/2)]; % ajout de zero à la fin pour enlever le retard 
r = filter(h_c2,1,x_f);
r = r((N-1)/2+1:end); % supression des zeros au début pour enlever le retard 

%# Implantation du démodulateur
h_r =  fliplr(h); % Réponse impulsionnelle du filtre de réception (rectangulaire de durée Ts)
z = filter(h_r,1,r);

%# Réponse impulsionnelle globale de la chaine de transmission g
g2 = conv(conv(h, h_r),h_c2); % g = h(t) conv h_r(t) conv h_c(t)

%## Tracé de la réponse impulsionnelle globale de la chaine de transmission :
figure("Name", "RI g2");
plot(g2);
xlabel("Indice");
ylabel("g2 (v)");
title("Réponse impulsionnelle globale de la chaine de transmission avec canal de propagation 2");
grid on;

%# Détermination de l'instatn n0 optimal
% On veut n0 tel que g(n0) /= 0 et g(n0 + pNs) = 0 p€Z*, on peut voir sur
% la courbe que cela correspond à n0 = 8 = Ns (là où la courbe est maximum), et
n0 = Ns;

%# Tracé du diagramme de l'oeil en sortie du filtre de réception
z_bis = reshape(z,Ns,length(z)/Ns);
figure("Name", "Diagramme de l'oeil");
plot(z_bis(:,2:end));% à partir de 2 pour éviter de voir le premier symbole émis
xlabel("Indice");
ylabel("z (v)");
title("Diagramme de l'oeil en sortie du filtre de réception");
grid on;

%# Représentation des filtres
H = fft(h, 1024);
Hr = fft(h_r, 1024);
Hc2 = fft(h_c2, 1024);
abs_H_Hr = abs(H .* Hr);

figure("Name", "Représentation des filtres en fréquence");
hold on;
plot(linspace(-Fe/2,Fe/2,1024), fftshift(abs_H_Hr / max(abs_H_Hr)));
plot(linspace(-Fe/2,Fe/2,1024), fftshift(abs(Hc2) / max(abs(Hc2))));
plot(linspace(-Fe/2,Fe/2,1024), fftshift(H/max(H)));
leg = legend('|H(f)Hr(f)|',...
                 '|Hc(f)|',...
                 'H(f)',...
                 'Location','NorthWest');
set(leg,'FontSize',14);
xlabel("Fréquences");
ylabel("Filtres");
title("Représentation des filtres en fréquence");
grid on;

%# Echantillonnage du signal en sortie de filtre de réception
z_echant =z(n0:Ns:end);% z(t0 + mTs) m€N
BitsRecuperes=(sign(z_echant)+1)/2; % Demapping
erreur = abs(bits-BitsRecuperes); % Vecteur de la même taille que l'information binaire, contenant des 0 si pas d'erreur et des 1 sinon
TEBc2 = mean(erreur); % Taux d'erreur binaire, TEB = nombre de bits reçus erronés / nombre de bits transmis
