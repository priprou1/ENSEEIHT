package src.batiments;

import src.carte.Carte;
import src.carte.Case;

@SuppressWarnings("serial")
public class Usine extends Batiment {

	// private static String img = "../Images/img_usine.jpg";

	private int nbEmployes;
	private int maxEmployes;
	private int valorisationEmplois;
	private int energieProduite;

	public static final int coutUsine = 13000;
	public static final int tempsUsine = 200;

	public Usine(Case coin, int rotation, Carte carte, Parcelle[] parcelles,
			int[] accesRoutes, int attractivite, int valorisationEmplois, int maxEmployes, 
			int niveau, int tempsConstruction, int coutConstruction) {

		super(coin, rotation, carte, parcelles, attractivite, niveau);
		this.nbEmployes = 0;
		this.valorisationEmplois = valorisationEmplois;
		this.maxEmployes = maxEmployes;
		this.energieProduite = 0;

		super.setCoutConstruction(coutUsine);
		super.setTempsConstruction(tempsUsine);

	}


	public Usine(Case coin, Carte carte, Parcelle[] parcelles, int[] accesRoutes, int niveau) {

		super(coin, 1, carte, parcelles, 5, niveau);
		this.valorisationEmplois = 3;
		this.nbEmployes = 1;
		setUsineNiveau(niveau);
		super.setCoutConstruction(coutUsine);
		super.setTempsConstruction(tempsUsine);
	}


	public void setUsineNiveau(int niveau) {
		switch (niveau) {
			case 1 :
				this.maxEmployes = 20;
				this.energieProduite = 200;
				break;
			case 2 :
				this.maxEmployes = 50;
				this.energieProduite = 500;
				break;
			case 3 :
				this.maxEmployes = 100;
				this.energieProduite = 1000;
				break;
			default :
				throw new NiveauInvalideException("niveau " + niveau + " inconnu", niveau);
		}

	}

	@Override
	public void ameliorer() {
		switch (this.getNiveau()) {
			case 1:
				this.maxEmployes = 20;
				this.energieProduite = 200;
				break;
			case 2:				
				this.maxEmployes = 50;
				this.energieProduite = 500;
				break;
			case 3:
				this.maxEmployes = 100;
				this.energieProduite = 1000;
				break;
			default :
				throw new NiveauInvalideException("niveau " + this.getNiveau() + " inconnu", this.getNiveau());
		}
	}

	/* Il faudra définir un certain nombre d'employé, attractivité et valorisation de
	   l'emploi en fonction du commerce soit en créant des sous-classes de commerce,
	   soit en créant directement ces commerces à l'aide du 1er constructeur*/


	public int getValorisationEmplois() {
		return this.valorisationEmplois;
	}

	public void setValorisationEmplois(int valorisationEmplois) {
		this.valorisationEmplois = valorisationEmplois;
	}

	public int getNbEmployes() {
		return this.nbEmployes;
	}

	public void setNbEmployes(int nbEmployes) {
		this.nbEmployes = nbEmployes;
	}

	public int getMaxEmployes() {
		return this.maxEmployes;
	}

	public void setMaxEmployes(int capaciteMaxEmployes) {
		this.maxEmployes = capaciteMaxEmployes;
	}


	public int getEnergieProduite() {
		return this.energieProduite;
	}

	public void setEnergieProduite(int energie) {
		this.energieProduite = energie;
	}

}
