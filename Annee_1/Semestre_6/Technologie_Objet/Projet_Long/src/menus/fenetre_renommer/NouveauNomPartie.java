package src.menus.fenetre_renommer;

import src.menus.boutons.*;
import src.sauvegarde.Sauvegarder;
import src.menus.MenuRepriseSauvegarde;

import javax.swing.*;
import java.awt.*;
import java.io.*;
import javax.imageio.*;

@SuppressWarnings("serial")
public class NouveauNomPartie extends JPanel {

    private Bouton_ValiderRenommage renommer;
    private JFrame fenetreActuelle, fenetrePrincipale;
    private MenuRepriseSauvegarde menuChargement;
    private JTextField nom;
    private String ancienNom;

    public NouveauNomPartie(MenuRepriseSauvegarde menuChargement, JFrame fenetrePrincipale, JFrame fenetreActuelle, String ancienNom) {
        super();
        this.setLayout(null);

        this.menuChargement = menuChargement;
        this.fenetrePrincipale = fenetrePrincipale;
        this.fenetreActuelle = fenetreActuelle;
        this.ancienNom = ancienNom;
        this.renommer = new Bouton_ValiderRenommage(this);
        

        this.nom = new JTextField();
        this.nom.setEditable(true);       
        this.nom.setOpaque(false);
        this.nom.setForeground(Color.WHITE);
        this.nom.setFont(new Font("Arial", Font.BOLD, 30));

        this.add(this.renommer);
        this.add(this.nom);

        this.setVisible(true);

    }

    @SuppressWarnings("serial")
    public void updatePosition() {
        this.renommer.setBounds(500*this.getWidth()/1920, 265*this.getHeight()/1080, 
            922*this.getWidth()/1920, 175*this.getHeight()/1080);

        this.nom.setBounds(670*this.getWidth()/1920, 610*this.getHeight()/1080, 
            941*this.getWidth()/1920, 180*this.getHeight()/1080);

            //Mise de la taille de text
        this.nom.setFont(new Font(this.nom.getFont().getName(), Font.BOLD,  9*this.nom.getHeight()/10));
    }

    public void launch() {
        if(this.nom.getText().length() != 0 ) {
            try {
                Sauvegarder.renommerVilleSauvegarde(this.ancienNom, this.nom.getText());
                this.fenetreActuelle.dispose();
            } catch (FileNotFoundException e) {
                this.fenetreActuelle.dispose();
                JOptionPane.showMessageDialog(this.fenetrePrincipale.getContentPane(), 
				"Erreur lors du renommage de la ville");
            }
            this.menuChargement.effacer();
            this.menuChargement = new MenuRepriseSauvegarde(this.fenetrePrincipale, this.menuChargement.getMenuLancement());
            this.fenetrePrincipale.getContentPane().add(this.menuChargement);
            this.menuChargement.afficher();
            
        } else {
            JOptionPane.showMessageDialog(this.fenetreActuelle.getContentPane(), 
				"Merci de rentrer un nom pour la partie que vous voulez renommer");
	    }
    }

    public void paintComponent(Graphics g)
    {
        //Chargement de l"image de fond
        try {
        	super.paintComponent(g);
            Image imgprinc = ImageIO.read(new File("src/Images/Fond_Renommer_Partie.png"));
            g.drawImage(imgprinc, 0, 0, this.getWidth(), this.getHeight(), this);
        } catch (IOException e) {
            System.out.println("Erreur image de fond principal : " + e.getMessage());
        }
    }
}
