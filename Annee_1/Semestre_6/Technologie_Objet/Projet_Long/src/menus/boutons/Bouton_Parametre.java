package src.menus.boutons;

import javax.swing.*;

import src.menus.Menu;
import src.menus.MenuParametre;

@SuppressWarnings("serial")
public class Bouton_Parametre extends Boutons {
	/**
	 * 
	 */
	private MenuParametre menu_param;
	private JFrame fenetre;
	private Menu menu;
	
	public Bouton_Parametre(JFrame fenetre, Menu menu) {
		super();
		this.fenetre = fenetre;
		this.menu = menu;
		this.menu_param = new MenuParametre(this.fenetre, this.menu);
		
		//this.setText(this.getNom());
		//this.setFont(new Font("Arial", Font.BOLD, 30));
		//this.setForeground(Color.WHITE);
		
		this.setOpaque(false);
		this.setContentAreaFilled(false);
		
		this.addActionListener(this);
	}
	
	@Override
	public void executer() {
		this.menu.effacer();
		this.menu_param.afficher();
	}

	@Override
	public String getNom() {
		return "Paramètres";
	}
}
