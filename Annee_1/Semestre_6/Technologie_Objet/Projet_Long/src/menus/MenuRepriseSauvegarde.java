package src.menus;

import java.awt.*;
import java.awt.event.*;
import java.io.*;
import java.util.*;
import java.util.List;

import javax.imageio.*;
import javax.swing.*;


//import src.PartieCourante;
import src.menus.boutons.*;


@SuppressWarnings("serial")
public class MenuRepriseSauvegarde extends Menu {

	private JFrame fenetre;
	private MenuLancement menuLancement;
	private Bouton_Retour retour;
	private Bouton_ContinuerPartie continuerPartie;
	private static JList<String>  listeVille = null;
	//private JScrollPane listeVillescroll;
	//private JLabel label;
	private Bouton_RenommerVille renommerVille;
	private Bouton_DetruireVille detruireVille;
	
	@SuppressWarnings("unchecked")
	public MenuRepriseSauvegarde(JFrame fenetre, MenuLancement menuLancement) {
		super(fenetre);
		this.fenetre = fenetre;
		this.menuLancement = menuLancement;
		
		this.setBounds(0, 0, this.fenetre.getWidth(), this.fenetre.getHeight()); 
		this.setLayout(null);

		// Récupération de la liste des parties
		List<String> listeVilles;
		try {
		String pwd = System.getProperty("user.dir");
    	File dossier = new File(pwd + "/sauvegarde/");
    	if (!dossier.exists() || !dossier.isDirectory()) {
    		throw new FileNotFoundException();
    	}
        FileInputStream fis = new FileInputStream(pwd + "/sauvegarde/Villes_Sauvegardees.save");
        ObjectInputStream ois = new ObjectInputStream(fis);
        listeVilles = (List<String>) ois.readObject();
        ois.close();
		} catch (Exception e) {
			listeVilles = new ArrayList<String>();
		}
        String[] listeVilleArray = new String[listeVilles.size()];
        listeVilles.toArray(listeVilleArray);

		listeVille = new JList<String>(listeVilleArray);
		personalizeCityList(listeVille);

		// Création des boutons
		this.continuerPartie = new Bouton_ContinuerPartie(fenetre, MenuRepriseSauvegarde.listeVille, this);
		this.retour = new Bouton_Retour(this.menuLancement, this);
		this.renommerVille = new Bouton_RenommerVille(fenetre, MenuRepriseSauvegarde.listeVille, this);
		this.detruireVille = new Bouton_DetruireVille(fenetre, MenuRepriseSauvegarde.listeVille, this);

		this.add(MenuRepriseSauvegarde.listeVille);
		this.add(this.continuerPartie);
		this.add(this.retour);
		this.add(this.renommerVille);
		this.add(this.detruireVille);
		
		this.fenetre.getContentPane().add(this);
		this.fenetre.addComponentListener(this);
		super.effacer();
		
	}
	
	@Override
	public void componentResized(ComponentEvent e) {
		
		this.setBounds(0, 0, this.fenetre.getWidth(), this.fenetre.getHeight()); 
		
		int largeur = 460*this.getWidth()/960;
		int hauteur = 87*this.getHeight()/540;
		//int align_gauche = 250*this.getWidth()/960;

		MenuRepriseSauvegarde.listeVille.setBounds(25*this.getWidth()/960, 66*this.getHeight()/540, 420*this.getWidth()/960, 378*this.getHeight()/540 );
		this.continuerPartie.setBounds(473*this.getWidth()/960, 109*this.getHeight()/540, largeur, hauteur);
		this.retour.setBounds(750*this.getWidth()/960, 16*this.getHeight()/540, 
				198*this.getWidth()/960, 38*this.getHeight()/540);
		this.renommerVille.setBounds(503*this.getWidth()/960, 248*this.getHeight()/540, 401*this.getWidth()/960, 76*this.getHeight()/540 );
		this.detruireVille.setBounds(503*this.getWidth()/960, 349*this.getHeight()/540, 401*this.getWidth()/960, 76*this.getHeight()/540 );
	}

	public void paintComponent(Graphics g)
    {
        //Chargement de l"image de fond
        try {
        	super.paintComponent(g);
            Image imgplay = ImageIO.read(new File("src/Images/Fond_Menu_Chargement.png"));
            g.drawImage(imgplay, 0, 0, this.fenetre.getWidth(), this.fenetre.getHeight(), this.fenetre);
        } catch (IOException e) {
            System.out.println("Erreur image de fond lancement : " + e.getMessage());
        }
    }

	private static void personalizeCityList(JList<String> listeVille) {
		//listeVille.setVisibleRowCount(9);
		listeVille.setOpaque(false);
		listeVille.setBackground(new Color(0, 0, 0, 0));
		listeVille.setSelectionBackground(new Color(0, 0, 0, 125));
		listeVille.setSelectionForeground(Color.WHITE);
		Font listeVilleFont = new Font("Arial", Font.BOLD, 26);
		listeVille.setFont(listeVilleFont);
		listeVille.setForeground(Color.WHITE);
		//this.listeVillescroll = new JScrollPane(listeVille);
		//listeVillescroll.getViewport().setView(listeVille);

		// Centrer la liste
		DefaultListCellRenderer renderer = (DefaultListCellRenderer) listeVille.getCellRenderer();
		renderer.setHorizontalAlignment(SwingConstants.CENTER);
	}

	public static void setListeVille(List<String> listeVilles) {
		String[] listeVilleArray = new String[listeVilles.size()];
        listeVilles.toArray(listeVilleArray);
		listeVille = new JList<String>(listeVilleArray);
		personalizeCityList(listeVille);
		Bouton_DetruireVille.setListeVille(listeVille);
		Bouton_RenommerVille.setListeVille(listeVille);
		Bouton_ContinuerPartie.setListeVille(listeVille);
	}	

	public MenuLancement getMenuLancement() {
		return menuLancement;
	}
}
