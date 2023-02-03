package src.batiments;
import src.carte.*;

@SuppressWarnings("serial")
public class Hopital extends Batiment {

	// private static String img = "../Images/img_hopital.jpg";
	 
    private int maxPatients;
    private int maxEmployes;
    private int maxAmbulances;

    private int nbPatients;
    private int nbEmployes;
    private int nbAmbulances;
    private int perimetreAmbulances;
    
    private int valorisationEmplois;
    
    public static final int coutHopital = 120000;
    public static final int tempsHopital = 200;
    
/* Il faut également penser au périmètre de déplacement des ambulances.
Cependant les ambulances, les camions pompiers, polices, poubelles, approvisionnement
étant la même chose, on devrait faire une classe véhicule et attribuer un véhicule aux classes
qui en ont besoin. */


    public Hopital(Carte carte, Case coin, int rotation, Parcelle[] parcelles, int[] accesRoutes, int capacitePatients,
    		int capaciteEmployes, int capaciteAmbulances, int perimetreAmbulances, int attractivite, 
    		int valorisationEmplois, int niveau) {
    	
		super(coin, rotation, carte, parcelles, attractivite, niveau);
        this.nbPatients = 0;
        this.maxPatients = capacitePatients;
        
        this.nbEmployes = 0;
        this.maxEmployes = capaciteEmployes;
        
        this.nbAmbulances = 0;
        this.maxAmbulances = capaciteAmbulances;
        this.perimetreAmbulances = perimetreAmbulances;
        
        this.valorisationEmplois = valorisationEmplois;
        
        super.setCoutConstruction(coutHopital);
        super.setTempsConstruction(tempsHopital);
    }

    
    public Hopital(Case coin, Carte carte, 
			Parcelle[] parcelles, int[] accesRoutes, int niveau) {
		
		super(coin, 1, carte, parcelles, 5, niveau);
		this.valorisationEmplois = 7;
		this.nbPatients = 0;
		this.nbEmployes = 1;
		this.maxAmbulances = 1;
        setHopitalNiveau(niveau);
        super.setCoutConstruction(coutHopital);
        super.setTempsConstruction(tempsHopital);
	}
	
	
	public void setHopitalNiveau(int niveau) {
		switch (niveau) {
			case 1 : 
		        this.maxPatients = 50;
		        
		        this.maxEmployes = 70;
		        
		        this.maxAmbulances = 3;
		        this.perimetreAmbulances = 0;
				break;
		        
			case 2 :
		        this.maxPatients = 100;
		        
		        this.maxEmployes = 150;
		        
		        this.maxAmbulances = 6;
		        this.perimetreAmbulances = 0;
				break;
		        
			case 3 : 
		        this.maxPatients = 500;
		        
		        this.maxEmployes = 600;
		        
		        this.maxAmbulances = 10;
		        this.perimetreAmbulances = 0;
				break;
		        
			default :
				throw new NiveauInvalideException("niveau " + niveau + " inconnu", niveau);
		}
		
	}
    
	
	@Override
	public void ameliorer() {
		switch (this.getNiveau()) {
			case 1:
				this.maxPatients = 50;
		        
		        this.maxEmployes = 70;
		        
		        this.maxAmbulances = 3;
		        this.perimetreAmbulances = 0;
				break;

			case 2:
				this.maxPatients = 100;
					
				this.maxEmployes = 150;
				
				this.maxAmbulances = 6;
				this.perimetreAmbulances = 0;
				break;

			case 3:
				this.maxPatients = 500;
					
				this.maxEmployes = 600;
				
				this.maxAmbulances = 10;
				this.perimetreAmbulances = 0;
				break;
				
			default :
				throw new NiveauInvalideException("niveau " + this.getNiveau() + " inconnu", this.getNiveau());
		}
	}
	

	public void departAmbulance() {
		--this.nbAmbulances;
	}
	
	// On utilisera callback (fonctions de rappel) un événement réalisé.
	
	public void retourAmbulance() {
		this.nbPatients += 2;
		++this.nbAmbulances;
	}
	
	
	// Le temps de guérison d'un patient sera implémanté à l'aide de "update" plus tard
	

    public int getMaxAmbulances() {
        return this.maxAmbulances;
    }

    public void setMaxAmbulances(int capaciteAmbulances) {
        this.maxAmbulances = capaciteAmbulances;
    }
    
    public int getMaxPatients() {
        return this.maxPatients;
    }

    public void setMaxPatients(int capacitePatients) {
        this.maxPatients = capacitePatients;
    }
    
    public int getMaxEmployes() {
        return this.maxEmployes;
    }

    public void setMaxEmployes(int capaciteEmployes) {
        this.maxEmployes = capaciteEmployes;
    }
    
    public int getNbPatients() {
        return this.nbPatients;
    }

    public void setNbPatients(int nbPatients) {
        this.nbPatients = nbPatients;
    }

	public int getNbEmployes() {
		return this.nbEmployes;
	}

	public void setNbEmployes(int nbEmployes) {
		this.nbEmployes = nbEmployes;
	}
    
    public int getNbAmbulances() {
        return this.nbAmbulances;
    }

    public void setAmbulances(int ambulances) {
        this.nbAmbulances = ambulances;
    }

    public int getValorisationEmplois() {
		return this.valorisationEmplois;
	}

	public void setValorisationEmplois(int valorisationEmplois) {
		this.valorisationEmplois = valorisationEmplois;
	}

	public int getPerimetreAmbulances() {
			return this.perimetreAmbulances;
		}

		public void setPerimetreAmbulances(int perimetreAmbulances) {
			this.perimetreAmbulances = perimetreAmbulances;
		}
}