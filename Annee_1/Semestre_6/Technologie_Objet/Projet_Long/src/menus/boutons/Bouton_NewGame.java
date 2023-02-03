package src.menus.boutons;

import javax.swing.*;
import src.menus.Menu;
import src.menus.fenetre_nomPartie.*;

@SuppressWarnings("serial")
public class Bouton_NewGame extends Boutons {
	
	private JFrame fenetre;
	private Menu menu;

	public Bouton_NewGame(JFrame fenetre, Menu menulancement) {
		super();
		this.fenetre = fenetre;
		this.menu = menulancement;
		//this.setText(this.getNom());
		//this.setFont(new Font("Arial", Font.BOLD, 30));
		//this.setForeground(Color.BLACK);
		
		this.setOpaque(false);
		this.setContentAreaFilled(false);
		
		this.addActionListener(this);
		
	}
	
	@Override
	public void executer() {
		new Fenetre_Nom(this.fenetre, this.menu);
	}

	@Override
	public String getNom() {
		return "Nouvelle Partie";
	}

}
