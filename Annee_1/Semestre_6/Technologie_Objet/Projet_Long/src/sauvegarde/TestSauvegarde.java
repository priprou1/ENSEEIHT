package src.sauvegarde;


import src.PartieCourante;
import src.batiments.Habitation;
import src.batiments.Parcelle;
import src.carte.CaseOccupeeException;


public class TestSauvegarde {
    public static void main(String[] args) {
        PartieCourante partie1 = new PartieCourante("premiereVille");
        Parcelle parcelle = new Parcelle(partie1.getCarte().getCase(1, 1), partie1.getCarte().getCase(2, 2), partie1.getCarte());
        Parcelle[] parcelles = new Parcelle[1];
        parcelles[0] = parcelle;
        Habitation habitation = new Habitation(partie1.getCarte(), partie1.getCarte().getCase(1, 1), parcelles, 1);

        try {
            partie1.getCarte().construire(habitation);
        } catch (CaseOccupeeException e) {
            System.out.println("case occupée");
        }
        PartieCourante partie2 = new PartieCourante("secondeVille");
        Sauvegarder.creerSauvegarde(partie1);
        Sauvegarder.creerSauvegarde(partie2);
        System.out.print("sauvegarde faite");
    }
    
}
