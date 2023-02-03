% Télécommunication : Etude de transmissions en fréquence porteuse partie 4
% Auteurs : JMAL Yessine et GONTHIER Priscilia
% Groupe : 1SN-M

clear
close all

%% Implantation des chaines

% Spécification des parametres 
Rb = 48000; % Débit binaire
Tb = 1/Rb; % Période binaire
Fe = 10*Rb; % Fréquence d'échantillonnage
fp = 2000; % Fréquence porteuse
roll_off = 0.5; % Roll-off  du filtre : paramètre qui fixe la largeur de bande

%génération du message binaire 
nb_bits = 6000; % Nombre de bits générés
bits = randi([0,1],1,nb_bits); % Message de nb_bits bits

%##Mapping
% Mapping 4-ASK : 00 -> -3, 10 -> -1, 01 -> 1, 11 -> 3 %mapping plus simple
% mais pas aussi efficace que si on avait codé 11 -> 1 et 01 -> 3 %%Faire
% un mapping de gray
M4ask = 4;
Ns4ask = round(Fe * log2(M4ask)/Rb);

Symboles4ask = reshape(bits,2,nb_bits/2);
Symboles4ask = bi2de(Symboles4ask');
Symboles4ask = (Symboles4ask * 2 - 3);

%mapping QPSK :
MQpsk = 4;
NsQpsk = round(Fe * log2(MQpsk)/Rb);

SymbolesQpsk = pskmod(bi2de(reshape(bits,2,nb_bits/2)'), MQpsk, pi/MQpsk, 'gray');

%mapping 8-PSK : 
M8psk = 8;
Ns8psk = round(Fe * log2(M8psk)/Rb);

Symboles8psk = pskmod(bi2de(reshape(bits,3,nb_bits/3)'), M8psk, pi/M8psk, 'gray');


%mapping 16-QAM :
M16qam = 16;
Ns16qam = round(Fe * log2(M16qam)/Rb);

Symboles16qam = qammod(bi2de(reshape(bits,4,nb_bits/4)'), M16qam, 'gray');


%##Tracé des constellations après mapping :
figure("Name", "Constellation");
subplot(2,2,1);
plot(Symboles4ask,zeros(1,length(Symboles4ask)),'*');
xlabel("a_k");
ylabel("b_k");
title("Constellation 4-ASK");

subplot(2,2,2);
plot(SymbolesQpsk,'*');
xlabel("a_k");
ylabel("b_k");
title("Constellation QPSK");

subplot(2,2,3);
plot(Symboles8psk,'*');
xlabel("a_k");
ylabel("b_k");
title("Constellation 8-PSK");

subplot(2,2,4);
plot(Symboles16qam,'*');
xlabel("a_k");
ylabel("b_k");
title("Constellation 16-QAM");


%##Suréchantillonnage :
Suite_diracs4ask = kron(Symboles4ask.', [1 zeros(1,Ns4ask-1)]); % Suite de Diracs pondérés par les symboles
Suite_diracsQpsk = kron(SymbolesQpsk.', [1 zeros(1,NsQpsk-1)]); % Suite de Diracs pondérés par les symboles
Suite_diracs8psk = kron(Symboles8psk.', [1 zeros(1,Ns8psk-1)]); % Suite de Diracs pondérés par les symboles
Suite_diracs16qam = kron(Symboles16qam.', [1 zeros(1,Ns16qam-1)]); % Suite de Diracs pondérés par les symboles


%##filtre de modulation :
ord = 16; % Ordre du filtre
retard = 2 * ord; % Retard engendrer par le filtre pour le rendre causal
h4ask = rcosdesign(roll_off,ord, Ns4ask); % Réponse impulsionnelle du filtre (en racine de cosinus surelévé)
hQpsk = rcosdesign(roll_off,ord, NsQpsk); % Réponse impulsionnelle du filtre (en racine de cosinus surelévé)
h8psk = rcosdesign(roll_off,ord, Ns8psk); % Réponse impulsionnelle du filtre (en racine de cosinus surelévé)
h16qam = rcosdesign(roll_off,ord, Ns16qam); % Réponse impulsionnelle du filtre (en racine de cosinus surelévé)

x4ask = filter(h4ask, 1, Suite_diracs4ask);
xQpsk = filter(hQpsk, 1, Suite_diracsQpsk);
x8psk = filter(h8psk, 1, Suite_diracs8psk);
x16qam = filter(h16qam, 1, Suite_diracs16qam);

%% #Chaine sans bruit

%##filtre de réception :
hr4ask = fliplr(h4ask); % Réponse impulsionnelle du filtre de réception
hrQpsk = fliplr(hQpsk); % Réponse impulsionnelle du filtre de réception
hr8psk = fliplr(h8psk); % Réponse impulsionnelle du filtre de réception
hr16qam = fliplr(h16qam); % Réponse impulsionnelle du filtre de réception

z4ask = filter(hr4ask, 1, x4ask);
zQpsk = filter(hrQpsk, 1, xQpsk);
z8psk = filter(hr8psk, 1, x8psk);
z16qam = filter(hr16qam, 1, x16qam);


%# Diagrames de l'oeil :
figure("Name", "Diagramme de l'oeil en sortie du filtre de réception");
subplot(2,2,1);
z4ask_bis = reshape(z4ask,Ns4ask,length(z4ask)/Ns4ask);
plot(z4ask_bis);
xlabel("Indice");
ylabel("z (v)");
title("Signal 4-ASK");
grid on;

subplot(2,2,2);
zQpsk_bis = reshape(zQpsk,NsQpsk,length(zQpsk)/NsQpsk);
plot(imag(zQpsk_bis));
xlabel("Indice");
ylabel("z (v)");
title("Signal QPSK");
grid on;

subplot(2,2,3);
z8psk_bis = reshape(z8psk,Ns8psk,length(z8psk)/Ns8psk);
plot(imag(z8psk_bis));
xlabel("Indice");
ylabel("z (v)");
title("Signal 8-PSK");
grid on;

subplot(2,2,4);
z16qam_bis = reshape(z16qam,Ns16qam,length(z16qam)/Ns16qam);
plot(imag(z16qam_bis));
xlabel("Indice");
ylabel("z (v)");
title("Signal 16-QAM");
grid on;


% Choix de n0 à partir du diagramme de l'oeil :
% Il est identique pour toutes les modulations
n0 = 1;


%## Echantillonnage :
z4ask_echant = z4ask(n0:Ns4ask:end);% z(t0 + mTs) m€N
zQpsk_echant = zQpsk(n0:NsQpsk:end);% z(t0 + mTs) m€N
z8psk_echant = z8psk(n0:Ns8psk:end);% z(t0 + mTs) m€N
z16qam_echant = z16qam(n0:Ns16qam:end);% z(t0 + mTs) m€N


%##Décision et démapping :
% Signal 4-ASK :
SymbolesDecides4ask = (-3) * (z4ask_echant <= -2) + (-1) * (z4ask_echant > -2 & z4ask_echant <= 0) + 1 * (z4ask_echant > 0 & z4ask_echant <= 2) + 3 * (z4ask_echant > 2);
BitsDecides4ask = reshape(de2bi((SymbolesDecides4ask + 3)/2).', 1, length(bits)); % Demapping
erreur = abs(bits(1,1:nb_bits-retard)-BitsDecides4ask(1,retard+1:nb_bits)); 
TEB4ask = mean(erreur); % Taux d'erreur binaire, TEB = nombre de bits reçus erronés / nombre de bits transmis

% Signal QPSK :
SymbolesDecidesQpsk = pskdemod(zQpsk_echant, MQpsk, pi/MQpsk, 'gray');
tmp = de2bi(SymbolesDecidesQpsk);
BitsDecidesQpsk = zeros(1, nb_bits);
BitsDecidesQpsk(1, 1:2:end) = tmp(:,1)';
BitsDecidesQpsk(1, 2:2:end) = tmp(:,2)';
erreur = abs(bits(1,1:nb_bits-retard)-BitsDecidesQpsk(1,retard+1:nb_bits)); 
TEBQpsk = mean(erreur); % Taux d'erreur binaire, TEB = nombre de bits reçus erronés / nombre de bits transmis

% Signal 8-PSK :
SymbolesDecides8psk = pskdemod(z8psk_echant, M8psk, pi/M8psk, 'gray');
tmp = de2bi(SymbolesDecides8psk);
BitsDecides8psk = zeros(1, nb_bits);
BitsDecides8psk(1, 1:3:end) = tmp(:,1)';
BitsDecides8psk(1, 2:3:end) = tmp(:,2)';
BitsDecides8psk(1, 3:3:end) = tmp(:,3)';
erreur = abs(bits(1,1:nb_bits-ord*3)-BitsDecides8psk(1,(ord*3)+1:nb_bits)); 
TEB8psk = mean(erreur); % Taux d'erreur binaire, TEB = nombre de bits reçus erronés / nombre de bits transmis

% Signal 16-QAM :
SymbolesDecides16qam = qamdemod(z16qam_echant, M16qam, 'gray');
tmp = de2bi(SymbolesDecides16qam);
BitsDecides16qam = zeros(1, nb_bits);
BitsDecides16qam(1, 1:4:end) = tmp(:,1)';
BitsDecides16qam(1, 2:4:end) = tmp(:,2)';
BitsDecides16qam(1, 3:4:end) = tmp(:,3)';
BitsDecides16qam(1, 4:4:end) = tmp(:,4)';
erreur = abs(bits(1,1:nb_bits-2*retard)-BitsDecides16qam(1,(2*retard)+1:nb_bits)); 
TEB16qam = mean(erreur); % Taux d'erreur binaire, TEB = nombre de bits reçus erronés / nombre de bits transmis

%% ##Ajout du bruit

%## Introduction du bruit
rapport = 4; % Rapport Signal sur Bruit
bruit4ask = genereBruit(x4ask,rapport, Ns4ask, M4ask);
bruitQpsk = genereBruitComplexe(xQpsk,rapport, NsQpsk, MQpsk);
bruit8psk = genereBruitComplexe(x8psk,rapport, Ns8psk, M8psk);
bruit16qam = genereBruitComplexe(x16qam,rapport, Ns16qam, M16qam);

x4askbruit = x4ask + bruit4ask;
xQpskbruit = xQpsk + bruitQpsk;
x8pskbruit = x8psk + bruit8psk;
x16qambruit = x16qam + bruit16qam;

%## Filtrage de réception :
z4ask = filter(hr4ask, 1, x4askbruit);
zQpsk = filter(hrQpsk, 1, xQpskbruit);
z8psk = filter(hr8psk, 1, x8pskbruit);
z16qam = filter(hr16qam, 1, x16qambruit);

%# Diagrames de l'oeil :
figure("Name", "Diagramme de l'oeil en sortie du filtre de réception");
subplot(2,2,1);
z4ask_bis = reshape(z4ask,Ns4ask,length(z4ask)/Ns4ask);
plot(z4ask_bis);
xlabel("Indice");
ylabel("z (v)");
title("Signal 4-ASK");
grid on;

subplot(2,2,2);
zQpsk_bis = reshape(zQpsk,NsQpsk,length(zQpsk)/NsQpsk);
plot(imag(zQpsk_bis));
xlabel("Indice");
ylabel("z (v)");
title("Signal QPSK");
grid on;

subplot(2,2,3);
z8psk_bis = reshape(z8psk,Ns8psk,length(z8psk)/Ns8psk);
plot(imag(z8psk_bis));
xlabel("Indice");
ylabel("z (v)");
title("Signal 8-PSK");
grid on;

subplot(2,2,4);
z16qam_bis = reshape(z16qam,Ns16qam,length(z16qam)/Ns16qam);
plot(imag(z16qam_bis));
xlabel("Indice");
ylabel("z (v)");
title("Signal 16-QAM");
grid on;


%##Echantillonnage :
z4ask_echant = z4ask(n0:Ns4ask:end);% z(t0 + mTs) m€N
zQpsk_echant = zQpsk(n0:NsQpsk:end);% z(t0 + mTs) m€N
z8psk_echant = z8psk(n0:Ns8psk:end);% z(t0 + mTs) m€N
z16qam_echant = z16qam(n0:Ns16qam:end);% z(t0 + mTs) m€N


%##Décision et démapping :
% Signal 4-ASK :
SymbolesDecides4ask = (-3) * (z4ask_echant <= -2) + (-1) * (z4ask_echant > -2 & z4ask_echant <= 0) + 1 * (z4ask_echant > 0 & z4ask_echant <= 2) + 3 * (z4ask_echant > 2);
BitsDecides4ask = reshape(de2bi((SymbolesDecides4ask + 3)/2).', 1, length(bits)); % Demapping
erreur = abs(bits(1,1:nb_bits-retard)-BitsDecides4ask(1,retard+1:nb_bits)); 
TEB4askb = mean(erreur); % Taux d'erreur binaire, TEB = nombre de bits reçus erronés / nombre de bits transmis

% Signal QPSK :
SymbolesDecidesQpsk = pskdemod(zQpsk_echant, MQpsk, pi/MQpsk, 'gray');
tmp = de2bi(SymbolesDecidesQpsk);
BitsDecidesQpsk = zeros(1, nb_bits);
BitsDecidesQpsk(1, 1:2:end) = tmp(:,1)';
BitsDecidesQpsk(1, 2:2:end) = tmp(:,2)';
erreur = abs(bits(1,1:nb_bits-retard)-BitsDecidesQpsk(1,retard+1:nb_bits)); 
TEBQpskb = mean(erreur); % Taux d'erreur binaire, TEB = nombre de bits reçus erronés / nombre de bits transmis

% Signal 8-PSK :
SymbolesDecides8psk = pskdemod(z8psk_echant, M8psk, pi/M8psk, 'gray');
tmp = de2bi(SymbolesDecides8psk);
BitsDecides8psk = zeros(1, nb_bits);
BitsDecides8psk(1, 1:3:end) = tmp(:,1)';
BitsDecides8psk(1, 2:3:end) = tmp(:,2)';
BitsDecides8psk(1, 3:3:end) = tmp(:,3)';
erreur = abs(bits(1,1:nb_bits-ord*3)-BitsDecides8psk(1,(ord*3)+1:nb_bits)); 
TEB8pskb = mean(erreur); % Taux d'erreur binaire, TEB = nombre de bits reçus erronés / nombre de bits transmis

% Signal 16-QAM :
SymbolesDecides16qam = qamdemod(z16qam_echant, M16qam, 'gray');
tmp = de2bi(SymbolesDecides16qam);
BitsDecides16qam = zeros(1, nb_bits);
BitsDecides16qam(1, 1:4:end) = tmp(:,1)';
BitsDecides16qam(1, 2:4:end) = tmp(:,2)';
BitsDecides16qam(1, 3:4:end) = tmp(:,3)';
BitsDecides16qam(1, 4:4:end) = tmp(:,4)';
erreur = abs(bits(1,1:nb_bits-2*retard)-BitsDecides16qam(1,(2*retard)+1:nb_bits)); 
TEB16qamb = mean(erreur); % Taux d'erreur binaire, TEB = nombre de bits reçus erronés / nombre de bits transmis

% Calculs des TEB
% TEB en fonction du rapport SNR
SNRdb = linspace(0,12,24);
TEB4askB = zeros(1,length(SNRdb));
TEBQpskB = zeros(1,length(SNRdb));
TEB8pskB = zeros(1,length(SNRdb));
TEB16qamB = zeros(1,length(SNRdb));
SNR = 10.^(SNRdb/10);
TEB4ask_moy = zeros(1,100);
TEBQpsk_moy = zeros(1,100);
TEB8psk_moy = zeros(1,100);
TEB16qam_moy = zeros(1,100);

TEB4ask_th = zeros(1,length(SNRdb));
TEBQpsk_th = zeros(1,length(SNRdb));
TEB8psk_th = zeros(1,length(SNRdb));
TEB16qam_th = zeros(1,length(SNRdb));

f4ask = figure("Name","constellation 4ask");
fQpsk = figure("Name","constellation Qpsk");
f8psk = figure("Name","constellation 8psk");
f16qam = figure("Name","constellation 16qam");

for i = 1 : length(SNRdb)
    rapport = SNR(i);
    for j = 1 : 100  % on ajoute cette boucle for pour generer plus de points. 
        bruit4ask = genereBruit(x4ask,rapport, Ns4ask, M4ask);
        bruitQpsk = genereBruitComplexe(xQpsk,rapport, NsQpsk, MQpsk);
        bruit8psk = genereBruitComplexe(x8psk,rapport, Ns8psk, M8psk);
        bruit16qam = genereBruitComplexe(x16qam,rapport, Ns16qam, M16qam);
        
        x4askbruit = x4ask + bruit4ask;
        xQpskbruit = xQpsk + bruitQpsk;
        x8pskbruit = x8psk + bruit8psk;
        x16qambruit = x16qam + bruit16qam;
 
        z4ask = filter(hr4ask, 1, x4askbruit);
        zQpsk = filter(hrQpsk, 1, xQpskbruit);
        z8psk = filter(hr8psk, 1, x8pskbruit);
        z16qam = filter(hr16qam, 1, x16qambruit);

        n0 = 1 ;

        z4ask_echant = z4ask(n0:Ns4ask:end);% z(t0 + mTs) m€N
        zQpsk_echant = zQpsk(n0:NsQpsk:end);% z(t0 + mTs) m€N
        z8psk_echant = z8psk(n0:Ns8psk:end);% z(t0 + mTs) m€N
        z16qam_echant = z16qam(n0:Ns16qam:end);% z(t0 + mTs) m€N

        %signal 4-ASK :
        SymbolesDecides4ask = (-3) * (z4ask_echant <= -2) + (-1) * (z4ask_echant > -2 & z4ask_echant <= 0) + 1 * (z4ask_echant > 0 & z4ask_echant <= 2) + 3 * (z4ask_echant > 2);
        BitsDecides4ask = reshape(de2bi((SymbolesDecides4ask + 3)/2).', 1, length(bits)); % Demapping
        erreur = abs(bits(1,1:nb_bits-retard)-BitsDecides4ask(1,retard+1:nb_bits)); 
        TEB4ask_moy(j) = mean(erreur); % Taux d'erreur binaire, TEB = nombre de bits reçus erronés / nombre de bits transmis
        
        %signal QPSK :
        SymbolesDecidesQpsk = pskdemod(zQpsk_echant, MQpsk, pi/MQpsk, 'gray');
        tmp = de2bi(SymbolesDecidesQpsk);
        BitsDecidesQpsk = zeros(1, nb_bits);
        BitsDecidesQpsk(1, 1:2:end) = tmp(:,1)';
        BitsDecidesQpsk(1, 2:2:end) = tmp(:,2)';
        erreur = abs(bits(1,1:nb_bits-retard)-BitsDecidesQpsk(1,retard+1:nb_bits)); 
        TEBQpsk_moy(j) = mean(erreur); % Taux d'erreur binaire, TEB = nombre de bits reçus erronés / nombre de bits transmis
        
        %signal 8-PSK :
        SymbolesDecides8psk = pskdemod(z8psk_echant, M8psk, pi/M8psk, 'gray');
        tmp = de2bi(SymbolesDecides8psk);
        BitsDecides8psk = zeros(1, nb_bits);
        BitsDecides8psk(1, 1:3:end) = tmp(:,1)';
        BitsDecides8psk(1, 2:3:end) = tmp(:,2)';
        BitsDecides8psk(1, 3:3:end) = tmp(:,3)';
        erreur = abs(bits(1,1:nb_bits-ord*3)-BitsDecides8psk(1,(ord*3)+1:nb_bits)); 
        TEB8psk_moy(j) = mean(erreur); % Taux d'erreur binaire, TEB = nombre de bits reçus erronés / nombre de bits transmis
        
        %signal 16-QAM :
        SymbolesDecides16qam = qamdemod(z16qam_echant, M16qam, 'gray');
        tmp = de2bi(SymbolesDecides16qam);
        BitsDecides16qam = zeros(1, nb_bits);
        BitsDecides16qam(1, 1:4:end) = tmp(:,1)';
        BitsDecides16qam(1, 2:4:end) = tmp(:,2)';
        BitsDecides16qam(1, 3:4:end) = tmp(:,3)';
        BitsDecides16qam(1, 4:4:end) = tmp(:,4)';
        erreur = abs(bits(1,1:nb_bits-2*retard)-BitsDecides16qam(1,(2*retard)+1:nb_bits)); 
        TEB16qam_moy(j) = mean(erreur); % Taux d'erreur binaire, TEB = nombre de bits reçus erronés / nombre de bits transmis;
    end 
    if mod(i,2) == 0 
    figure(f4ask)
    subplot(4,3,i/2);
    plot(z4ask_echant, zeros(1, length(z4ask_echant)),'+');
    xlabel("a_k");
    ylabel("b_k");
    title("constellation SNRdB = " + SNRdb(i));
    
    figure(fQpsk)
    subplot(4,3,i/2);
    plot(zQpsk_echant,'+');
    xlabel("a_k");
    ylabel("b_k");
    title("constellation SNRdB = " + SNRdb(i));

    figure(f8psk)
    subplot(4,3,i/2);
    plot(z8psk_echant,'+');
    xlabel("a_k");
    ylabel("b_k");
    title("constellation SNRdB = " + SNRdb(i));

    figure(f16qam)
    subplot(4,3,i/2);
    plot(z16qam_echant,'+');
    xlabel("a_k");
    ylabel("b_k");
    title("constellation SNRdB = " + SNRdb(i));
    end

    TEB4askB(i) = mean(TEB4ask_moy);
    TEBQpskB(i) = mean(TEBQpsk_moy);
    TEB8pskB(i) = mean(TEB8psk_moy);
    TEB16qamB(i) = mean(TEB16qam_moy);

    TEB4ask_th(i) = (2*(1-1/M4ask)*qfunc(sqrt(log2(M4ask)*rapport*6/(M4ask*M4ask-1))))/log2(M4ask);
    TEBQpsk_th(i) = 2*qfunc(sqrt(2 * rapport * log2(MQpsk))*sin(pi/MQpsk))/log2(MQpsk);
    TEB8psk_th(i) = 2*qfunc(sqrt(2*rapport*log2(M8psk))*sin(pi/M8psk))/log2(M8psk);
    TEB16qam_th(i) = (4/log2(M16qam))*(1-(1/sqrt(M16qam)))*qfunc(sqrt(3*log2(M16qam)*rapport/(M16qam-1)));
    
end

seuil = ones(1,length(TEB16qamB))*10^(-2);


figure("Name", "TEB en fonction de SNR chaine eq");
semilogy(SNRdb,TEB4askB, 'b');

grid on;
hold on 
semilogy(SNRdb,TEB4ask_th, '.- b');
semilogy(SNRdb,TEBQpskB, 'r');
semilogy(SNRdb,TEBQpsk_th, '-.r');
semilogy(SNRdb,TEB8pskB, 'g');
semilogy(SNRdb,TEB8psk_th, '-.g');
semilogy(SNRdb,TEB16qamB,'m');
semilogy(SNRdb,TEB16qam_th, '-. m');
semilogy(SNRdb, seuil);
xlabel('SNR (dB)');
ylabel('TEB');
title("TEB en fonction du rapport signal sur bruit")
 leg = legend('TEB4ask',...
     'TEB4ask théorique',...
     'TEBQpsk',...
     'TEBQpsk théorique',...
     'TEB8psk',...
     'TEB8psk théorique',...
     'TEB16qam',...
     'TEB16qam théorique',...
     'TEB_0',...,
     'location', 'NorthWest');

figure("Name", "TEB en fonction de SNR chaine eq comparaison théorique 4ASK");
subplot(2,2,1);
semilogy(SNRdb,TEB4askB);
grid on;
hold on 
semilogy(SNRdb,TEB4ask_th);
xlabel('SNR (dB)');
ylabel('TEB');
title("TEB 4-ASK en fonction du rapport signal sur bruit")
leg = legend('TEB4ask',...
       'TEBth',..., 
     'location', 'NorthWest');

subplot(2,2,2);
semilogy(SNRdb,TEBQpskB);

grid on;
hold on 
semilogy(SNRdb,TEBQpsk_th);
xlabel('SNR (dB)');
ylabel('TEB');
title("TEB QPSK en fonction du rapport signal sur bruit")
leg = legend('TEBQpsk',...
       'TEBth',..., 
     'location', 'NorthWest');

subplot(2,2,3);
semilogy(SNRdb,TEB8pskB);

grid on;
hold on 
semilogy(SNRdb,TEB8psk_th);
xlabel('SNR (dB)');
ylabel('TEB');
title("TEB 8-PSK en fonction du rapport signal sur bruit")
leg = legend('TEB8psk',...
       'TEBth',..., 
     'location', 'NorthWest');

subplot(2,2,4);
semilogy(SNRdb,TEB16qamB);

grid on;
hold on 
semilogy(SNRdb,TEB16qam_th);
xlabel('SNR (dB)');
ylabel('TEB');
title("TEB 16-QAM en fonction du rapport signal sur bruit")
 leg = legend('TEB16qam',...
       'TEBth',..., 
     'location', 'NorthWest');

%DSP
dsp_x4ask = fft(xcorr(x4ask));
dsp_xQpsk = fft(xcorr(xQpsk));
dsp_x8psk = fft(xcorr(x8psk));
dsp_x16qam = fft(xcorr(x16qam));


figure ("Name", "DSP");
semilogy(linspace(-Fe/2, Fe/2, length(dsp_x4ask)),fftshift(abs(dsp_x4ask)));
hold on;

semilogy(linspace(-Fe/2, Fe/2, length(dsp_xQpsk)),fftshift(abs(dsp_xQpsk)));

semilogy(linspace(-Fe/2, Fe/2, length(dsp_x8psk)),fftshift(abs(dsp_x8psk)));

semilogy(linspace(-Fe/2, Fe/2, length(dsp_x16qam)),fftshift(abs(dsp_x16qam)));

xlabel("Fréquence (Hz)");
ylabel("module de la DSP");
title("DSP du signal");
leg = legend('4ask',...
     'Qpsk',...
     '8psk',...
     '16qam',...,
     'location', 'NorthWest');