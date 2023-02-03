package src.batiments;

import src.carte.Carte;
import src.carte.Case;

@SuppressWarnings("serial")
public class CasernePompier extends Batiment {

	// private static String img = "../Images/img_pompier.jpg";

	private int maxPompiers;
    private int maxCamions;
    private int nbPompiers;
    private int nbCamions;
    private int perimetreCamions;
    
    private int valorisationEmplois;
    
    public static final int coutCasernePompier = 5000;
    public static final int tempsCasernePompier = 100;
    
/* Il faut également penser au périmètre de déplacement des ambulances.
Cependant les ambulances, les camions pompiers, polices, poubelles, approvisionnement
étant la même chose, on devrait faire une classe véhicule et attribuer un véhicule aux classes
qui en ont besoin. */


    public CasernePompier(Carte carte, Case coin, int rotation, Parcelle[] parcelles, int[] accesRoutes,
    		int capacitePompiers, int capaciteCamions, int perimetreCamions, int attractivite, 
    		int valorisationEmplois, int niveau) {
    	
		super(coin, rotation, carte, parcelles, attractivite, niveau);

        this.nbPompiers = 0;
        this.maxPompiers = capacitePompiers;
        
        this.nbCamions = 0;
        this.maxCamions = capaciteCamions;
        this.perimetreCamions = perimetreCamions;
        
        this.valorisationEmplois = valorisationEmplois;
        
        super.setCoutConstruction(coutCasernePompier);
        super.setTempsConstruction(tempsCasernePompier);
    }

    
    public CasernePompier(Case coin, Carte carte, 
			Parcelle[] parcelles, int[] accesRoutes, int niveau) {
		
		super(coin, 1, carte, parcelles, 5, niveau);
		this.valorisationEmplois = 7;
        setCasernePompierNiveau(niveau);
        super.setCoutConstruction(coutCasernePompier);
        super.setTempsConstruction(tempsCasernePompier);
	}
	
	
	public void setCasernePompierNiveau(int niveau) {
		switch (niveau) {
			case 1: 
				this.nbPompiers = 0;
				this.nbCamions = 0;

				this.maxPompiers = 5;
				this.maxCamions = 1;
				this.perimetreCamions = 0;
				break;
		        
			case 2:
				this.nbPompiers = 5;
				this.nbCamions = 1;

				this.maxPompiers = 15;
				this.maxCamions = 2;
				this.perimetreCamions = 0;
				break;
		        
			case 3: 
				this.nbPompiers = 15;
				this.nbCamions = 2;

				this.maxPompiers = 30;
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
				this.maxPompiers = 5;
				this.maxCamions = 1;
				this.perimetreCamions = 0;
				break;
			case 2:
				this.maxPompiers = 15;
				this.maxCamions = 2;
				this.perimetreCamions = 0;
				break;
			case 3:
				this.maxPompiers = 30;
				this.maxCamions = 3;
				this.perimetreCamions = 0;
				break;
			default :
				throw new NiveauInvalideException("niveau " + this.getNiveau() + " inconnu", this.getNiveau());
		}
	}

	public void departCamions() {
		--this.nbCamions;
	}
	
	// On utilisera callback (fonctions de rappel) un événement réalisé.
	
	public void retourCamions() {
		++this.nbCamions;
	}
	

    public int getMaxCamions() {
        return this.maxCamions;
    }

    public void setMaxCamions(int capaciteCamions) {
        this.maxCamions = capaciteCamions;
    }
    
    public int getMaxPompiers() {
        return this.maxPompiers;
    }

    public void setMaxPompiers(int capacitePompiers) {
        this.maxPompiers = capacitePompiers;
    }


	public int getNbPompiers() {
		return this.nbPompiers;
	}

	public void setNbPompiers(int nbPompiers) {
		this.nbPompiers = nbPompiers;
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
