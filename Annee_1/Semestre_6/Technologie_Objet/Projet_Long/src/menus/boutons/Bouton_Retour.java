package src.menus.boutons;

import src.Musique;
import src.menus.Menu;
import src.menus.MenuParametre;

@SuppressWarnings("serial")
public class Bouton_Retour extends Boutons {

	private Menu menu_avant, menu_courant;
	
	public Bouton_Retour(Menu menu_avant, Menu menu_courant) {
		super();
		this.menu_avant = menu_avant;
		this.menu_courant = menu_courant;
		
		//this.setText(this.getNom());
		
		this.setOpaque(false);
		this.setContentAreaFilled(false);

		
		this.addActionListener(this);
		
		this.setVisible(true);
		
	}
	
	
	@Override
	public void executer() {
		if (Bouton_Save.getPartieCourante() != null & !(this.menu_courant instanceof MenuParametre)) {
			Musique.setMusiquePartie(false);
			Bouton_Save.getPartieCourante().stopTimer();
		}
		this.menu_courant.effacer();
		this.menu_avant.afficher();		
	}

	@Override
	public String getNom() {
		return "Retour";
	}

}
