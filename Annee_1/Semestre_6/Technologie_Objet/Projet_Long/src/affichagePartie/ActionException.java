package src.affichagePartie;

@SuppressWarnings("serial")
public class ActionException extends Exception {
    /**
     * C'est une exception dans le choix du joueur
     * ex : on veut recuperer le nom du batiment à 
     * poser alors qu'il veut détruire quelque chose
     */
    private String message;
    
    public ActionException(String cause) {
		super();
        this.message = cause;
	}

    public String getMessage() {
        return this.message;
    }
}
