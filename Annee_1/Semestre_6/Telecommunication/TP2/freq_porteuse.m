% Télécommunication : Etude des chaines de transmission sur fréquence porteuse 
% Auteurs : JMAL Yessine et GONTHIER Priscilia
% Groupe : 1SN-M

clear
close all

%# Données du problème :
Fe = 10000; % Fréquence d'échantillonnage
Te = 1/Fe; % Période d'échantillonnage 
Rb = 2000; % Débit binaire
Tb = 1/Rb; % Période binaire
fp = 2000; % Fréquence porteuse
roll_off = 0.35; % Roll-off  du filtre : paramètre qui fixe la largeur de bande

%# Information binaire à transmettre :
Nb_bits = 10000; % Nombre de bits générés
bits = randi([0,1],1,Nb_bits); % Message de Nb_bits bits

%% Implantation de la chaine sur fréquence porteuse
%## Données spécifiques à la modulation en bande de base :
M = 4; % Ordre de modulation
l=log2(M); % Nombre de bits codants par symbole

%## Mapping de Gray : 00->-1-i, 01->-1+i, 11->1+i, 10->1-i
Symboles2 = reshape(bits,2,Nb_bits/2)';
Symboles3 = Symboles2;
Symboles3(:,1) = Symboles2(:,2);
Symboles3(:,2) = Symboles2(:,1);
Symboles2 = bi2de(Symboles3);

symboles2_re = -1*(Symboles2 == 0 | Symboles2 == 1) + 1*(Symboles2 == 2 | Symboles2 == 3);
symboles2_im = -1*(Symboles2 == 0 | Symboles2 == 2) + 1*(Symboles2 == 1 | Symboles2 == 3);
symboles2_finaux = symboles2_re + 1i*symboles2_im; % Symboles à transmettre

Rs1 = Rb/log2(M); % Débit symbole
Ts1 = 1/Rs1; % Période Symbole
Ns1 = Ts1/Te; % Nombre de bit par symbole
long = (Nb_bits * Ns1)/l; % Longueur du signal
T = long *Te; % Durée du signal;

%# Tracé de la constellation :
figure("Name", "Constellation QPSK");
plot(symboles2_finaux,"*");
xlabel("a_k");
ylabel("b_k");
title("Constellation QPSK");
grid on;

%## Suréchantillonnage :
Suite_diracs = kron(symboles2_finaux.', [1 zeros(1,Ns1-1)]); % Suite de Diracs pondérés par les symboles

%## Filtrage de mise en forme :
ord = 16; % Ordre du filtre
h =  rcosdesign(roll_off,ord, Ns1); % Réponse impulsionnelle du filtre (en racine de cosinus surelévé)
x1 = filter(h,1,Suite_diracs); % Signal transmis

%# Tracé des signaux :
t = [0:Te:T - Te];
%## Signal en phase :
figure("Name", "Signal en phase et en quadrature");
subplot(2,1,1);
plot(t, real(x1));
xlabel("t (s)");
ylabel("I(t)");
title("Signal en phase");
grid on;

%## Signal en quadrature :
subplot(2,1,2);
plot(t, imag(x1));
xlabel("t (s)");
ylabel("Q(t)");
title("Signal en quadrature");
grid on;

%## Transposition en fréquence porteuse :
x1_fre = real(x1 .* exp( 1i * 2 * pi * fp * t));

figure("Name", "Signal après modulation en fréquence");
plot(t, real(x1_fre));
xlabel("t (s)");
ylabel("x(t)");
title("Signal après modulation en fréquence");
grid on;

%## Calul et affichage de la DSP :
dsp_x1 = fft(xcorr(x1_fre));

F = linspace(-Fe/2, Fe/2, length(dsp_x1));

figure ("Name", "DSP");
semilogy(F,fftshift(abs(dsp_x1)));
xlabel("Fréquence (Hz)");
ylabel("module de la DSP");
title("Densité Spectrale de Puissance du signal après filtrage")
grid on;

%## Démodulation sans bruit :
%### Retour en bande de base
% Partie cos
x1_cos = x1_fre .* cos(2 * pi * fp * t);
DSP_x1_cos= fft(xcorr(x1_cos)); %DSP de x1
figure ("Name", "DSP_cos");
%plot(F,fftshift(abs(DSP_x1_cos)));
semilogy(F, fftshift(abs(DSP_x1_cos)));
xlabel("f (Hz)");
ylabel("DSP");
title("Densité Spectrale de Puissance ");
grid on;

% A partir de la figure on choisit une frequence de coupure du filtre fc =
% 2000 Hz
fc_pb_x1tild = 2000; % Fréquence de coupure 
fc_pb_x1tild = fc_pb_x1tild/Fe; % Normalisation de la fréquence de coupure 
Ord_1 = 201; % Ordre du filtre passe-bas (doit etre impair car on calcule (Ord_1-1)/2 qui doit etre entier)
Rif_pb_x1tild = 2 * fc_pb_x1tild * sinc(2 * fc_pb_x1tild * [-(Ord_1-1)/2:(Ord_1-1)/2]); % Réponse impulsionelle du filtre passe-bas

% Filtrage passe-bas
x1filtre = filter(Rif_pb_x1tild,1,x1_cos); % Filtrer le signal
DSP_x1_cos_filtre= fft(xcorr(x1filtre)); % DSP de x1
figure ("Name", "x1_cos_filtré");
plot(linspace(-Fe/2, Fe/2, length(DSP_x1_cos_filtre)),fftshift(abs(DSP_x1_cos_filtre)));
xlabel("Fréquence (Hz)");
ylabel("Module de la DSP");
title("DSP du signal apres filtrage")

% Partie sin 
x1_sin = x1_fre .* sin(2 * pi * fp * t);
DSP_x1_sin= fft(xcorr(x1_sin)); %DSP de x1
figure ("Name", "x1_sin");
%plot(F,fftshift(abs(DSP_x1_sin)));
semilogy(F, fftshift(abs(DSP_x1_sin)));
xlabel("f (Hz)");
ylabel("DSP");
title("Densité Spectrale de Puissance");
grid on;

% A partir de la figure on choisit une frequence de coupure du filtre fc =
% 2000 Hz
fc_pb_x1tild = 2000; % Fréquence de coupure 
fc_pb_x1tild = fc_pb_x1tild/Fe; % Normalisation de la fréquence de coupure 
Ord_1 = 201; % Ordre du filtre passe-bas (doit etre impair car on calcule Ord_1-1)/2 qui doit etre entier)
Rif_pb_x1tild = 2*fc_pb_x1tild*sinc(2*fc_pb_x1tild*[-(Ord_1-1)/2:(Ord_1-1)/2]); % Réponse impulsionelle du filtre passe-bas

% Filtrage passe-bas
x1_sin_filtre = filter(Rif_pb_x1tild,1,x1_sin); % Filtrer le signal
DSP_x1_sin_filtre= fft(xcorr(x1_sin_filtre)); % DSP de x1
figure ("Name", "DSPx1_sin_filtré");
plot(linspace(-Fe/2, Fe/2, length(DSP_x1_sin_filtre)),fftshift(abs(DSP_x1_sin_filtre)));
xlabel("Fréquence (Hz)");
ylabel("module de la DSP");
title("DSP du signal apres filtrage")

%## Réception et filtrage :
x_bb = x1filtre - 1i * x1_sin_filtre;

%filtre de reception 
h_r =  fliplr(h); % Réponse impulsionnelle du filtre 
z = filter(h_r,1,x_bb);

%# Diagrame de l'oeil :
z_aff = reshape(real(z),Ns1,length(z)/Ns1);
figure("Name", "diagramme de l'oeil");
plot(z_aff);
xlabel("Indice");
ylabel("z (v)");
title("Diagramme de l'oeil en sortie du filtre de réception");
grid on;


% Choix de n0 à partir du diagramme de l'oeil
n0 = 1 ;

% Echantillonage du signal en sortie du filtre de réception 
z_echant = z(n0:Ns1:end);

% Prise de décision et demapping
Bits_recuperes = zeros(1,Nb_bits);
Bits_recuperes(1:2:end) = 0* (real(z_echant)<=0) + 1 *(real(z_echant)>0);
Bits_recuperes(2:2:end) = 0* (imag(z_echant)<=0) + 1 *(imag(z_echant)>0);

% Calcul du Taux d'erreur binaire
retard = 2* ord + ((Ord_1-1)/Ns1);
erreur = abs(bits(1,1:Nb_bits-retard)-Bits_recuperes(1,retard+1:Nb_bits)); 
TEB1 = mean(erreur);


%% #Ajout du bruit dans le canal
% x1_fre = signal envoyé sur le canal
rapport = 0.010;

% Px = mean(abs(x1_fre).^2);
% sigmacarre = (Px * Ns1)/(2 * log2(M) * rapport);
% bruit = sqrt(sigmacarre) * randn(1, length(x1_fre));
bruit = genereBruit(x1_fre, rapport, Ns1, M);
x1_fre_bruit = x1_fre + bruit;

%DSP 
dsp_x1 = fft(xcorr(real(x1_fre_bruit)));
figure ("Name", "DSP");
%plot(linspace(-Fe/2, Fe/2, length(dsp_x1)),fftshift(abs(dsp_x1)));
semilogy(linspace(-Fe/2, Fe/2, length(dsp_x1)),fftshift(abs(dsp_x1)));
xlabel("Fréquence (Hz)");
ylabel("module de la DSP");
title("DSP du signal apres filtrage")

%## Retour en bande de base 
% Partie cos
x1_cos_bruit = x1_fre_bruit .* cos(2 * pi * fp * t);
DSP_x1_cos_bruit= fft(xcorr(x1_cos_bruit)); % DSP de x1
figure ("Name", "x1_cos");
plot(linspace(-Fe/2, Fe/2, length(DSP_x1_cos_bruit)),fftshift(abs(DSP_x1_cos_bruit)));
xlabel("Fréquence (Hz)");
ylabel("module de la DSP");
title("DSP du signal avant filtrage")

% A partir de la figure on choisit une frequence de coupure du filtre fc =
% 2000 Hz
fc_pb_x1tild = 2000; % Fréquence de coupure 
fc_pb_x1tild = fc_pb_x1tild/Fe; % Normalisation de la fréquence de coupure 
Ord_1 = 201; % Ordre du filtre (doit être impair car on calcule Ord_1-1)/2 qui doit être entier)
Rif_pb_x1tild = 2*fc_pb_x1tild*sinc(2*fc_pb_x1tild*[-(Ord_1-1)/2:(Ord_1-1)/2]); % Réponse impulsionelle du filtre passe-bas
x1filtre_bruit = filter(Rif_pb_x1tild,1,x1_cos_bruit); % Filtrer le signal
DSP_x1_cos_filtre_bruit= fft(xcorr(x1filtre_bruit)); % DSP de x1

figure ("Name", "x1_cos_filtré");
plot(linspace(-Fe/2, Fe/2, length(DSP_x1_cos_filtre_bruit)),fftshift(abs(DSP_x1_cos_filtre_bruit)));
xlabel("Fréquence (Hz)");
ylabel("module de la DSP");
title("DSP du signal apres filtrage")

% Partie sin 
x1_sin_bruit = x1_fre_bruit.*sin(2*pi*fp*t);
DSP_x1_sin_bruit= fft(xcorr(x1_sin_bruit)); % DSP de x1
figure ("Name", "x1_sin");
plot(linspace(-Fe/2, Fe/2, length(DSP_x1_sin_bruit)),fftshift(abs(DSP_x1_sin_bruit)));
xlabel("Fréquence (Hz)");
ylabel("module de la DSP");
title("DSP du signal avant filtrage")

% A partir de la figure on choisit une frequence de coupure du filtre fc =
% 2000 Hz
fc_pb_x1tild = 2000; % Fréquence de coupure 
fc_pb_x1tild = fc_pb_x1tild/Fe; % Normalisation de la fréquence de coupure 
Ord_1 = 201; % Ordre du filtre (doit être impair car on calcule (Ord_1-1)/2 qui doit être entier)
Rif_pb_x1tild = 2*fc_pb_x1tild*sinc(2*fc_pb_x1tild*[-(Ord_1-1)/2:(Ord_1-1)/2]); % Réponse impulsionelle du filtre 
x1_sin_filtre_bruit = filter(Rif_pb_x1tild,1,x1_sin_bruit); %filtrer le signal

DSP_x1_sin_filtre_bruit= fft(xcorr(x1_sin_filtre_bruit)); %DSP de x1
figure ("Name", "x1_cos_filtré");
plot(linspace(-Fe/2, Fe/2, length(DSP_x1_sin_filtre_bruit)),fftshift(abs(DSP_x1_sin_filtre_bruit)));
xlabel("Fréquence (Hz)");
ylabel("module de la DSP");
title("DSP du signal apres filtrage")

%##Réception et filtrage :
x_bb_bruit = x1filtre_bruit - 1i * x1_sin_filtre_bruit;

% Filtre de reception 
h_r =  fliplr(h); % Réponse impulsionnelle du filtre de réception
z_bruit=filter(h_r,1,x_bb_bruit);

%# Diagrame de l'oeil :
figure("Name", "diagramme de l'oeil");
z_aff_bruit = reshape(real(z_bruit),Ns1,length(z_bruit)/Ns1);
plot(z_aff_bruit);
xlabel("Indice");
ylabel("z (v)");
title("Diagramme de l'oeil en sortie du filtre de réception");
grid on;

% Choix de n0 
n0 = 1 ;

% Echantillonage du signal en sortie du filtre de réception 
z_echant_bruit = z_bruit(n0:Ns1:end);

% Prise de décision et demapping
Bits_recuperes = zeros(1,Nb_bits);
Bits_recuperes(1:2:end) = 0* (real(z_echant_bruit)<=0) + 1 *(real(z_echant_bruit)>0);
Bits_recuperes(2:2:end) = 0* (imag(z_echant_bruit)<=0) + 1 *(imag(z_echant_bruit)>0);

% Calcul du Taux d'Erreur Binaire
retard = 2* ord + ((Ord_1-1)/Ns1);
erreur = abs(bits(1,1:Nb_bits-retard)-Bits_recuperes(1,retard+1:Nb_bits)); 
TEB2 = mean(erreur);

%TEB en fonction du rapport SNR
SNRdb = linspace(0,6,12);
TEB = zeros(1,length(SNRdb));
% TES = zeros(1,length(SNRdb));
TEB_th = zeros(1,length(SNRdb));
% TES_th = zeros(1,length(SNRdb));
SNR = 10.^(SNRdb/10);
TEB_moy = zeros(1,100);
TES_moy = zeros(1,100);
for i = 1 : length(SNRdb)
    rapport = SNR(i);
    Px = mean(abs(x1_fre).^2);
    sigmacarre = (Px * Ns1)/(2 * log2(M) * rapport);
    for j = 1 : 100  % on ajoute cette boucle for pour generer plus de points. 
        bruit = sqrt(sigmacarre) * randn(1, length(x1_fre));
        x1_fre_bruit = x1_fre + bruit;

        %retour en bande de base 
        %partie cos
        x1_cos_bruit = x1_fre_bruit.*cos(2*pi*fp*t);
        
        x1filtre_bruit = filter(Rif_pb_x1tild,1,x1_cos_bruit); %filtrer le signal

        %partie sin 
        x1_sin_bruit = x1_fre_bruit.*sin(2*pi*fp*t);
        x1_sin_filtre_bruit = filter(Rif_pb_x1tild,1,x1_sin_bruit); %filtrer le signal


        %somme des deux parties
        x_bb_bruit = x1filtre_bruit - 1i * x1_sin_filtre_bruit;
    
        z_bruit=filter(h_r,1,x_bb_bruit);
        n0 = 1 ;
        z_echant = z_bruit(n0:Ns1:end);
        Bits_recuperes = zeros(1,Nb_bits);
        Bits_recuperes(1:2:end) = 0* (real(z_echant)<=0) + 1 *(real(z_echant)>0);
        Bits_recuperes(2:2:end) = 0* (imag(z_echant)<=0) + 1 *(imag(z_echant)>0);
        % bits2 = de2bi((symbolesDecides' + 3)/2,2);
        % BitsRecuperes = reshape(de2bi((symbolesDecides + 3)/2).', [Nb_bits,1])';
       
        erreur = abs(bits(1,1:Nb_bits-retard)-Bits_recuperes(1,retard+1:Nb_bits)); 

        TEB_moy(j) = mean(erreur);
%         TES_moy(j) = TEB_moy(j) * log2(M);
    end 
    TEB(i) = mean(TEB_moy);
%     TES(i) = mean(TES_moy);
    %TEB_th(i) = 2 * ((M-1)/(M * log2(M))) * (1-normcdf(sqrt(2 * rapport)));
    TEB_th(i) = (2/log2(M))*(1-normcdf(sqrt(2 * 2* rapport)*sin(pi/M)));

%     TES_th(i) = (3/2) * (1-normcdf(sqrt((4/5) * rapport)));
end

%tracé du diagramme de l'oeil apres le bruit 
figure("Name", "TEB en fonction de SNR");
semilogy(SNRdb,TEB);
grid on;
hold on 
semilogy(SNRdb,TEB_th);
 grid on;
 xlabel("SNR (dB)");
 ylabel("TEB");
 title("TEB en fonction du SNR")

 leg = legend('TEB',...
       'TEBth',..., 
     'location', 'NorthWest');


TEBfreq = TEB;

%% ####################Implantation de la chaine passe bas équivalente#################
% Sgnal en sortie de modulation : x1
figure("name","Signal en phase et en quadrature chaine eq")

subplot(2,1,1);
plot(t, real(x1));
xlabel("t (s)");
ylabel("I(t)");
title("Signal en phase");
grid on;

%## Signal en quadrature :
subplot(2,1,2);
plot(t, imag(x1));
xlabel("t (s)");
ylabel("Q(t)");
title("Signal en quadrature");
grid on;

DSP_x1 = fft(xcorr(x1));

figure ("Name", "DSP eq");
semilogy(linspace(-Fe/2, Fe/2, length(DSP_x1)),fftshift(abs(DSP_x1)));
xlabel("Fréquence (Hz)");
ylabel("module de la DSP");
title("DSP du signal après modulation")

h_r =  fliplr(h); % Réponse impulsionnelle du filtre 
z=filter(h_r,1,x1);

%tracé du diagramme de l'oeil 
figure("Name", "diagramme de l'oeil sans bruit");
z_aff = reshape(real(z),Ns1,length(z)/Ns1);
plot(z_aff);
xlabel("Indice");
ylabel("z (v)")
title("Diagramme de l'oeil sans bruit");
grid on;

%choix de n0   
n0 = 1 ;

%echantillonage du signal en sortie du filtre de reception 
z_echant = z(n0:Ns1:end);


Bits_recuperes = zeros(1,Nb_bits);
Bits_recuperes(1:2:end) = 0* (real(z_echant)<=0) + 1 *(real(z_echant)>0);
Bits_recuperes(2:2:end) = 0* (imag(z_echant)<=0) + 1 *(imag(z_echant)>0);

retard = 2* ord;
erreur = abs(bits(1,1:Nb_bits-retard)-Bits_recuperes(1,retard+1:Nb_bits)); 
TEBeq = mean(erreur);

%###Ajout du bruit

%introduction du bruit
rapport = 0.010;
bruit = genereBruitComplexe(x1,rapport, Ns1, M);
x1_fre_bruit = x1 + bruit;

%DSP 
dsp_x1 = fft(xcorr(real(x1_fre_bruit)));
figure ("Name", "DSP");
%plot(linspace(-Fe/2, Fe/2, length(dsp_x1)),fftshift(abs(dsp_x1)));
semilogy(linspace(-Fe/2, Fe/2, length(dsp_x1)),fftshift(abs(dsp_x1)));
xlabel("Fréquence (Hz)");
ylabel("module de la DSP");
title("DSP du signal apres filtrage")


%filtre de reception 
h_r =  fliplr(h); % Réponse impulsionnelle du filtre 
z_bruit=filter(h_r,1,x1_fre_bruit);


%tracé du diagramme de l'oeil 
figure("Name", "diagramme de l'oeil");
z_aff_bruit = reshape(real(z_bruit),Ns1,length(z_bruit)/Ns1);
plot(z_aff_bruit);
xlabel("Indice");
ylabel("z (v)")
title("Diagramme de l'oeil avec bruit");
grid on;

%choix de n0 
%n0= 1  
n0 = 1 ;

%echantillonage du signal en sortie du filtre de reception 
z_echant_bruit = z_bruit(n0:Ns1:end);

Bits_recuperes = zeros(1,Nb_bits);
Bits_recuperes(1:2:end) = 0* (real(z_echant_bruit)<=0) + 1 *(real(z_echant_bruit)>0);
Bits_recuperes(2:2:end) = 0* (imag(z_echant_bruit)<=0) + 1 *(imag(z_echant_bruit)>0);
retard = 2* ord;
erreur = abs(bits(1,1:Nb_bits-retard)-Bits_recuperes(1,retard+1:Nb_bits)); 
TEB2 = mean(erreur);

%## Calculs de TEB

%TEB en fonction du rapport signal sur bruit (SNR)
SNRdb = linspace(0,6,12);
TEB = zeros(1,length(SNRdb));
TEB_th = zeros(1,length(SNRdb));
SNR = 10.^(SNRdb/10);
TEB_moy = zeros(1,100);

figure("Name","Constellation bruitée")
for i = 1 : length(SNRdb)
    rapport = SNR(i);
    for j = 1 : 100  % On ajoute cette boucle for pour generer plus de points. 
        bruit = genereBruitComplexe(x1, rapport, Ns1, M);
        x1_fre_bruit = x1 + bruit;
 
        z_bruit=filter(h_r,1,x1_fre_bruit);
        n0 = 1 ;
        z_echant = z_bruit(n0:Ns1:end);
        
        Bits_recuperes = zeros(1,Nb_bits);
        Bits_recuperes(1:2:end) = 0* (real(z_echant)<=0) + 1 *(real(z_echant)>0);
        Bits_recuperes(2:2:end) = 0* (imag(z_echant)<=0) + 1 *(imag(z_echant)>0);
       
        erreur = abs(bits(1,1:Nb_bits-retard)-Bits_recuperes(1,retard+1:Nb_bits)); 

        TEB_moy(j) = mean(erreur);
    end 
    
    subplot(4,3,i);
    plot(z_echant,'+');
    xlabel("a_k");
    ylabel("b_k");
    title("constellation SNRdB = " + SNRdb(i));

    TEB(i) = mean(TEB_moy);
    TEB_th(i) = (2/log2(M))*(1-normcdf(sqrt(2 * 2* rapport)*sin(pi/M)));

end


figure("Name", "TEB en fonction de SNR chaine eq");
semilogy(SNRdb,TEB);

grid on;
hold on 

semilogy(SNRdb,TEB_th);
grid on;
xlabel("SNR (dB)");
ylabel("TEB");
title("TEB en fonction de SNR");
leg = legend('TEB',...
     'TEBth',..., 
     'location', 'NorthWest');


figure("Name", "TEB en fonction de SNR chaine eq et normal pour comparer");
semilogy(SNRdb,TEB);

grid on;
hold on 
semilogy(SNRdb,TEBfreq);
semilogy(SNRdb,TEB_th);
grid on;
xlabel("SNR (dB)");
ylabel("TEB");
title("TEB en fonction de SNR");
leg = legend('TEB chaine équivalente',...
    'TEB fréquence porteuse',...
     'TEBth',..., 
     'location', 'NorthWest');




