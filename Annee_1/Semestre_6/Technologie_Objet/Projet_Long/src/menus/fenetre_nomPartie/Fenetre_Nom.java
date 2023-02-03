package src.menus.fenetre_nomPartie;

import javax.swing.*;
import src.menus.*;

@SuppressWarnings("serial")
public class Fenetre_Nom extends JFrame {

    private JFrame fenetrePrincipale;
    private NomPartie fond;
    private Menu menuLancement;

    public Fenetre_Nom(JFrame fenetrePrincipale, Menu menuLancement) {
        super();
			
        this.fenetrePrincipale = fenetrePrincipale;
        this.menuLancement = menuLancement;

		this.setTitle("Nouvelle partie");
		this.setSize(720, 405);
		this.setLocationRelativeTo(null);
		this.setLayout(null);
        this.setResizable(false);

        this.fond = new NomPartie(this.menuLancement, this.fenetrePrincipale, this);
        this.fond.setBounds(0, 0, this.getWidth(), this.getHeight());
        this.fond.updatePosition();

        this.getContentPane().add(this.fond);
        this.setVisible(true);
    }
}
