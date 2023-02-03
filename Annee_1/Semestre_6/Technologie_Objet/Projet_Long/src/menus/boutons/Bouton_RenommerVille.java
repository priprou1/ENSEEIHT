package src.menus.boutons;

import javax.swing.JFrame;
import javax.swing.JList;
import javax.swing.JOptionPane;

import src.menus.MenuRepriseSauvegarde;
import src.menus.fenetre_renommer.*;

@SuppressWarnings("serial")
public class Bouton_RenommerVille extends Boutons {

    private JFrame fenetre;
    private MenuRepriseSauvegarde menuRepriseSauvegarde;
	private static JList<String> listeVille;

    public Bouton_RenommerVille(JFrame fenetre, JList<String> listeVille, MenuRepriseSauvegarde menuRepriseSauvegarde) {
		super();
		this.fenetre = fenetre;
		this.menuRepriseSauvegarde = menuRepriseSauvegarde;
		Bouton_RenommerVille.listeVille = listeVille;
		
		this.setOpaque(false);
		this.setContentAreaFilled(false);
		
		this.addActionListener(this);
	}

    @Override
    public void executer() {
        if (!Bouton_RenommerVille.listeVille.isSelectionEmpty()) {
            new Fenetre_Renommer(this.fenetre, this.menuRepriseSauvegarde, Bouton_RenommerVille.listeVille.getSelectedValue());
        } else {
            JOptionPane.showMessageDialog(this.fenetre.getContentPane(), 
            "Merci de sélectionner la ville à renommer");
        }
    }

    @Override
    public String getNom() {
        return "Renommer la ville";
    }
    
    public static void setListeVille( JList<String> listeVille) {
        Bouton_RenommerVille.listeVille = listeVille;
    }
}
