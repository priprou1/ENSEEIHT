package src.menus.boutons;

import javax.swing.JFrame;
import javax.swing.JList;
import javax.swing.JOptionPane;

import src.menus.MenuRepriseSauvegarde;
import src.sauvegarde.Sauvegarder;

@SuppressWarnings("serial")
public class Bouton_DetruireVille extends Boutons {

    private JFrame fenetre;
    private MenuRepriseSauvegarde menuChargement;
	private static JList<String> listeVille;

    public Bouton_DetruireVille(JFrame fenetre, JList<String> listeVille, MenuRepriseSauvegarde menuChargement) {
		super();
		this.fenetre = fenetre;
        this.menuChargement = menuChargement;
		Bouton_DetruireVille.listeVille = listeVille;
		
		this.setOpaque(false);
		this.setContentAreaFilled(false);
		
		this.addActionListener(this);
	}

    @Override
    public void executer() {
        if (!Bouton_DetruireVille.listeVille.isSelectionEmpty()) {
            Sauvegarder.detruireVilleSauvegarde(Bouton_DetruireVille.listeVille.getSelectedValue());
            this.menuChargement.effacer();
            this.menuChargement = new MenuRepriseSauvegarde(this.fenetre, this.menuChargement.getMenuLancement());
            this.fenetre.getContentPane().add(this.menuChargement);
            this.menuChargement.afficher();
            /*JOptionPane.showMessageDialog(this.fenetre.getContentPane(), 
				"La ville a bien été détruite");*/
        } else {
            JOptionPane.showMessageDialog(this.fenetre.getContentPane(), 
            "Merci de sélectionner la ville à détruire");
        }
    }

    @Override
    public String getNom() {
        return "Détruire la ville";
    }
    
    public static void setListeVille( JList<String> listeVille) {
        Bouton_DetruireVille.listeVille = listeVille;
    }
}
