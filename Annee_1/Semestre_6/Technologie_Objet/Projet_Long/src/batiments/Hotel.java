package src.batiments;

import src.carte.Carte;
import src.carte.Case;

@SuppressWarnings("serial")
public class Hotel extends Batiment {

    private int nbTouristesfixe;
    private int nbEmployesfixe;
    private String nom;

    private int valorisationEmplois;
    
    public static final int coutHotel = 8000;
    public static final int tempsHotel = 150;
    
    public Hotel(String nom, Carte carte, Case coin, Parcelle[] parcelles, int attractivite, int nbTouristes, int nbEmployes, int niveau) {
		
		//super(carte.getCase(0, 0), 1, carte, parcelles, 5, niveau, 0, 0);
		super(coin, 1, carte, parcelles, attractivite, niveau);
        this.nom = nom;
		this.nbTouristesfixe = nbTouristes;
        this.nbEmployesfixe = nbEmployes;
        
        super.setCoutConstruction(coutHotel);
        super.setTempsConstruction(tempsHotel);
		}

    
    public Hotel(String nom, Case coin, Carte carte, Parcelle[] parcelles, int niveau) {
   
        super(coin, 1, carte, parcelles, 5, niveau);
        this.nom = nom;
        this.valorisationEmplois = 7;
        setHotelNiveau(niveau);
        super.setCoutConstruction(coutHotel);
        super.setTempsConstruction(tempsHotel);
    }


public void setHotelNiveau(int niveau) {
   switch (niveau) {
       case 1 :            
           this.nbTouristesfixe = 200;
           this.nbEmployesfixe = 15;
           break;
       case 2 :           
            this.nbTouristesfixe = 500;
            this.nbEmployesfixe = 30;
           break;
       case 3 :            
            this.nbTouristesfixe = 1000;
            this.nbEmployesfixe = 100;
           break;
       default :
           throw new NiveauInvalideException("niveau " + niveau + " inconnu", niveau);
   }
   
}


    @Override
    public void ameliorer() {
        switch (this.getNiveau()) {
            case 1:
                this.nbTouristesfixe = 200;
                this.nbEmployesfixe = 15; 
                break;
            case 2:
                this.nbTouristesfixe = 500;
                this.nbEmployesfixe = 30;
                break;
            case 3:
                this.nbTouristesfixe = 1000;
                this.nbEmployesfixe = 100;
                break;
            default :
                throw new NiveauInvalideException("niveau " + this.getNiveau() + " inconnu", this.getNiveau());
        }
    }

    public String getNom() {
		return this.nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

    public void setNbTouristesfixe(int nbTouristes) {
        this.nbTouristesfixe = nbTouristes;
    }

    public int getNbTouristesfixe() {
        return this.nbTouristesfixe;
    }

    public void setNbEmployesfixe(int nbEmployes) {
        this.nbEmployesfixe = nbEmployes;
    }

    public int getNbEmployesfixe() {
        return this.nbEmployesfixe;
    }

    public int getValorisationEmplois() {
		return this.valorisationEmplois;
	}

	public void setValorisationEmplois(int valorisationEmplois) {
		this.valorisationEmplois = valorisationEmplois;
	}

}

