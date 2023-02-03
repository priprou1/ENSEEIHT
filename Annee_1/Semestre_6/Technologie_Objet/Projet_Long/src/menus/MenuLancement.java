package src.menus;

import java.awt.*;
import java.awt.event.*;
import java.io.*;
import javax.imageio.*;
import javax.swing.*;

import src.menus.boutons.Bouton_LoadGame;
import src.menus.boutons.Bouton_NewGame;
import src.menus.boutons.Bouton_Retour;
import src.menus.boutons.Bouton_Scenario;

@SuppressWarnings("serial")
public class MenuLancement extends Menu {

	private JFrame fenetre;
	private MenuPrincipal menu_princ;
	private Bouton_Retour retour;
	private Bouton_NewGame newGame;
	private Bouton_LoadGame loadGame;
	private Bouton_Scenario scenarios;
	
	public MenuLancement(JFrame fenetre, MenuPrincipal menu_princ) {
		super(fenetre);
		this.fenetre = fenetre;
		this.menu_princ = menu_princ;
		
		this.setBounds(0, 0, this.fenetre.getWidth(), this.fenetre.getHeight());
		this.setLayout(null);
		
		this.retour = new Bouton_Retour(this.menu_princ, this);
		this.newGame = new Bouton_NewGame(this.fenetre, this);
		this.loadGame = new Bouton_LoadGame(this.fenetre, this);
		this.scenarios = new Bouton_Scenario(this.fenetre);
		
		this.add(this.newGame);
		this.add(this.loadGame);
		this.add(this.scenarios);
		this.add(this.retour);
		
		this.fenetre.getContentPane().add(this);
		this.fenetre.addComponentListener(this);
		super.effacer();
	}
	
	
	@Override
	public void componentResized(ComponentEvent e) {
		this.setBounds(0, 0, this.fenetre.getWidth(), this.fenetre.getHeight());
		
		int largeur = 460*this.getWidth()/960;
		int hauteur = 87*this.getHeight()/540;
		int align_gauche = 250*this.getWidth()/960;
		
		this.newGame.setBounds(align_gauche, 100*this.getHeight()/540, largeur, hauteur);
		this.loadGame.setBounds(align_gauche, 236*this.getHeight()/540, largeur, hauteur);
		this.scenarios.setBounds(align_gauche, 383*this.getHeight()/540, largeur, hauteur);
		
		this.retour.setBounds(750*this.getWidth()/960, 16*this.getHeight()/540, 
				198*this.getWidth()/960, 38*this.getHeight()/540);
	}

	public void paintComponent(Graphics g)
    {
        //Chargement de l"image de fond
        try {
        	super.paintComponent(g);
            Image imgplay = ImageIO.read(new File("src/Images/Fond_Menu_Lancement.png"));
            g.drawImage(imgplay, 0, 0, this.fenetre.getWidth(), this.fenetre.getHeight(), this.fenetre);
        } catch (IOException e) {
            System.out.println("Erreur image de fond lancement : " + e.getMessage());
        }
    }
}
