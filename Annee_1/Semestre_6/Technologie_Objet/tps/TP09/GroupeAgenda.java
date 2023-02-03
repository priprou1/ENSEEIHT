import java.util.List;
public class GroupeAgenda extends AgendaAbstrait {
	
	private AgendaAbstrait[] agendas;	
	private int nbAgendas;
	
	GroupeAgenda(String nom, int capacite) {
		super(nom);
		this.agendas = new Agenda[capacite];
		this.nbAgendas = 0;
	}

	public void ajouter(Agenda agenda) {
		
	}
	
	@Override
	public void enregistrer(int creneau, String rdv) throws OccupeException {
		for (int i=0; i < nbAgendas; i++) {
			this.agendas[i].verifierCreneauValide(creneau);
			try {
				if (this.agendas[i][creneau] != null) {
					throw new OccupeException("Case occupé");
				} else if (rdv.length() == 0) {
					throw new IllegalArgumentException("nom doit avoir au moins 1 caractère");
				}
				this.rendezVous[creneau] = rdv;
			} catch(NullPointerException e) {
				throw new IllegalArgumentException("nom doit avoir au moins 1 caractère");
			}
		}
		
	}

	@Override
	public boolean annuler(int creneau) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String getRendezVous(int creneau) throws LibreException {
		// TODO Auto-generated method stub
		return null;
	}

}
