package src.batiments;

import src.carte.Carte;
import src.carte.Case;

@SuppressWarnings("serial")
public class Mairie extends Batiment {

    private int nbEmployesfixe;

    public static final int coutMairie= 7000;
    public static final int tempsMairie = 120;
    
    public Mairie(Case coin, int rotation, Carte carte, Parcelle[] parcelles,
    int attractivite, int nbEmployesfixe, int niveau) {

        super(coin, rotation, carte, parcelles, attractivite, niveau);
        this.nbEmployesfixe = nbEmployesfixe;
        
        super.setCoutConstruction(coutMairie);
        super.setTempsConstruction(tempsMairie);
    }

    // La mairie sert juste à être présente


    @Override
	public void ameliorer() {
		switch (this.getNiveau()) {
			case 1:
				this.nbEmployesfixe = 5;
				break;
			case 2:
				this.nbEmployesfixe = 10;
				break;
			case 3:
				this.nbEmployesfixe = 20;
				break;
			default :
				throw new NiveauInvalideException("niveau " + this.getNiveau() + " inconnu", this.getNiveau());
		}
	}

    public int getNbEmplyesfixe() {
        return this.nbEmployesfixe;
    }

}