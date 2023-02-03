package src.menus.boutons;

import javax.swing.*;

import src.menus.MenuLancement;
import src.menus.MenuPrincipal;

@SuppressWarnings("serial")
public class Bouton_Jouer extends Boutons {

	private JFrame fenetre;
	private MenuPrincipal menu;
	private MenuLancement menu_lanc;
	
	public Bouton_Jouer(JFrame fenetre, MenuPrincipal menu) {
		super();
		this.fenetre = fenetre;
		this.menu = menu;
		this.menu_lanc = new MenuLancement(this.fenetre, this.menu);
		//this.setText(this.getNom());
		//this.setFont(new Font("Arial", Font.BOLD, 30));
		//this.setForeground(Color.BLACK);
		
		this.setOpaque(false);
		this.setContentAreaFilled(false);
		
		this.addActionListener(this);
		
	}
	
	@Override
	public void executer() {
		this.menu.effacer();
		this.menu_lanc.afficher();
	}

	@Override
	public String getNom() {
		return "Jouer";
	}	
}
