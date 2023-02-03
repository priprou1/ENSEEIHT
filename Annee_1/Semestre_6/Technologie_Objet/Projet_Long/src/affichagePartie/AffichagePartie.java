package src.affichagePartie;

import java.awt.event.*;
import javax.swing.*;
import src.carte.Carte;
import src.Finances;

@SuppressWarnings("serial")
public class AffichagePartie extends JPanel implements ComponentListener {

    private JFrame fenetre;
    private BandeStatistiques statistiques;
    public static AffichageCarte affichageCarte;
    private BandeAction choixAction;
    private Finances finances;

    public AffichagePartie(JFrame fenetre, Carte carte, Finances finances) {
        super();
        this.fenetre = fenetre;

		this.setLayout(null);
		
		this.finances = finances;
		
        this.statistiques = new BandeStatistiques(this.fenetre, this);
        affichageCarte = new AffichageCarte(this.fenetre, this, carte, this.finances);
        this.choixAction = new BandeAction(this.fenetre);

        this.add(this.statistiques);
        this.add(affichageCarte);
        this.add(this.choixAction);

        this.fenetre.getContentPane().add(this);
		this.fenetre.addComponentListener((ComponentListener) this);
		
		//Thread chronoEcran = new Thread(new Chrono());
		//chronoEcran.start();
		
        updatePosition();
		this.setVisible(true);
		
    }

    public void effacer() {
        this.setVisible(false);
        affichageCarte.arreterClavier();
    }
 
    public void afficher() {
        this.setVisible(true);
        affichageCarte.relancerClavier();
    }
    

    private void updatePosition() {
        this.setBounds(0, 0, this.fenetre.getWidth(), this.fenetre.getHeight()); 

        int hauteurBande =  3*this.getHeight()/40;
    
        this.statistiques.setBounds(0, 0, this.getWidth(), hauteurBande);
        this.statistiques.updatePosition();
        
        affichageCarte.setBounds(0, hauteurBande, this.getWidth(), this.getHeight() - 3*hauteurBande);

        choixAction.setBounds(0, this.getHeight() - 2*hauteurBande, this.getWidth(), 2*hauteurBande);
        choixAction.updatePosition();
    }

    @Override
	public void componentResized(ComponentEvent e){
        this.updatePosition();
    }
	
	@Override
	public void componentHidden(ComponentEvent arg0) {
	}

	@Override
	public void componentMoved(ComponentEvent arg0) {
	}

	@Override
	public void componentShown(ComponentEvent arg0) {
	}
}
