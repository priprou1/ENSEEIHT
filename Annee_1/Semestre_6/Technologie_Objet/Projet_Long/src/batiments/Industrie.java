package src.batiments;
import src.carte.*;

@SuppressWarnings("serial")
public class Industrie extends Batiment {

	// private static String img = "../Images/img_industrie.jpg";


    private int maxOuvriers;

    private int nbEmployes;
    private int valorisationEmplois;

    public static final int coutIndustrie = 11000;
    public static final int tempsIndustrie = 130;
    
    public Industrie(Carte carte, Case coin, int rotation, Parcelle[] parcelles, int[] accesRoutes, int capaciteOuvriers,
    		int attractivite, int valorisationEmplois, int niveau) {
    	
		super(coin, rotation, carte, parcelles, attractivite, niveau);
        
        this.nbEmployes = 0;
        this.maxOuvriers = capaciteOuvriers;
        
        this.valorisationEmplois = valorisationEmplois;
        
        super.setCoutConstruction(coutIndustrie);
        super.setTempsConstruction(tempsIndustrie);
    }

    
    public Industrie(Case coin, Carte carte, Parcelle[] parcelles, int[] accesRoutes, int niveau) {

		super(coin, 1, carte, parcelles, 2, niveau);
		this.valorisationEmplois = 4;
        setIndustrieNiveau(niveau);
        super.setCoutConstruction(coutIndustrie);
        super.setTempsConstruction(tempsIndustrie);
	}
	
	
	public void setIndustrieNiveau(int niveau) {
		switch (niveau) {
			case 1 : 
		        this.nbEmployes = 0;
		        this.maxOuvriers = 20;
				break;
		        
			case 2 :
				this.nbEmployes = 20;
		        this.maxOuvriers = 50;
				break;
		        
			case 3 : 
				this.nbEmployes = 50;
		        this.maxOuvriers = 100;
				break;
		        
			default :
				throw new NiveauInvalideException("niveau " + niveau + " inconnu", niveau);
		}
		
	}
    
	@Override
	public void ameliorer() {
		switch (this.getNiveau()) {
			case 1:
				this.maxOuvriers = 20;
				break;
			case 2:
				this.maxOuvriers = 50;
				break;
			case 3:
				this.maxOuvriers = 100;
				break;
			default :
				throw new NiveauInvalideException("niveau " + this.getNiveau() + " inconnu", this.getNiveau());
		}
	}


    public int getMaxOuvriers() {
        return this.maxOuvriers;
    }

    public void setMaxOuvriers(int capaciteOuvriers) {
        this.maxOuvriers = capaciteOuvriers;
    }

	public int getNbEmployes() {
		return this.nbEmployes;
	}

	public void setNbEmployes(int nbEmployes) {
		this.nbEmployes = nbEmployes;
	}
    
    public int getValorisationEmplois() {
		return this.valorisationEmplois;
	}

	public void setValorisationEmplois(int valorisationEmplois) {
		this.valorisationEmplois = valorisationEmplois;
	}
}