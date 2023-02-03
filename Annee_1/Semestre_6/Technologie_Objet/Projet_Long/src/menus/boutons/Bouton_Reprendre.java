package src.menus.boutons;

import src.PartieCourante;
import src.affichagePartie.*;
import src.menus.Menu;

@SuppressWarnings("serial")
public class Bouton_Reprendre extends Boutons {

	private Menu menu;
	private AffichagePartie partie;

	public Bouton_Reprendre(Menu menu, AffichagePartie partie) {
		super();
		this.menu = menu;
		this.partie = partie;
        //this.setText(this.getNom());
		//this.setFont(new Font("Arial", Font.BOLD, 30));
		//this.setForeground(Color.BLACK);
		
		this.setOpaque(false);
		this.setContentAreaFilled(false);
		
		this.addActionListener(this);
		
		this.setVisible(true);
	}
	
	@Override
	public void executer() {
		this.menu.effacer();
		PartieCourante.setPause(false);
		this.partie.afficher();
	}

	@Override
	public String getNom() {
		return "Reprendre";
	}	
}
