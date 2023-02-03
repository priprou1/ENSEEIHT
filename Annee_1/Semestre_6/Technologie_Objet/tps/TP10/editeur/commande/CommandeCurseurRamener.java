package editeur.commande;

import editeur.Ligne;

/** Ramener le curseur à l'élément 1 de la ligne.
 * @author Priscilia Gonthier
 */
public class CommandeCurseurRamener extends CommandeLigne {

	/** Initialiser la ligne sur laquelle travaille
	 * cette commande.
	 * @param l la ligne
	 */
	//@ requires l != null;	// la ligne doit être définie
	public CommandeCurseurRamener(Ligne l) {
		super(l);
	}
	
	public void executer() {
		ligne.raz();
	}

	public boolean estExecutable() {
		return ligne.getLongueur() > 0;
	}
}
