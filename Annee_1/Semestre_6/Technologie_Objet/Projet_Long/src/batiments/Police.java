package src.batiments;

import src.carte.Carte;
import src.carte.Case;

@SuppressWarnings("serial")
public class Police extends Batiment {

    private int maxPoliciers;
    private int maxCamions;
    private int nbPoliciers;
    private int nbCamions;
    private int perimetreCamions;
    
    private int valorisationEmplois;
    
    public static final int coutPolice = 10000;
    public static final int tempsPolice = 140;
    
    public Police(Carte carte, Case coin, int rotation, Parcelle[] parcelles, int[] accesRoutes,
    		int capacitePoliciers, int capaciteCamions, int perimetreCamions, int attractivite, 
    		int valorisationEmplois, int niveau) {
    	
		super(coin, rotation, carte, parcelles, attractivite, niveau);

        this.nbPoliciers = 0;
        this.maxPoliciers = capacitePoliciers;
        
        this.nbCamions = 0;
        this.maxCamions = capaciteCamions;
        this.perimetreCamions = perimetreCamions;
        
        this.valorisationEmplois = valorisationEmplois;
        
        super.setCoutConstruction(coutPolice);
        super.setTempsConstruction(tempsPolice);
    }

    
    public Police(Case coin, Carte carte, 
			Parcelle[] parcelles, int[] accesRoutes, int attractivite, int niveau) {
		
		super(coin, 1, carte, parcelles, attractivite, niveau);
		this.valorisationEmplois = 7;
        setPoliceNiveau(niveau);
        super.setCoutConstruction(coutPolice);
        super.setTempsConstruction(tempsPolice);
	}
	
	
	public void setPoliceNiveau(int niveau) {
		switch (niveau) {
			case 1: 
				this.nbPoliciers = 0;
				this.nbCamions = 0;

        		this.maxPoliciers = 5;
				this.maxCamions = 1;
				this.perimetreCamions = 0;
				break;
		        
			case 2:
				this.nbPoliciers = 5;
				this.nbCamions = 1;

				this.maxPoliciers = 15;
				this.maxCamions = 2;
				this.perimetreCamions = 0;
				break;
		        
			case 3: 
				this.nbPoliciers = 15;
				this.nbCamions = 2;

				this.maxPoliciers = 30;
				this.maxCamions = 3;
				this.perimetreCamions = 0;
				break;
		        
			default:
				throw new NiveauInvalideException("niveau " + niveau + " inconnu", niveau);
		}
		
	}
    
	
	@Override
	public void ameliorer() {
		switch (this.getNiveau()) {
			case 1:
				this.maxPoliciers = 5;
				this.maxCamions = 1;
				this.perimetreCamions = 0;
				break;
			case 2:
				this.maxPoliciers = 15;
				this.maxCamions = 2;
				this.perimetreCamions = 0;
				break;
			case 3:
				this.maxPoliciers = 30;
				this.maxCamions = 3;
				this.perimetreCamions = 0;
				break;
			default :
				throw new NiveauInvalideException("niveau " + this.getNiveau() + " inconnu", this.getNiveau());
		}
	}

    public int getMaxCamions() {
        return this.maxCamions;
    }

    public void setMaxCamions(int capaciteCamions) {
        this.maxCamions = capaciteCamions;
    }
    
    public int getMaxPoliciers() {
        return this.maxPoliciers;
    }

    public void setMaxPoliciers(int capacitePoliciers) {
        this.maxPoliciers = capacitePoliciers;
    }


	public int getNbPoliciers() {
		return this.nbPoliciers;
	}

	public void setNbPoliciers(int nbPoliciers) {
		this.nbPoliciers = nbPoliciers;
	}
    
    public int getNbCamions() {
        return this.nbCamions;
    }

    public void setCamions(int camions) {
        this.nbCamions = camions;
    }

    public int getValorisationEmplois() {
		return this.valorisationEmplois;
	}

	public void setValorisationEmplois(int valorisationEmplois) {
		this.valorisationEmplois = valorisationEmplois;
	}

	public int getPerimetreCamions() {
		return this.perimetreCamions;
	}

	public void setPerimetreCamions(int perimetreCamions) {
		this.perimetreCamions = perimetreCamions;
	}

}
