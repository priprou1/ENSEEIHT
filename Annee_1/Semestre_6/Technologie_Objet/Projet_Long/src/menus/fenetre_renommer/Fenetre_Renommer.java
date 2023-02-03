package src.menus.fenetre_renommer;

import javax.swing.*;
import src.menus.*;

@SuppressWarnings("serial")
public class Fenetre_Renommer extends JFrame {
    private JFrame fenetrePrincipale;
    private NouveauNomPartie fond;
    private Menu menuChargement;

    public Fenetre_Renommer(JFrame fenetrePrincipale, Menu menuChargement, String ancienNom) {
        super();
			
        this.fenetrePrincipale = fenetrePrincipale;
        this.menuChargement = menuChargement;

		this.setTitle("Nouvelle partie");
		this.setSize(720, 405);
		this.setLocationRelativeTo(null);
		this.setLayout(null);
        this.setResizable(false);

        this.fond = new NouveauNomPartie((MenuRepriseSauvegarde) this.menuChargement, this.fenetrePrincipale, this, ancienNom);
        this.fond.setBounds(0, 0, this.getWidth(), this.getHeight());
        this.fond.updatePosition();

        this.getContentPane().add(this.fond);
        this.setVisible(true);
    }
}
