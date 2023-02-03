package src.batiments;

import src.carte.Carte;
import src.carte.Case;

@SuppressWarnings("serial")
public class Ecole extends Batiment {

    private int nbEtudiantsfixe;
    private int nbEnseignantsfixe;
    private String nom;

    private int valorisationEmplois;
    
    public static final int coutEcole = 50000;
    public static final int tempsEcole= 100;
    
    public Ecole(String nom, Carte carte, Case coin, Parcelle[] parcelles, int attractivite, int nbEtudiants, int nbEnseignants, int niveau) {
		
		//super(carte.getCase(0, 0), 1, carte, parcelles, 5, niveau, 0, 0);
		super(coin, 1, carte, parcelles, attractivite, niveau);
        this.nom = nom;
		this.nbEtudiantsfixe = nbEtudiants;
        this.nbEnseignantsfixe = nbEnseignants;
        
        super.setCoutConstruction(coutEcole);
        super.setTempsConstruction(tempsEcole);
        
		}

    
    public Ecole(String nom, Case coin, Carte carte, Parcelle[] parcelles, 
    int niveau) {
   
        super(coin, 1, carte, parcelles, 5, niveau);
        this.nom = nom;
        this.valorisationEmplois = 7;
        setEcoleNiveau(niveau);
        
        super.setCoutConstruction(coutEcole);
        super.setTempsConstruction(tempsEcole);
    }


public void setEcoleNiveau(int niveau) {
   switch (niveau) {
       case 1 :            
           this.nbEtudiantsfixe = 200;
           this.nbEnseignantsfixe = 15;
           break;
       case 2 :           
            this.nbEtudiantsfixe = 500;
            this.nbEnseignantsfixe = 30;
           break;
       case 3 :            
            this.nbEtudiantsfixe = 1000;
            this.nbEnseignantsfixe = 100;
           break;
       default :
           throw new NiveauInvalideException("niveau " + niveau + " inconnu", niveau);
   }
   
}


    @Override
    public void ameliorer() {
        switch (this.getNiveau()) {
            case 1:
                this.nbEtudiantsfixe = 200;
                this.nbEnseignantsfixe = 15; 
                break;
            case 2:
                this.nbEtudiantsfixe = 500;
                this.nbEnseignantsfixe = 30;
                break;
            case 3:
                this.nbEtudiantsfixe = 1000;
                this.nbEnseignantsfixe = 100;
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

    public void setNbEtudiantsfixe(int nbEtudiants) {
        this.nbEtudiantsfixe = nbEtudiants;
    }

    public int getNbEtudiantsfixe() {
        return this.nbEtudiantsfixe;
    }

    public void setNbEnseignantsfixe(int nbEnseignants) {
        this.nbEnseignantsfixe = nbEnseignants;
    }

    public int getNbEnseignantsfixe() {
        return this.nbEnseignantsfixe;
    }

    public int getValorisationEmplois() {
		return this.valorisationEmplois;
	}

	public void setValorisationEmplois(int valorisationEmplois) {
		this.valorisationEmplois = valorisationEmplois;
	}

}