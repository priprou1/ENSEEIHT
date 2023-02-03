package allumettes;

/** Implémentation du jeu des allumettes.
 * @author	Priscilia Gonthier
 */
public class JeuAllumettes implements Jeu {

	/* Nombre d'allumettes encore présentes dans le jeu */
	private int nombreAllumettes;

	/** Construire le Jeu.
	 * @param nombreInitial nombre d'allumettes initialment présentes
	 * en début de partie.
	 */
	JeuAllumettes(int nombreInitial) {
		this.nombreAllumettes = nombreInitial;
	}

	/** Obtenir le nombre d'allumettes encore en jeu.
	 * @return nombre d'allumettes encore en jeu
	 */
	public int getNombreAllumettes() {
		return this.nombreAllumettes;
	}

	/** Retirer des allumettes.  Le nombre d'allumettes doit être compris
	 * entre 1 et PRISE_MAX, dans la limite du nombre d'allumettes encore
	 * en jeu.
	 * @param nbPrises nombre d'allumettes prises.
	 * @throws CoupInvalideException tentative de prendre un nombre invalide d'allumettes.
	 */
	public void retirer(int nbPrises) throws CoupInvalideException {
		if (nbPrises > this.nombreAllumettes) {
			throw new CoupInvalideException(nbPrises, ">" + this.nombreAllumettes);
		} else if (nbPrises < 1) {
			throw new CoupInvalideException(nbPrises, "< 1");
		} else if (nbPrises > PRISE_MAX) {
			throw new CoupInvalideException(nbPrises, ">" + PRISE_MAX);
		}
		this.nombreAllumettes = this.nombreAllumettes - nbPrises;
	}

}
