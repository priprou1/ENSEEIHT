/**
 * AgendaAbstrait factorise la définition du nom et de l'accesseur associé.
 */
public abstract class AgendaAbstrait extends ObjetNomme implements Agenda {

	/**
	 * Initialiser le nom de l'agenda.
	 *
	 * @param nom le nom de l'agenda
	 * @throws IllegalArgumentException si nom n'a pas au moins un caractère
	 */
	public AgendaAbstrait(String nom) {
		super(nom);
	}

	/**
	 * Vérifier que le créneau est valide.
	 *
	 * @param creneau le créneau à vérifier
	 * @throws CreneauInvalideException si le créneau est invalide
	 */
	public void verifierCreneauValide(int creneau) {
		if (creneau < CRENEAU_MIN || creneau > CRENEAU_MAX) {
			throw new CreneauInvalideException("Créneau invalide");
		}
	}

}
