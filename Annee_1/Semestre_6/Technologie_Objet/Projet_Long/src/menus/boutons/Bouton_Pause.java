package src.menus.boutons;

import javax.swing.*;

import src.PartieCourante;
import src.affichagePartie.*;
import src.menus.MenuPause;

@SuppressWarnings("serial")
public class Bouton_Pause extends Boutons {

	private JFrame fenetre;
	private MenuPause menu;
    private AffichagePartie partie;
	
	public Bouton_Pause(JFrame fenetre, AffichagePartie partie) {
		super();
		this.fenetre = fenetre;
        this.menu = new MenuPause(this.fenetre, partie);
		this.partie = partie;
		
		this.setOpaque(false);
		this.setContentAreaFilled(false);
		
		this.addActionListener(this);
		
		this.setVisible(true);
	}
	
	@Override
	public void executer() {
		this.partie.effacer();
		PartieCourante.setPause(true);
		this.menu.afficher();
	}

	@Override
	public String getNom() {
		return "Reprendre";
	}	
}
