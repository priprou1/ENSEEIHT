package src;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;
import java.util.Random;

import src.batiments.*;
import src.carte.Case;

public final class Repartition {
	

	private static Random random = new Random();
	
	private static double satisfactionGen = 50;
	
	private static double satisfactionSansChom = 50;
	
	private static double chomage = 0;
	
	private static int nbHab(double satisfaction, int nbrMax, long temps) {//satisfaction compris entre 0 et 1
		return (Math.max((int) Math.min((int) (((satisfaction/100)*nbrMax)*(1-Math.exp(-((double) temps)/2)+random.nextDouble()/10)), nbrMax), 1));
	}
	
	public static int getNombresHabitantsTotales(Map<Case, Structure> batiments) {
		int nbrTotHab = 0;
		for(Structure batiment : batiments.values()) {
			if (batiment instanceof Batiment) {
				Batiment bat = (Batiment) batiment;
				bat.incTempsDeVie(1);
			}
			if (batiment instanceof Habitation) {
				Habitation bat = (Habitation) batiment;
				
				bat.setNbHabitants(nbHab(((double) bat.getSatisfaction()), bat.getCapacite(), bat.getTempsDeVie()));
				nbrTotHab += bat.getNbHabitants();
			}
			
			
		}
		return nbrTotHab;
	}
	
	private static int maxEmployesVal(int capacite, int valorisation) {
		return (int) Math.min(capacite * (1-Math.exp((double) -valorisation)/2 + 0.05), capacite);
	}
	
	public static void emploisRepartition(Map<Case, Structure> batiments, int nbrTotHab) {
		int valTot = 0;
		//Calcul valorisation totale émise
		for(Structure batiment : batiments.values()) {
			if (batiment instanceof CasernePompier) {
				CasernePompier bat = (CasernePompier) batiment;
				valTot += bat.getValorisationEmplois();
				bat.setNbPompiers(0);
			} else if (batiment instanceof Commerce) {
				Commerce bat = (Commerce) batiment;
				valTot += bat.getValorisationEmplois();
				bat.setNbEmployes(0);
			} else if (batiment instanceof Hopital) {
				Hopital bat = (Hopital) batiment;
				valTot += bat.getValorisationEmplois();
				bat.setNbEmployes(0);
			} else if (batiment instanceof Industrie) {
				Industrie bat = (Industrie) batiment;
				valTot += bat.getValorisationEmplois();
				bat.setNbEmployes(0);
			} else if (batiment instanceof Police) {
				Police bat = (Police) batiment;
				valTot += bat.getValorisationEmplois();
				bat.setNbPoliciers(0);
			}
		}
		valTot = Math.max(1, valTot);
		//Repartition des emplois
		//Nombre d'employes que l'on essaie de repartir de manière à respecter d'abord la valorisation mise en place
		int nbrEmployesParBat = Math.max(nbrTotHab/valTot, 1);
		//Nombre d'habitants non repartie
		int nbrRestants = nbrTotHab;
		//Batiments à remplir
		Collection<Structure> batARemplir = batiments.values();
		while (!batARemplir.isEmpty() & (nbrRestants > 0)) {
			//Batiments déjà remplis
			Collection<Structure> batAReremplir = new ArrayList<Structure>();
			for (Structure batiment : batARemplir) {
				if (nbrRestants > 0) {
					if (batiment instanceof CasernePompier) {
						CasernePompier bat = (CasernePompier) batiment;
						int maxEmployes = maxEmployesVal(bat.getMaxPompiers(), bat.getValorisationEmplois());
						int nbPompiers = Math.min(maxEmployes, nbrEmployesParBat*bat.getValorisationEmplois() + bat.getNbPompiers());
						nbrRestants -= nbPompiers-bat.getNbPompiers();
						bat.setNbPompiers(nbPompiers);
						if (nbPompiers < maxEmployes) {
							batAReremplir.add(batiment);
						} else {
							valTot -= bat.getValorisationEmplois();
						}
					} else if (batiment instanceof Commerce) {
						Commerce bat = (Commerce) batiment;
						int maxEmployes = maxEmployesVal(bat.getMaxEmployes(), bat.getValorisationEmplois());
						int nbEmployes = Math.min(maxEmployes, nbrEmployesParBat*bat.getValorisationEmplois() + bat.getNbEmployes());
						nbrRestants -= nbEmployes-bat.getNbEmployes();
						bat.setNbEmployes(nbEmployes);
						if (nbEmployes < maxEmployes) {
							batAReremplir.add(batiment);
						} else {
							valTot -= bat.getValorisationEmplois();
						}
					} else if (batiment instanceof Hopital) {
						Hopital bat = (Hopital) batiment;
						int maxEmployes = maxEmployesVal(bat.getMaxEmployes(), bat.getValorisationEmplois());
						int nbEmployes = Math.min(maxEmployes, nbrEmployesParBat*bat.getValorisationEmplois() + bat.getNbEmployes());
						nbrRestants -= nbEmployes-bat.getNbEmployes();
						bat.setNbEmployes(nbEmployes);
						if (nbEmployes < maxEmployes) {
							batAReremplir.add(batiment);
						} else {
							valTot -= bat.getValorisationEmplois();
						}
					} else if (batiment instanceof Industrie) {
						Industrie bat = (Industrie) batiment;
						int maxEmployes = maxEmployesVal(bat.getMaxOuvriers(), bat.getValorisationEmplois());
						int nbEmployes = Math.min(maxEmployes, nbrEmployesParBat*bat.getValorisationEmplois() + bat.getNbEmployes());
						nbrRestants -= nbEmployes-bat.getNbEmployes();
						bat.setNbEmployes(nbEmployes);
						if (nbEmployes < maxEmployes) {
							batAReremplir.add(batiment);
						} else {
							valTot -= bat.getValorisationEmplois();
						}
					} else if (batiment instanceof Police) {
						Police bat = (Police) batiment;
						int maxEmployes = maxEmployesVal(bat.getMaxPoliciers(), bat.getValorisationEmplois());
						int nbEmployes = Math.min(maxEmployes, nbrEmployesParBat*bat.getValorisationEmplois() + bat.getNbPoliciers());
						nbrRestants -= nbEmployes - bat.getNbPoliciers();
						bat.setNbPoliciers(nbEmployes);
						if (nbEmployes < maxEmployes) {
							batAReremplir.add(batiment);
						} else {
							valTot -= bat.getValorisationEmplois();
						}
					} 
				}
			}
			//Retirer les bâtiments déjà remplies à la liste des bâtiments à remplir
			
			batARemplir = batAReremplir;
			nbrEmployesParBat = Math.max(nbrRestants/Math.max(valTot, 1), 1);
		}
		chomage = ((double) nbrRestants) / nbrTotHab;
		satisfactionGen = satisfactionSansChom - chomage * satisfactionSansChom / 2;
	}
	
	public static double getSatifGen() {
		return satisfactionGen;
	}
	
	public static double getChomage() {
		return chomage;
	}
	
	private static int accidents(int nbTotHab, int facteur) {
		return (int) ((random.nextDouble() * nbTotHab)/facteur);
	}
	
	
	public static void chaosRepartitionHopital(Map<Case, Structure> batiments, int nbrTotHab) {
		int nbrPatientsTot = accidents(nbrTotHab, 10);
		int nbrHop = 0;
		for(Structure batiment : batiments.values()) {
			if (batiment instanceof Hopital) {
				Hopital bat = (Hopital) batiment;
				nbrHop++;
				bat.setNbPatients(0);
			}
		}
		int nbrPatientsArepartir = nbrPatientsTot/Math.max(nbrHop, 1) + 1; 
		for(Structure batiment : batiments.values()) {
			if (batiment instanceof Hopital) {
				Hopital bat = (Hopital) batiment;
				int nbrPatientsHop = Math.min(Math.min(nbrPatientsTot, nbrPatientsArepartir), (int) (bat.getMaxPatients()*(((double) bat.getNbEmployes())/bat.getMaxEmployes())));
				nbrPatientsTot-= nbrPatientsHop;
				bat.setNbPatients(nbrPatientsHop);
			}
		}
		
		if (nbrPatientsTot>0) satisfactionSansChom -= 0.5;
		if (satisfactionSansChom<0) satisfactionSansChom = 0;
		satisfactionGen = satisfactionSansChom - chomage * satisfactionSansChom / 2;
	
	}
	
	public static void chaosRepartitionPolice(Map<Case, Structure> batiments, int nbrTotHab) {
		int nbrOppTot = accidents(nbrTotHab, 100);
		for(Structure batiment : batiments.values()) {
			if (batiment instanceof Police) {
				Police bat = (Police) batiment;
				nbrOppTot-= bat.getNbPoliciers() * (bat.getNbCamions()+1);				
			}
		}
		if (nbrOppTot>0) satisfactionSansChom -= 0.5;
		if (satisfactionSansChom<0) satisfactionSansChom = 0;
		satisfactionGen = satisfactionSansChom - chomage * satisfactionSansChom / 2;
	
	}
	
	public static void chaosRepartitionPompier(Map<Case, Structure> batiments, int nbrTotHab) {
		int nbrOppTot = accidents(nbrTotHab, 100);
		for(Structure batiment : batiments.values()) {
			if (batiment instanceof CasernePompier) {
				CasernePompier bat = (CasernePompier) batiment;
				nbrOppTot-= bat.getNbPompiers() * (bat.getNbCamions()+1);
				
			}
		}
		if (nbrOppTot>0) satisfactionSansChom -= 0.5;
		if (satisfactionSansChom<0) satisfactionSansChom = 0;
		satisfactionGen = satisfactionSansChom - chomage * satisfactionSansChom / 2;
	
	}
	
	public static void gainBonheur(Map<Case, Structure> batiments, int nbrTotHab) {
		double pointBonheur = 0;
		for(Structure batiment : batiments.values()) {
			if (batiment instanceof Commerce) {
				Commerce bat = (Commerce) batiment;
				pointBonheur+= bat.getNiveau() * ((double) bat.getNbEmployes())/bat.getMaxEmployes();
			} else if (batiment instanceof Ecole) {
				Ecole bat = (Ecole) batiment;
				pointBonheur+= bat.getNiveau()* 10 * ((double) bat.getNbEtudiantsfixe())/nbrTotHab;
			}
		}
		satisfactionSansChom += 10*((double) pointBonheur)/nbrTotHab;
		if (satisfactionSansChom>100) satisfactionSansChom = 100;
		satisfactionGen = satisfactionSansChom - chomage * satisfactionSansChom / 2;
	}
}
