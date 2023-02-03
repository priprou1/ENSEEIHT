package allumettes;

/** Proxy implémentatant le jeu des allumettes.
 * @author	Priscilia Gonthier
 */
public class Procuration implements Jeu {

	private Jeu jeu;

	/** Construire une procuration sur le jeu donné en paramètre.
	 * 
	 * @param jeu jeu sur lequel on crée la procuration
	 */
	Procuration(Jeu jeu) {
		this.jeu = jeu;
	}

	/** Obtenir le nombre d'allumettes encore en jeu.
	 * @return nombre d'allumettes encore en jeu
	 */
	public int getNombreAllumettes() {
		return this.jeu.getNombreAllumettes();
	}

	/** Retirer des allumettes.  Le nombre d'allumettes doit être compris
	 * entre 1 et PRISE_MAX, dans la limite du nombre d'allumettes encore
	 * en jeu.
	 * @param nbPrises nombre d'allumettes prises.
	 * @throws OperationInterditeException Tentative de retirer des
	 * allumettes sans permission
	 */
	public void retirer(int nbPrises) {
		throw new OperationInterditeException();
	}

}
