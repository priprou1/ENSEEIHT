% ##Projet de Traitement du signal
% Auteurs : Yessine Jmal et Priscilia Gonthier 

% Pour placer bits_utilisateur1 et bits_utilisateurs2
load donnees1.mat
load donnees2.mat

% ##Paramètres

% Fréquences porteuses:
fp1 = 0;
fp2 = 46000;

T = 40*10^(-3); % durée d'un timeslot
F = 1/T;% Fréquence d'un timeslot

Fe = 120000; % Fréquence d'échantillonnage
Te = 1/Fe; % Période d'échantillonnage

N = length(bits_utilisateur1); %Nombre de bits des messages 
Nes = T/Te; % Nombre d'échantillons dans un timeslot

Ns = Nes/N;% Nombre de bit par échantillon
Ts = Ns*Te; % Durée de modulation


% Signaux sans bruit
m1 = bits_utilisateur1*2-1;
m2 = bits_utilisateur2*2-1;

% Signaux modulé
m1_module = kron(m1,ones(1,Ns));
m2_module = kron(m2,ones(1,Ns));

% Tracer de m1(t) et m2(t)
figure("Name", "M1_modulé");
plot([0:Te:T-Te],m1_module);
xlabel("temps(s)");
ylabel("m1(v)");
title("tracé de m1");
figure("Name", "M2_modulé");
plot([0:Te:T-Te],m2_module);
xlabel("temps(s)");
ylabel("m2(v)");
title("tracé de m2");

% Calcul et affichage de la DSP des signaux utilisateurs
DSP_m1 = fft(xcorr(m1_module)); %DSP DE M1
DSP_m2 = fft(xcorr(m2_module)); %DSP DE M2
figure("Name", "DSP_M1_modulé");
plot(linspace(-Fe/2, Fe/2, length(DSP_m1)),fftshift(abs(DSP_m1)));
xlabel("fréquence(hz)");
ylabel("module de la DSP");
title("tracé de DSP de m1");
figure("Name", "DSP_M2_modulé");
plot(linspace(-Fe/2, Fe/2, length(DSP_m2)),fftshift(abs(DSP_m2)));
xlabel("fréquence(hz)");
ylabel("module de la DSP");
title("tracé de DSP de m2");

% ##Construction du signal MF-TDMA
Slot = zeros(1,Nes); %Construction d'un Slot
Time_slot1 = [Slot m1_module Slot Slot Slot]; %Création du 1er timeslot 
Time_slot2 = [Slot Slot Slot Slot m2_module]; %Création du 2eme timeslot 

%Affichage des timeslots
figure("Name", "Time_Slot1");
plot(linspace(0, 5*T, Nes*5),Time_slot1);
xlabel("temps(s)");
ylabel("signal(v)");
title("Signal m_1(t) dans le timeslot n° 2");
figure("Name", "Time_Slot2");
plot(linspace(0, 5*T, Nes*5),Time_slot2);
xlabel("temps(s)");
ylabel("signal(v)");
title("Signal m_2(t) dans le timeslot n° 5");

%Construction de x1(t) et x2(t)
x1 = Time_slot1 .* cos(2*pi*fp1*[0:Te:(Nes*5-1)*Te]);
x2 = Time_slot2 .* cos(2*pi*fp2*[0:Te:(Nes*5-1)*Te]);

figure("Name", "x1");
plot(linspace(0, 5*T, Nes*5),x1);
xlabel("temps(s)");
ylabel("signal(v)");
title("tracé de x1");
figure("Name", "x2");
plot(linspace(0, 5*T, Nes*5),x2);
xlabel("temps(s)");
ylabel("signal(v)");
title(" tracé de x2 ");

%Construction du signal bruité
R = 100; %Rapport signal sur bruit
x = x1 + x2;%Signal non bruité
P_x = mean(abs(x).^2);%Puissance du signal non bruité
P_bruit = P_x * 10^(-R/10); %Puissance du bruit 
n = sqrt(P_bruit)*randn(1,5*Nes); %Bruit gaussien
x = x + n; %ajout du bruit gaussien au signal 

%Affichage du signal bruité
figure("Name", "x");
plot(linspace(0, 5*T, Nes*5),x);
xlabel("temps(s)");
ylabel("signal bruité(v)");
title("tracé du signal bruité");

%Estimer et afficher la DSP de x:
DSP_x = fft(xcorr(x));
figure("Name", "DSP_x");
plot(linspace(-Fe/2, Fe/2, length(DSP_x)),fftshift(abs(DSP_x)));
xlabel("frequence(hz)");
ylabel("module de la DSP de x");
title("DSP de x ");


%#Comparaison des différentes fenêtres pour la DSP du signal x
% En échelle semilog
figure("Name", "Comparaison des différentes fenêtres en échelle semilog");
%fenêtre Rectangulaire
subplot(2,2,1);
semilogy(linspace(-Fe/2, Fe/2, length(DSP_x)),fftshift(abs(DSP_x)));
title("Fenêtre Naturelle");
xlabel("fréquence(hz)");
ylabel("module de la DSP");

z_p = 2^nextpow2(length(x)); %nombre de points pour effectuer le zero padding

%fenêtre de Hamming
w=window(@hamming,length(x));
x_ham=x.*w.';
X_Ham=fft(x_ham,z_p);
subplot(2,2,2);
semilogy(linspace(-Fe/2,Fe/2,z_p),fftshift(abs(X_Ham)));
title('Fenêtre de Hamming');
xlabel("fréquence(hz)");
ylabel("module de la DSP");

%fenêtre de Blackman
w=window(@blackman,length(x));
x_b=x.*w.';
X_B=fft(x_b,z_p);
subplot(2,2,3);
semilogy(linspace(-Fe/2,Fe/2,z_p),fftshift(abs(X_B)));
title('Fenêtre de Blackman');
xlabel("fréquence(hz)");
ylabel("module de la DSP");

%méthode de welch
pxx=pwelch(x,[],length(x)/20,Fe,'twosided');
subplot(2,2,4);
semilogy(linspace(-Fe/2,Fe/2,length(pxx)),fftshift(abs(pxx)));
title('Méthode de welch');
xlabel("fréquence(hz)");
ylabel("module de la DSP");

% En échelle classique
figure("Name", "Comparaison des différentes fenêtres, en échelle classique");
%fenêtre Rectangulaire
subplot(2,2,1);
plot(linspace(-Fe/2, Fe/2, length(DSP_x)),fftshift(abs(DSP_x)));
title("Fenêtre Naturelle");
xlabel("fréquence(hz)");
ylabel("module de la DSP");

%fenêtre de Hamming
w=window(@hamming,length(x));
x_ham=x.*w.';
X_Ham=fft(x_ham,z_p);
subplot(2,2,2);
plot(linspace(-Fe/2,Fe/2,z_p),fftshift(abs(X_Ham)));
title('Fenêtre de Hamming');
xlabel("fréquence(hz)");
ylabel("module de la DSP");

%fenêtre de Blackman
w=window(@blackman,length(x));
x_b=x.*w.';
X_B=fft(x_b,z_p);
subplot(2,2,3);
plot(linspace(-Fe/2,Fe/2,z_p),fftshift(abs(X_B)));
title('Fenêtre de Blackman');
xlabel("fréquence(hz)");
ylabel("module de la DSP");

%méthode de welch
pxx=pwelch(x,[],length(x)/20,Fe,'twosided');
subplot(2,2,4);
plot(linspace(-Fe/2,Fe/2,length(pxx)),fftshift(abs(pxx)));
title('Méthode de welch');
xlabel("fréquence(hz)");
ylabel("module de la DSP");


%##Construction du récepteur

%# Démultiplexage des porteuses par filtrage
%Synthèse du filtre passe-bas
fc_pb_x1tild = 20000; %fréquence de coupure 
fc_pb_x1tild = fc_pb_x1tild/Fe; %normalisation de la fréquence de coupure 
Ord_1 = 201;% Ordre du filtre (doit etre impaire car on calcule (Ord_1-1)/2 qui doit être entier)

Rif_pb_x1tild = 2*fc_pb_x1tild*sinc(2*fc_pb_x1tild*[-(Ord_1-1)/2:(Ord_1-1)/2]); %réponse impulsionelle du filtre

figure ("Name", "Réponse impulsionnelle du filtre passe-bas de ~x1");
plot([0-(Ord_1-1)/2:1:((Ord_1-1)-(Ord_1-1)/2)],Rif_pb_x1tild); % pour donner un axe des abscisses
xlabel("Temps (s)");
ylabel("Tension (V)");
title('Réponse impulsionnelle du filtre passe-bas de ~x1','FontSize',12)

RIF1 = fft(Rif_pb_x1tild); %reponse en fréquence 
figure ("Name", "Représentation fréquentielle du filtre passe-bas de ~x1");
plot(linspace(-Fe/2,Fe/2,Ord_1),fftshift(abs(RIF1)));
xlabel("Fréquence (Hz)");
ylabel("module de la DSP");
title('Représentation fréquentielle du filtre passe-bas de ~x1','FontSize',12)

figure ("Name", "Représentation fréquentielle du filtre passe-bas de ~x1 et du signal x");
subplot(2,1,1);
plot(linspace(-Fe/2,Fe/2, Ord_1),fftshift(abs(RIF1)));
hold on;
plot(linspace(-Fe/2, Fe/2, length(DSP_x)),fftshift(abs(DSP_x)/max(abs(DSP_x))));%normalisé pour visualiser les 2 signaux ensembles
                                                                                %car l'amplitude du module de la DSP de x est 10^5
                                                                                %fois plus grande que l'amplitude de la réponse 
                                                                                % fréquentielle du filtre 
xlabel("Fréquence (Hz)");
ylabel("module de la DSP");
title("Représentation fréquentielle du filtre passe-bas de ~x1 et du signal x");
legend("Réponse fréquentielle du filtre", "DSP du signal avant filtrage");

%DSP de ~x1
x_pad = [x,zeros(1,(Ord_1-1)/2)];%ajouter des zeros pour corriger le problème de causalité des filtres 
x1tild = filter(Rif_pb_x1tild,1,x_pad); %filtrer le signal
x1tild = x1tild((Ord_1-1)/2+1:end); %éliminer les zeros ajoutés 
DSP_x1tild = fft(xcorr(x1tild)); %la DSP de x1tild
subplot(2,1,2);
plot(linspace(-Fe/2, Fe/2, length(DSP_x1tild)),fftshift(abs(DSP_x1tild)));
xlabel("Fréquence (Hz)");
ylabel("module de la DSP");
title("DSP du signal après filtrage")


%Synthèse du filtre passe-haut
fc_pb_x2tild = 20000; %fréquence de coupure 
fc_pb_x2tild = fc_pb_x2tild/Fe;%normalisation de la fréqunce de coupure 
Ord_1 = 201;% Ordre du filtre

Rif_ph_x2tild =  - 2*fc_pb_x2tild*sinc(2*fc_pb_x2tild*[-(Ord_1-1)/2:(Ord_1-1)/2]);
Rif_ph_x2tild((Ord_1-1)/2+1) = 1 + Rif_ph_x2tild((Ord_1-1)/2+1);%réponse impulsionelle du filtre 
figure ("Name", "Réponse impulsionnelle du filtre passe-haut de ~x2");
plot([0-(Ord_1-1)/2:1:((Ord_1-1)-(Ord_1-1)/2)],Rif_ph_x2tild); % pour donner un axe des abscisses
xlabel("Temps (s)");
ylabel("Tension (V)");
title('Réponse impulsionnelle du filtre passe-haut de ~x2','FontSize',12);

RIF2 = fft(Rif_ph_x2tild); %réponse fréquentielle du filtre 
figure ("Name", "Représentation fréquentielle du filtre passe-haut de ~x2");
plot(linspace(-Fe/2,Fe/2,Ord_1),fftshift(abs(RIF2)));
xlabel("Fréquence (Hz)");
ylabel("module de la DSP");
title('Représentation fréquentielle du filtre passe-haut de ~x2','FontSize',12)

figure ("Name", "Représentation fréquentielle du filtre passe-haut de ~x2 et du signal x");
subplot(2,1,1);
plot(linspace(-Fe/2,Fe/2, Ord_1),fftshift(abs(RIF2)));
hold on;
plot(linspace(-Fe/2, Fe/2, length(DSP_x)),fftshift(abs(DSP_x)/max(abs(DSP_x))));%normalisé pour visualiser les 2 signaux ensembles
xlabel("Fréquence (Hz)");
ylabel("module de la DSP");
title("Représentation fréquentielle du filtre passe-haut de ~x2 et du signal x");
legend("Réponse fréquentielle du filtre", "DSP du signal avant filtrage");


%DSP de ~x2
x_pad = [x,zeros(1,(Ord_1-1)/2)];%Ajout de zeros pour éviter la présence de retard sur le signal filtré due à la causalité du filtre
x2tild = filter(Rif_ph_x2tild,1,x_pad);%filtrage du signal
x2tild = x2tild((Ord_1-1)/2+1:end);%élimination es zeros 
DSP_x2tild = fft(xcorr(x2tild)); %dsp du signal filtré
subplot(2,1,2);
plot(linspace(-Fe/2, Fe/2, length(DSP_x2tild)),fftshift(abs(DSP_x2tild)));
xlabel("Fréquence (Hz)");
ylabel("module de la DSP");
title("DSP du signal filtré");

%Affichage des signaux x1tild et x2tild en temporel et en fréquentiel.
figure("Name","Signaux ~x1(t) et ~x2(t)");
subplot(2,1,1);
plot(linspace(0, 5*T, Nes*5),x1tild);
xlabel("temps(s)");
ylabel("signal(v)");
title("tracé de ~x1");

subplot(2,1,2);
plot(linspace(0, 5*T, Nes*5),x2tild);
xlabel("temps(s)");
ylabel("signal(v)");
title("tracé de ~x2");


figure("Name","DSP de ~x1 et ~x2");
subplot(2,1,1);
plot(linspace(-Fe/2, Fe/2, length(DSP_x1tild)),fftshift(abs(DSP_x1tild)));
xlabel("Fréquence (Hz)");
ylabel("Module de la DSP");
title("DSP du signal ~x1");
subplot(2,1,2);
plot(linspace(-Fe/2, Fe/2, length(DSP_x2tild)),fftshift(abs(DSP_x2tild)));
xlabel("Fréquence (Hz)");
ylabel("Module de la DSP");
title("DSP du signal ~x2");


%Retour en bande de base
x1_trouve = x1tild .* cos(2*pi*fp1*[0:Te:(Nes*5-1)*Te]);
x2_trouve = x2tild .* cos(2*pi*fp2*[0:Te:(Nes*5-1)*Te]);

%On a affiché ceci pour déterminer la fréquence de coupure 
%signaux x1 et x2 avant filtrage
figure ("Name", "x1 et x2 trouvées");
subplot(2,1,1);
plot(linspace(0, 5*T, Nes*5),x1_trouve);
xlabel("temps(s)");
ylabel("x1 trouvé(v)");
title("x1 trouvé avant filtrage");

subplot(2,1,2);
plot(linspace(0, 5*T, Nes*5),x2_trouve);
xlabel("temps(s)");
ylabel("x2 trouvé(v)");
title("x2 trouvé avant filtage ");

%DSP de x1 et x2 avant filtrage
figure ("Name", "DSP x1 x2 trouvée");
subplot(2,1,1);
DSP_x1trouve = fft(xcorr(x1_trouve)); %DSP de x1
plot(linspace(-Fe/2, Fe/2, length(DSP_x1trouve)),fftshift(abs(DSP_x1trouve)));
xlabel("Fréquence (Hz)");
ylabel("module de la DSP");
title("DSP De x1 trouvé avant filtrage ")
subplot(2,1,2);
DSP_x2trouve = fft(xcorr(x2_trouve)); %dsp de x2
plot(linspace(-Fe/2, Fe/2, length(DSP_x2trouve)),fftshift(abs(DSP_x2trouve)));
xlabel("Fréquence (Hz)");
ylabel("module de la DSP");
title("DSP De x2 trouvé avant filtrage")

%restitution des signaux de départ 

%premier filtre passe-bas 
fc_f1 = 10000; %fréquence de coupure 
fc_f1 = fc_f1/Fe; %normalisation de la fréquence de coupure 
Ord_1 = 201;% Ordre du filtre
Rif_pb_x1 = 2*fc_f1*sinc(2*fc_f1*[-(Ord_1-1)/2:(Ord_1-1)/2]); %réponse impulsionelle du filtre 1

%deuxieme filtre passe-bas 
fc_f2 = 10000; %fréquence de coupure
fc_f2 = fc_f2/Fe; %normalisation de la fréquence de coupure 
Ord_1 = 201;% Ordre du filtre
Rif_pb_x2 = 2*fc_f2*sinc(2*fc_f2*[-(Ord_1-1)/2:(Ord_1-1)/2]); %réponse impulsionelle du filtre 2

%filtrage de x1 
x1_trouve_pad = [x1_trouve,zeros(1,(Ord_1-1)/2)]; %ajout de zeros pour éviter le retard  
x1_trouve = filter(Rif_pb_x1,1, x1_trouve_pad); %filtrage pour retrouver x1 
x1_trouve = x1_trouve((Ord_1-1)/2+1:end); %élimination des zeros

%filtrage de x2
x2_trouve_pad = [x2_trouve,zeros(1,(Ord_1-1)/2)]; %ajout de zeros pour éviter le retard 
x2_trouve = filter(Rif_pb_x1,1, x2_trouve_pad); %filtrage pour retrouver x2
x2_trouve = x2_trouve((Ord_1-1)/2+1:end); %élimination les zeros

%signaux x1 et x2 avant filtrage
figure ("Name", "x1 et x2 trouvées apres filtrage ");
subplot(2,1,1);
plot(linspace(0, 5*T, Nes*5),x1_trouve);
xlabel("temps(s)");
ylabel("x1 trouvé(v)");
title("x1 trouvé après filtrage ");
subplot(2,1,2);
plot(linspace(0, 5*T, Nes*5),x2_trouve);
xlabel("temps(s)");
ylabel("x1 trouvé(v)");
title("x1 trouvé après filtrage");

%DSP de x1 et x2 avant filtrage
figure ("Name", "DSP x1 x2 trouvée après filtage ");
subplot(2,1,1);
DSP_x1trouve = fft(xcorr(x1_trouve));
plot(linspace(-Fe/2, Fe/2, length(DSP_x1trouve)),fftshift(abs(DSP_x1trouve)));
xlabel("Fréquence (Hz)");
ylabel("module de la DSP");
title("DSP De x1 trouvé après filtrage")
subplot(2,1,2);
DSP_x2trouve = fft(xcorr(x2_trouve));
plot(linspace(-Fe/2, Fe/2, length(DSP_x2trouve)),fftshift(abs(DSP_x2trouve)));
xlabel("Fréquence (Hz)");
ylabel("module de la DSP");
title("DSP De x2 trouvé après filtrage")

%#Détection du slot utile pour le signal x1
%Séparation des différents slots
X1_1 = x1_trouve(1:Nes);
X1_2 = x1_trouve(Nes+1:2*Nes);
X1_3 = x1_trouve(2*Nes+1:3*Nes);
X1_4 = x1_trouve(3*Nes+1:4*Nes);
X1_5 = x1_trouve(4*Nes+1:5*Nes);

%Calcul de l'énergie de chaque slot
Pmoy_1 = mean(abs(X1_1).^2);
Pmoy_2 = mean(abs(X1_2).^2);
Pmoy_3 = mean(abs(X1_3).^2);
Pmoy_4 = mean(abs(X1_4).^2);
Pmoy_5 = mean(abs(X1_5).^2);

%Détermination de l'indice du slot contenant le message
X1 = [X1_1;X1_2;X1_3;X1_4;X1_5];
Pmoy_X1 = [Pmoy_1;Pmoy_2;Pmoy_3;Pmoy_4;Pmoy_5];

[Max_x1,Slot_utile_x1] = max(Pmoy_X1);

%#Détection du slot utile pour le signal x2
%Séparation des différents slots
X2_1 = x2_trouve(1:Nes);
X2_2 = x2_trouve(Nes+1:2*Nes);
X2_3 = x2_trouve(2*Nes+1:3*Nes);
X2_4 = x2_trouve(3*Nes+1:4*Nes);
X2_5 = x2_trouve(4*Nes+1:5*Nes);

%Calcul de l'énergie de chaque slot
Pmoy_1 = mean(abs(X2_1).^2);
Pmoy_2 = mean(abs(X2_2).^2);
Pmoy_3 = mean(abs(X2_3).^2);
Pmoy_4 = mean(abs(X2_4).^2);
Pmoy_5 = mean(abs(X2_5).^2);

%Détermination de l'indice du slot contenant le message
X2 = [X2_1;X2_2;X2_3;X2_4;X2_5];
Pmoy_X2 = [Pmoy_1;Pmoy_2;Pmoy_3;Pmoy_4;Pmoy_5];

[Max_x2,Slot_utile_x2] = max(Pmoy_X2);

%Démodulation bande de base pour x1
SignalFiltrex1=filter(ones(1,Ns),1,X1(Slot_utile_x1,:)) ;
SignalEchantillonnex1=SignalFiltrex1(Ns :Ns :end) ;
BitsRecuperesx1=(sign(SignalEchantillonnex1)+1)/2 ;

%Démodulation bande de base pour x2
SignalFiltrex2=filter(ones(1,Ns),1,X2(Slot_utile_x2,:)) ;
SignalEchantillonnex2=SignalFiltrex2(Ns :Ns :end) ;
BitsRecuperesx2=(sign(SignalEchantillonnex2)+1)/2 ;

%Décodage des messages
Indice_x1 = bin2str(BitsRecuperesx1)
Indice_x2 = bin2str(BitsRecuperesx2)






