package src;
import java.io.Serializable;

import src.affichagePartie.*;
import src.batiments.*;
import src.carte.Carte;
public class Finances implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 366228672365772902L;
	int compteVille;
	Carte carte;
	
	Finances(int compte, Carte carte){
		this.compteVille = compte;
		this.carte = carte;
	}
	
	public void depenser(int argent) {
		compteVille -= argent;
		StatFinances.updateArgent(this.compteVille);
	}
	
	public void collecter() {
		for(Structure batiment : this.carte.getListeStructure().values()) {
			if (batiment instanceof Habitation) {
				Habitation bat = (Habitation) batiment;
				this.compteVille += 2 * bat.getNbHabitants();
			} else if (batiment instanceof Commerce) {
				Commerce bat = (Commerce) batiment;
				this.compteVille += -10 * bat.getNbEmployes();
				this.compteVille += 1000 * (3 + bat.getNiveau()) * (0.3 + 0.7*((double) bat.getNbEmployes())/bat.getMaxEmployes());
				this.depenser(100*bat.getValorisationEmplois());
				this.compteVille -= 900; //Coût entretien
			} else if (batiment instanceof Hopital) {
				Hopital bat = (Hopital) batiment;
				this.compteVille += -2 * bat.getNbEmployes();
				this.compteVille += 200 * (3 + bat.getNiveau()) * (0.3 + 0.7*((double) bat.getNbEmployes())/bat.getMaxEmployes());
				this.depenser(100*bat.getValorisationEmplois());
				this.compteVille -= 180; //Coût entretien
			} else if (batiment instanceof Industrie) {
				Industrie bat = (Industrie) batiment;
				this.compteVille += -5 * bat.getNbEmployes();
				this.compteVille += 250 * (3 + bat.getNiveau()) * (0.3 + 0.7*((double) bat.getNbEmployes())/bat.getMaxOuvriers());
				this.depenser(100*bat.getValorisationEmplois());
				this.compteVille -= 225; //Coût entretien
			} else if (batiment instanceof CasernePompier) {
				CasernePompier bat = (CasernePompier) batiment;
				this.compteVille += -3 * bat.getNbPompiers();
				this.depenser(100*bat.getValorisationEmplois());
			} else if (batiment instanceof Ecole) {
				Ecole bat = (Ecole) batiment;
				this.compteVille += -3 * bat.getNbEnseignantsfixe();
				this.compteVille += -20 * bat.getNbEtudiantsfixe();
			} else if (batiment instanceof Hotel) {
				Hotel bat = (Hotel) batiment;
				this.compteVille += -40 * bat.getNbEmployesfixe();
				this.compteVille += 30 * bat.getNbTouristesfixe();
			} else if (batiment instanceof Mairie) {
				Mairie bat = (Mairie) batiment;
				this.compteVille += -2 * bat.getNbEmplyesfixe();
			} else if (batiment instanceof PoleEmploi) {
				PoleEmploi bat = (PoleEmploi) batiment;
				this.compteVille += -2 * bat.getNbEmplyesfixe();
			} else if (batiment instanceof Police) {
				Police bat = (Police) batiment;
				this.compteVille += -3 * bat.getNbPoliciers();
				this.depenser(100*bat.getValorisationEmplois());
			} else if (batiment instanceof Usine) {
				Usine bat = (Usine) batiment;
				this.compteVille += -4 * bat.getNbEmployes();
				this.compteVille += 1000 * (3 + bat.getNiveau()) * (0.3 + 0.7*((double) bat.getNbEmployes())/bat.getMaxEmployes());
				this.depenser(100*bat.getValorisationEmplois());
				this.compteVille -= 900; //Coût entretien
			}
			
		}
		StatFinances.updateArgent(this.compteVille);
	}
}
