package src.menus;

import java.awt.*;
import java.awt.event.*;
import java.io.*;
import javax.imageio.*;
import javax.swing.*;

import src.menus.boutons.Bouton_Racourcis;
import src.menus.boutons.Bouton_Resolution;
import src.menus.boutons.Bouton_Retour;
import src.menus.boutons.Boutons;
import src.menus.boutons.Commande_Volume;

@SuppressWarnings("serial")
public class MenuParametre extends Menu {
	
	private JFrame fenetre;	
	private Menu menu;
	private Boutons retour, raccourcis;
	private Commande_Volume volume;
	private Bouton_Resolution resolution1, resolution2, resolution3;
	
	public MenuParametre(JFrame fenetre, Menu menu) {
		super(fenetre);
		this.fenetre = fenetre;
		this.menu = menu;	
		
		this.setBounds(0, 0, this.fenetre.getWidth(), this.fenetre.getHeight());
		this.setLayout(null);
		
		retour = new Bouton_Retour(this.menu, this);
		raccourcis = new Bouton_Racourcis(this.fenetre);
		volume = new Commande_Volume();
		resolution1 = new Bouton_Resolution(this.fenetre, 960, 540);
		resolution2 = new Bouton_Resolution(this.fenetre, 1440, 810);
		resolution3 = new Bouton_Resolution(this.fenetre, 1920, 1080);
		
		this.add(retour);
		this.add(this.raccourcis);
		this.add(this.volume);
		this.add(this.resolution1);
		this.add(this.resolution2);
		this.add(this.resolution3);
		
		this.fenetre.getContentPane().add(this);
		this.fenetre.addComponentListener(this);
		this.setVisible(false);

	}
	
	@Override
	public void componentResized(ComponentEvent e) {
		
		this.setBounds(0, 0, this.fenetre.getWidth(), this.fenetre.getHeight()); 
		
		int largeur = 460*this.getWidth()/960;
		int hauteur = 87*this.getHeight()/540;
		int align_gauche = 279*this.getWidth()/960;
		
		this.raccourcis.setBounds(align_gauche, 377*this.getHeight()/540, largeur, hauteur);
		this.volume.setBounds(575*this.getWidth()/960, 107*this.getHeight()/540, 2*largeur/3, 2*hauteur/3);
		this.retour.setBounds(750*this.getWidth()/960, 16*this.getHeight()/540, 
				198*this.getWidth()/960, 38*this.getHeight()/540);    
		
		this.resolution1.setBounds(570*this.getWidth()/960,  235*this.getHeight()/540, hauteur, hauteur);
		this.resolution2.setBounds(690*this.getWidth()/960,  235*this.getHeight()/540, hauteur, hauteur);
		this.resolution3.setBounds(810*this.getWidth()/960,  235*this.getHeight()/540, hauteur, hauteur);
	}
	
	public void paintComponent(Graphics g)
    {
        //Chargement de l"image de fond
        try {
        	super.paintComponent(g);
            Image imgparam = ImageIO.read(new File("src/Images/Fond_Menu_Parametre.png"));
            g.drawImage(imgparam, 0, 0, this.getWidth(), this.getHeight(), this);
        } catch (IOException e) {
            System.out.println("Erreur image de fond paramètre : " + e.getMessage());
        }
    }
}
