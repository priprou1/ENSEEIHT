package src;

//import javax.media.GainControl;
import java.io.*;
import java.time.*;
import java.util.*;
import src.affichagePartie.*;
import src.batiments.Batiment;
import src.batiments.Habitation;
import src.batiments.Usine;
import src.carte.*;

import javax.swing.JFrame;



public class PartieCourante implements Serializable{
	


	/**
	 * 
	 */
	private static final long serialVersionUID = 5606568934902184848L;

	private transient Timer timer;
	
	private static boolean pause;
	
	private Carte carte;

	private Finances finances;
	
	private int nbrTotHab;
	
	private long tempsInter;//En milisecondes
	
	private long tempsTotal;//En milisecondes
	
	private int nombreIter;
	
	private Instant dernierTempsPris;
	
	private String nom;
	
	
	
	
	public PartieCourante(Carte carte, Finances finances, String nom) {
		this.carte = carte;
		this.finances = finances;
		this.tempsTotal = 0;
		this.tempsInter = 0;
		this.nombreIter = 0;
		this.nom = nom;
		this.dernierTempsPris = Instant.now();
		PartieCourante.pause = false;
		this.setTimer();		
	}
	
	public PartieCourante(Carte carte, String nom) {
		this(carte, new Finances(100000, carte), nom);
	}
	
	public PartieCourante(String nom) {
		this(new Carte(40, 25), nom);
	}
	
	public PartieCourante() {
		this("Première Partie");
	}
	
	
	
	public static void setPause(boolean pause) {
		PartieCourante.pause = pause;
	}
	
	
	public Finances getFinances() {
		return this.finances;
	}
	
	public Carte getCarte() {
		return this.carte;
	}
	
	public String getNom() {
		return this.nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	
	public void getNombresHabitantsTotales() {
		Map<Case, Structure> batiments = this.carte.getListeStructure();
		nbrTotHab = Repartition.getNombresHabitantsTotales(batiments);
		StatHabitants.updatePopulation(nbrTotHab);
	}
	
	
	public void getSatisfaction() {
		double satisfaction = 0;
		Map<Case, Structure> batiments = this.carte.getListeStructure();
		for(Structure batiment : batiments.values()) {
			if (batiment instanceof Habitation) {
				Habitation bat = (Habitation) batiment;
				bat.setSatisfaction((int) ((bat.getSatisfaction() + Repartition.getSatifGen())/2));
				satisfaction += ((double) bat.getSatisfaction() * bat.getNbHabitants())/nbrTotHab;
			}
			
		}
		StatHabitants.updateBonheur(satisfaction);
	}
	
	public void getTemps() {
		Affichage_titre.updateDay(Horloge.dayTime(tempsTotal));
		Affichage_titre.updateTime(Horloge.timeTime(tempsTotal));
	}
	
	public void getEnergie() {
		int energie = 0;
		Map<Case, Structure> batiments = this.carte.getListeStructure();
		for(Structure batiment : batiments.values()) {
			if (batiment instanceof Usine) {
				Usine bat = (Usine) batiment;
				energie += bat.getEnergieProduite();
			} else if (batiment instanceof Batiment) {
				Batiment bat = (Batiment) batiment;
				energie -= bat.getEnergieConsomme();
			}
		}
		StatFinances.updateEnergie(energie);
	}
	
	public void setTimer() {
		Musique.setMusiquePartie(true);
		PartieCourante.setPause(false);
		this.timer = new Timer();
		this.timer.schedule(new TimerTask(){
			
			@Override
			public void run() {
					if (!pause) {
						Instant tempsPris = Instant.now();
						tempsInter = tempsPris.toEpochMilli()-dernierTempsPris.toEpochMilli();
						dernierTempsPris = tempsPris;
						tempsTotal += (tempsInter > 200 ? 200: tempsInter);
						nombreIter += 1;
						if (nombreIter >= 60) {
							nombreIter = 0;
							finances.collecter();
							getNombresHabitantsTotales();
							if (nbrTotHab>0) Repartition.emploisRepartition(carte.getListeStructure(), nbrTotHab);
							if (nbrTotHab>0) Repartition.chaosRepartitionHopital(carte.getListeStructure(), nbrTotHab);
							if (nbrTotHab>0) Repartition.chaosRepartitionPolice(carte.getListeStructure(), nbrTotHab);
							if (nbrTotHab>0) Repartition.chaosRepartitionPompier(carte.getListeStructure(), nbrTotHab);
							if (nbrTotHab>0) Repartition.gainBonheur(carte.getListeStructure(), nbrTotHab);
							getSatisfaction();
						}
						getTemps();
					}
			}
			
		}, 0, 100);
	}

	public void stopTimer() {
		PartieCourante.setPause(true);
		this.timer.cancel();
	}
	


    public void afficher(JFrame fenetre) {
		/*Pour que l'on puisse lancer l'affichage dans la fenetre donnée*/
		// Soit je te donne la fenetre dans cette fonction et donc tu as a chaque fois besoin de recréer un affichage soit tu le fait dans le constructeur.
		AffichagePartie affichage = new AffichagePartie(fenetre, this.carte, this.finances);
		affichage.afficher();
		Affichage_titre.updateTitle(nom);
    }
    
}

