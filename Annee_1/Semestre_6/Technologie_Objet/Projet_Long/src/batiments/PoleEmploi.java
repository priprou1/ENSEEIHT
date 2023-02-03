package src.batiments;

import src.Structure;
import src.affichagePartie.Affichage_annonces;
import src.carte.Carte;
import src.carte.Case;

@SuppressWarnings("serial")
public class PoleEmploi extends Batiment {

    private int nbEmployesfixe;
    private int nbTotalHabtitants;
    private int nbTotalEmployes;

    public static final int coutPoleEmploi = 6000;
    public static final int tempsPoleEmploi = 110;
    
    public PoleEmploi(Case coin, int rotation, Carte carte, Parcelle[] parcelles,
    int attractivite, int nbEmployesfixe, int niveau) {

        super(coin, rotation, carte, parcelles, attractivite, niveau);
        this.nbEmployesfixe = nbEmployesfixe;
        this.nbTotalHabtitants = 0;
        this.nbTotalEmployes = 0;
        Affichage_annonces.addAnnonce(this.faireAnonces());
        
        super.setCoutConstruction(coutPoleEmploi);
        super.setTempsConstruction(tempsPoleEmploi);
    }


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


    public void collecter() {

        Carte carte = this.getCarte();

        for(Structure batiment : carte.getListeStructure().values()) {
			if (batiment instanceof Habitation) {
				Habitation bat = (Habitation) batiment;
				this.nbTotalHabtitants += bat.getNbHabitants();
			} else if (batiment instanceof Commerce) {
				Commerce bat = (Commerce) batiment;
				this.nbTotalEmployes += bat.getNbEmployes();
			} else if (batiment instanceof Hopital) {
				Hopital bat = (Hopital) batiment;
				this.nbTotalEmployes += bat.getNbEmployes();
			} else if (batiment instanceof Industrie) {
				Industrie bat = (Industrie) batiment;
				this.nbTotalEmployes += bat.getNbEmployes();
			}
        }
    }

    public int getNbEmplyesfixe() {
        return this.nbEmployesfixe;
    }

    public int getNbTotalHabitants() {
        return this.nbTotalHabtitants;
    }

    public int getNbTotalEmployes() {
        return this.nbTotalEmployes;
    }

    public String faireAnonces() {
        if (getNbTotalEmployes() > getNbTotalHabitants()) {
           String message = "Il y a plus d'employés que d'habitants dans la ville !\nIl est temps de créer de nouvelles habitations pour accueillir plus de monde dans votre ville.";
           return message;
        } else {
            String message = "Il n'y a pas assez d'employés dans votre ville !\nIl faut que vous créez de nouveaux emplois.";
            return message;
        }
    }
    
}