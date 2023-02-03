/**
 * Définition d'un agenda individuel.
 */
public class AgendaIndividuel extends AgendaAbstrait {

	private String[] rendezVous;	// le texte des rendezVous


	/**
	 * Créer un agenda vide (avec aucun rendez-vous).
	 *
	 * @param nom le nom de l'agenda
	 * @throws IllegalArgumentException si nom nul ou vide
	 */
	public AgendaIndividuel(String nom) {
		super(nom);
		this.rendezVous = new String[Agenda.CRENEAU_MAX + 1];
			// On gaspille une case (la première qui ne sera jamais utilisée)
			// mais on évite de nombreux « creneau - 1 »
	}


	@Override
	public void enregistrer(int creneau, String rdv) throws OccupeException {
		verifierCreneauValide(creneau);
		try {
			if (this.rendezVous[creneau] != null) {
				throw new OccupeException("Case occupé");
			} else if (rdv.length() == 0) {
				throw new IllegalArgumentException("nom doit avoir au moins 1 caractère");
			}
			this.rendezVous[creneau] = rdv;
		} catch(NullPointerException e) {
			throw new IllegalArgumentException("nom doit avoir au moins 1 caractère");
		}
	}


	@Override
	public boolean annuler(int creneau) {
		verifierCreneauValide(creneau);
		boolean modifie = this.rendezVous[creneau] != null;
		this.rendezVous[creneau] = null;
		return modifie;
	}


	@Override
	public String getRendezVous(int creneau) throws LibreException {
		verifierCreneauValide(creneau);
		if (this.rendezVous[creneau] == null) {
			throw new LibreException("case vide");
		}
		return this.rendezVous[creneau];
	}


}
