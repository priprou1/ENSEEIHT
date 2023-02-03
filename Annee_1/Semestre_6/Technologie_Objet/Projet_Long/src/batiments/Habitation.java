package src.batiments;

import src.carte.Carte;
import src.carte.Case;

@SuppressWarnings("serial")
public class Habitation extends Batiment {

	// private static String img = "../Images/img_habitation.jpg";

	private int nbHabitants;
	private int capacite;

	// public Habitation(Carte carte, Case coin, int attractivite, int nbHabitants,
	// 		int capacite, int rotation, Parcelle[] parcelles, int[] accesRoutes, int tempsConstruction, int coutConstruction) {
		
	// 	super(coin, rotation, carte, parcelles, attractivite, niveau,
	// 			tempsConstruction, coutConstruction);
	// 	this.niveau = 1;
	// 	this.nbHabitants = nbHabitants;
	// 	this.capacite = capacite;
	// }
	
	
	public Habitation(Carte carte, Case coin, Parcelle[] parcelles, int niveau) {
		
		//super(carte.getCase(0, 0), 1, carte, parcelles, 5, niveau, 0, 0);
		super(coin, 1, carte, parcelles, 5, niveau);
		setHabitationNiveau(niveau);
		}


	public void setHabitationNiveau(int niveau) {
		switch (niveau) {
			case 1 : 
				this.nbHabitants = 10;
				this.capacite = 20;
				this.tempsConstruction = 200;
				this.coutConstruction = 20;
				break;
			case 2 :
				this.nbHabitants = 50;
				this.capacite = 100;
				this.tempsConstruction = 1000;
				this.coutConstruction = 100;
				break;
			case 3 : 
				this.nbHabitants = 100;
				this.capacite = 200;
				this.tempsConstruction = 2000;
				this.coutConstruction = 200;
				break;
			default :
				throw new NiveauInvalideException("niveau " + niveau + " inconnu", niveau);
		}
		
	}
	

	@Override
	public void ameliorer() {
		switch (this.getNiveau()) {
			
			case 1:
				this.capacite = 20;
				this.tempsConstruction = 20;
				this.coutConstruction = 20;
				break;
			case 2:
				this.capacite = 100;
				this.tempsConstruction = 100;
				this.coutConstruction = 100;
				break;
			case 3:
				this.capacite = 200;
				this.tempsConstruction = 200;
				this.coutConstruction = 200;
				break;

			default :
				throw new NiveauInvalideException("niveau " + this.getNiveau() + " inconnu", this.getNiveau());
		}
	}

	public int getNbHabitants() {
		return this.nbHabitants;
	}

	public void setNbHabitants(int nbHabitants) {
		this.nbHabitants = nbHabitants;
	}

	public int getCapacite() {
		return this.capacite;
	}

	public void setCapacite(int capacite) {
		this.capacite = capacite;
	}

}
