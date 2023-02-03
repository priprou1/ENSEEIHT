package src.menus.boutons;

import java.io.FileNotFoundException;
import java.util.Map;
import javax.swing.*;

import src.PartieCourante;
import src.Structure;
import src.carte.*;
import src.menus.*;
import src.routes.*;
import src.sauvegarde.*;
import src.batiments.*;

@SuppressWarnings("serial")
public class Bouton_ContinuerPartie extends Boutons {
	
	private JFrame fenetre;
	private MenuRepriseSauvegarde menuRepriseSauvegarde;
	private PartieCourante continuePartie;
	private static JList<String> listeVille;
	
	
	public Bouton_ContinuerPartie(JFrame fenetre, JList<String> listeVille, MenuRepriseSauvegarde menuRepriseSauvegarde) {
		super();
		this.fenetre = fenetre;
		this.menuRepriseSauvegarde = menuRepriseSauvegarde;
		Bouton_ContinuerPartie.listeVille = listeVille;
		//this.setText(this.getNom());
		
		this.setOpaque(false);
		this.setContentAreaFilled(false);
		
		this.addActionListener(this);
	}

	@Override
	public void executer() {
		if (!Bouton_ContinuerPartie.listeVille.isSelectionEmpty()) {
			try {
				this.continuePartie = Sauvegarder.reprendreSauvegarde(Bouton_ContinuerPartie.listeVille.getSelectedValue());
				Bouton_Save.setPartieCourante(continuePartie);
				this.menuRepriseSauvegarde.effacer();
				continuePartie.afficher(this.fenetre);
				miseAJourAffichage(continuePartie);

			} catch (FileNotFoundException e) {
				JOptionPane.showMessageDialog(this.fenetre.getContentPane(), 
				"Le fichier de sauvegarde de cette partie n'a pas été trouvé");
			}
		} else {
			JOptionPane.showMessageDialog(this.fenetre.getContentPane(), 
				"Merci de sélectionner une ville pour pouvoir reprendre une partie");
		}
	}

	@Override
	public String getNom() {
		return "Continuer la partie";
	}

	public static void setListeVille( JList<String> listeVille) {
        Bouton_ContinuerPartie.listeVille = listeVille;
    }

	private void miseAJourAffichage(PartieCourante continuerPartie) {
		Map<Case, Structure> listeStructure = continuePartie.getCarte().getListeStructure();
		Object[] valeurStructure = listeStructure.values().toArray();
		for (int i = 0; i < valeurStructure.length; i++) {
			((Structure) valeurStructure[i]).setNomStructure();
			String nom = ((Structure) valeurStructure[i]).getNomStructure();
			System.out.println(nom);
			if (nom.equals("RouteTrottoir")) {
				((RouteTrottoir) valeurStructure[i]).setImage();
			} else {
				((Structure) valeurStructure[i]).setImageBatiment();
				int largeur = ((Batiment) valeurStructure[i]).getParcelles()[0].largeur();
				((Structure) valeurStructure[i]).setTailleStructure(largeur);
			}
		}
	}
}
