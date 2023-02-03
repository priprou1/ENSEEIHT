package src.affichagePartie;

public class SelectionAction {
    /**
     * Cette classe permets de comuniquer le choix de l'utilisateur
     * entre les outils graphique et la partie courante enregistrée, 
     * ainsi tout est en statique car c'est juste un fichier qui 
     * permets de transmettre des infos. Cela evite de transporter 
     * des instance d'un objet à travers de multiples classes qui 
     * ne s'en servent pas.
     */

    private static boolean detruire = false;
    private static String nomBatiment;
    private static int niveau = -1; // Valeur comprise entre 1 et 5, -1 si pas de niveau défini
    private static int rotationRoute = 1;  // Valeur comprise entre 0 et 3
    private static int parcelles = 1; // Valeur comprise entre 1 et 3

    // Rotation = -1 si nom != Routes
    public static void setChoixCompletBatiment(String nom, int level, int rotation) {
        detruire = false;
        nomBatiment = nom;
        niveau = level;
        if(nom.equalsIgnoreCase("routes")) {
            rotationRoute = rotation;
        } else {
            rotationRoute = -1;
        }
    }

    public static void setDetruire(Boolean choix) {
        detruire = choix;
        System.out.println("Modification detruire : " + choix);    
    }

    public static Boolean getDestruire() {
        return detruire;
    } 

    public static void setNomBatiment(String choix) {
        nomBatiment = choix;
        System.out.println("Modification nom batiment : " + choix);
    }

    public static String getNomBatiment() throws ActionException {
        if(!detruire) {
            return nomBatiment;
        } else {
            throw new ActionException("On ne peut récupérer le nom"
                + "d'un batiment à poser si l'on souhaite détruire quelque chose");
        }
    }

    public static void setNiveau(int choix) {
        niveau = choix;
        System.out.println("Modification niveau : " + choix);
    }

    public static int getNiveau() throws ActionException {
        if (niveau == -1) {
            throw new ActionException("Le niveau n'a pas été défini");
        }

        if(detruire) {
            throw new ActionException("On ne peut récupérer le niveau"
                + "d'un batiment à poser si l'on souhaite détruire quelque chose");
        }
        
        return niveau;
    }

    public static void setRotation(int choix) {
        rotationRoute = choix;
        System.out.println("Modification rotation : " + choix);
    }

    public static int getRotation() throws ActionException {
        if (rotationRoute == -1) {
            throw new ActionException("Le niveau n'a pas été défini");
        }

        if(detruire) {
            throw new ActionException("On ne peut récupérer le rotation"
                + "d'une route à poser si l'on souhaite détruire quelque chose");
        }

        if(!nomBatiment.equalsIgnoreCase("routes")) {
            throw new ActionException("Rotation valable uniquement pour les routes");
        }
        
        return rotationRoute;
    }

    public static void setParcelles(int choix) {
        parcelles = choix;
        System.out.println("Modification parcelles : " + choix);
    }

    public static int getParcelles() throws ActionException {
        if (parcelles == -1) {
            throw new ActionException("Le nombre de parcelles n'a pas été défini");
        }

        if(detruire) {
            throw new ActionException("On ne peut récupérer les parcelles"
                + "d'un batiment à poser si l'on souhaite détruire quelque chose");
        }

        if(nomBatiment.equalsIgnoreCase("routes")) {
            throw new ActionException("Parcelles non valable pour les routes");
        }
        
        return parcelles;
    }
}
