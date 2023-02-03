package src.menus.boutons;

import javax.swing.*;

import src.menus.MenuLancement;
import src.menus.MenuRepriseSauvegarde;

@SuppressWarnings("serial")
public class Bouton_LoadGame extends Boutons {
	
	private MenuLancement menu_lancement;
	private MenuRepriseSauvegarde menu_reprise;
	private JFrame fenetre;
	
	public Bouton_LoadGame(JFrame fenetre, MenuLancement menu_lancement) {
		super();
		this.menu_lancement = menu_lancement;
		this.menu_reprise = new MenuRepriseSauvegarde(fenetre, menu_lancement);
		this.fenetre = fenetre;
		
		//this.setText(this.getNom());
		//this.setFont(new Font("Arial", Font.BOLD, 30));
		//this.setForeground(Color.BLACK);
		
		this.setOpaque(false);
		this.setContentAreaFilled(false);
		
		this.addActionListener(this);
		
	}
	
	@Override
	public void executer() {
		this.menu_lancement.effacer();
		this.menu_reprise = new MenuRepriseSauvegarde(fenetre, menu_lancement);
		this.menu_reprise.afficher();
	}

	@Override
	public String getNom() {
		return "Charger une partie";
	}
}
