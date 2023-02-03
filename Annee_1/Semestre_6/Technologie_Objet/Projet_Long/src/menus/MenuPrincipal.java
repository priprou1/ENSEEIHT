package src.menus;

import javax.imageio.*;
import javax.swing.*;

import src.menus.boutons.Bouton_Jouer;
import src.menus.boutons.Bouton_Parametre;
import src.menus.boutons.Bouton_Quitter;

import java.awt.*;
import java.awt.event.*;
import java.io.*;

@SuppressWarnings("serial")
public class MenuPrincipal extends Menu {
	
	private JFrame fenetre;	
	private Bouton_Jouer jouer;
	private Bouton_Parametre parametre;
	private Bouton_Quitter quitter;
	
	
	public MenuPrincipal(JFrame fenetre) {
		super(fenetre);
		this.fenetre = fenetre;
		this.setBounds(0, 0, this.fenetre.getWidth(), this.fenetre.getHeight()); 
		this.setLayout(null);
		
		this.jouer = new Bouton_Jouer(this.fenetre, this);
		this.quitter = new Bouton_Quitter(this.fenetre);
		this.parametre = new Bouton_Parametre(this.fenetre, this);	
				
		this.add(this.jouer);
		this.add(this.parametre);
		this.add(this.quitter);
		
		this.fenetre.getContentPane().add(this);
		this.fenetre.addComponentListener((ComponentListener) this);
		this.effacer();
		
	}
	
	public void paintComponent(Graphics g)
    {
        //Chargement de l"image de fond
        try {
        	super.paintComponent(g);
            Image imgprinc = ImageIO.read(new File("src/Images/Fond_Menu_Principal.png"));
            g.drawImage(imgprinc, 0, 0, this.fenetre.getWidth(), this.fenetre.getHeight(), this.fenetre);
        } catch (IOException e) {
            System.out.println("Erreur image de fond principal : " + e.getMessage());
        }
    }
	
	@Override
	public void componentResized(ComponentEvent e) {
		
		this.setBounds(0, 0, this.fenetre.getWidth(), this.fenetre.getHeight()); 
		
		int largeur = 460*this.getWidth()/960;
		int hauteur = 87*this.getHeight()/540;
		int align_gauche = 250*this.getWidth()/960;
		
		this.jouer.setBounds(align_gauche, 100*this.getHeight()/540, largeur, hauteur);
		this.parametre.setBounds(align_gauche, 236*this.getHeight()/540, largeur, hauteur);
		this.quitter.setBounds(align_gauche, 383*this.getHeight()/540, largeur, hauteur);
    }	
}
