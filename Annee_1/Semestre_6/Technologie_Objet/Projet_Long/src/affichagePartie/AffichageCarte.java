package src.affichagePartie;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.event.*;

import javax.swing.*;

import src.carte.*;
import src.Structure;
import src.batiments.*;
import src.routes.*;

import src.Finances;

@SuppressWarnings("serial")
public class AffichageCarte extends JPanel implements ComponentListener, KeyListener, MouseListener {

    private JFrame fenetre;

    private ImageIcon icoHerbe;
    private Image imgHerbe;
    
    private Carte carte;
    
    private Finances finances;
    
    private int largeur;
    private int hauteur;
    
    private int dx;
    private int dy;
    
    private int xFond = -48;
    private int yFond = -48;

    public AffichageCarte(JFrame fenetre, AffichagePartie partie, Carte carte, Finances finances) {
        super();
        this.fenetre = fenetre;
        
		this.carte = carte;
        this.largeur = Carte.getLargeur();
        this.hauteur = Carte.getHauteur();
        
        this.finances = finances;
        
        this.icoHerbe = new ImageIcon("src/Images/herbeBord52.png");
		this.imgHerbe = this.icoHerbe.getImage();
		
        this.fenetre.getContentPane().add(this);
		this.fenetre.addComponentListener((ComponentListener) this);
		
		this.setFocusable(true);
		this.requestFocusInWindow();
		this.addKeyListener(this);
		this.addMouseListener(this);
		
		Thread chronoEcran = new Thread(new Chrono());
		chronoEcran.start();
		
		this.setVisible(true);
    }
    
    public void arreterClavier() {
    	this.setFocusable(false);
    }
    
    public void relancerClavier() {
        this.setFocusable(true);
		this.requestFocusInWindow();

    }

    public void pause() {
        this.setVisible(false);
    }
    
    public void setDx(int dx) {
		this.dx = dx;
	}
	
	public void setDy(int dy) {
		this.dy = dy;
	}
	
	public int getDx() {
		return this.dx;
	}
	
	public int getDy() {
		return this.dy;
	}
	
	public void deplacementFond() {
		this.xFond += this.dx;
		this.yFond += this.dy;
	}
 
    public void paintComponent(Graphics g) {
		
		try {
        	super.paintComponent(g);
        	
        	this.deplacementFond();
    		for (int i = 1; i <= this.largeur; i++) {
    			for (int j = 1; j <= this.hauteur; j++) {
    				g.drawImage(this.imgHerbe, this.xFond + i*Structure.longueurCase, this.yFond + j*Structure.longueurCase, null);
    			}
    		}
    		
        	this.carte.afficher(g, xFond, yFond);
        	
        	//g.drawImage(this.imgHerbe, 0, 0, null);
        	
        } catch (Exception e) {
            System.out.println("Erreur affichageCarte (paintComponent): " + e.getMessage());
        }
	}

    void updatePosition() {
    }

    @Override
	public void componentResized(ComponentEvent e){
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
	

	// Gestion du clavier
	public final static int deplacementElementaire = 26;
	
	@Override
	public void keyPressed(KeyEvent e) {
		

		if(e.getKeyCode() == KeyEvent.VK_RIGHT) {
			if (this.xFond > -52*Carte.getLargeur() + fenetre.getWidth() - 100) {
				this.setDx(-deplacementElementaire);
			}
		} else if (e.getKeyCode() == KeyEvent.VK_LEFT) {
			if (this.xFond < -52) {
				this.setDx(deplacementElementaire);
			}
		} else if (e.getKeyCode() == KeyEvent.VK_UP) {
			if (this.yFond < -52) {
				this.setDy(deplacementElementaire);
			}
		} else if (e.getKeyCode() == KeyEvent.VK_DOWN) {
			if (this.yFond > -52*Carte.getHauteur() + fenetre.getHeight() - 300) {
				this.setDy(-deplacementElementaire);
			}
		}

		//this.repaint();
		
	}

	@Override
	public void keyReleased(KeyEvent arg0) {
		this.setDx(0);
		this.setDy(0);
	}

	@Override
	public void keyTyped(KeyEvent arg0) {
		
	}
	
	
	//gestion de la souris
	
	public void construireBatiment(String nomBatiment, int taille, int niveau, int coordX, int coordY) {
		int coordX2 = coordX + taille - 1;
		int coordY2 = coordY + taille - 1;
		
		Case caseCoinHautGauche = this.carte.getCase(coordX, coordY);
		Case caseCoinBasDroite = this.carte.getCase(coordX2, coordY2);
		
		Parcelle[] parcelleBatiment = new Parcelle[1];
		parcelleBatiment[0] = new Parcelle(caseCoinHautGauche, caseCoinBasDroite, this.carte);
		
		int depense = 0;
		
		try {
			switch (nomBatiment) {
			
			case "Mairie":
				Mairie nouvelleMairie = new Mairie(caseCoinHautGauche, 0, this.carte, parcelleBatiment, 0, 0, niveau);
				nouvelleMairie.setTailleStructure(taille);
				this.carte.construire(nouvelleMairie);
				depense = nouvelleMairie.getCoutConstruction();
				break;
			
			case "Habitation":
				Habitation nouvelleHabitation = new Habitation(this.carte, caseCoinHautGauche, parcelleBatiment, niveau);
				nouvelleHabitation.setTailleStructure(taille);
				this.carte.construire(nouvelleHabitation);
				depense = nouvelleHabitation.getCoutConstruction();
				break;
			
			case "Commerce":
				Commerce nouveauCommerce = new Commerce(nomBatiment, caseCoinHautGauche, this.carte, parcelleBatiment, niveau);
				nouveauCommerce.setTailleStructure(taille);
				this.carte.construire(nouveauCommerce);
				depense = nouveauCommerce.getCoutConstruction();
				break;
			
			case "Industrie":
				int[] accesIndustrie = new int[0]; 
				Industrie nouvelleIndustrie = new Industrie(caseCoinHautGauche, this.carte, parcelleBatiment, accesIndustrie, niveau);
				nouvelleIndustrie.setTailleStructure(taille);
				this.carte.construire(nouvelleIndustrie);
				depense = nouvelleIndustrie.getCoutConstruction();
				break;
				
			case "Usine":
				int[] accesUsine = new int[0];
				Usine nouvelleUsine = new Usine(caseCoinHautGauche, this.carte, parcelleBatiment, accesUsine, niveau);
				nouvelleUsine.setTailleStructure(taille);
				this.carte.construire(nouvelleUsine);
				depense = nouvelleUsine.getCoutConstruction();
				break;
			
			case "Pompiers":
				int[] accesCaserne = new int[0];
				CasernePompier nouvelleCasernePompier= new CasernePompier(caseCoinHautGauche, this.carte, parcelleBatiment, accesCaserne, niveau);
				nouvelleCasernePompier.setTailleStructure(taille);
				this.carte.construire(nouvelleCasernePompier);
				depense = nouvelleCasernePompier.getCoutConstruction();
				break;
			
			case "Hôpital":
				int[] accesHopital = new int[0];
				Hopital nouvelHopital = new Hopital(caseCoinHautGauche, this.carte, parcelleBatiment, accesHopital, niveau);
				nouvelHopital.setTailleStructure(taille);
				this.carte.construire(nouvelHopital);
				depense = nouvelHopital.getCoutConstruction();
				break;
				
			case "Pole-Emploi":
				PoleEmploi nouveauPoleEmploi = new PoleEmploi(caseCoinHautGauche, 0, this.carte, parcelleBatiment, 0, 0, niveau);
				nouveauPoleEmploi.setTailleStructure(taille);
				this.carte.construire(nouveauPoleEmploi);
				depense = nouveauPoleEmploi.getCoutConstruction();
				break;
			
			case "Ecole":
				Ecole nouvelleEcole = new Ecole(nomBatiment, caseCoinHautGauche, this.carte, parcelleBatiment, niveau);
				nouvelleEcole.setTailleStructure(taille);
				this.carte.construire(nouvelleEcole);
				depense = nouvelleEcole.getCoutConstruction();
				break;
			
			case "Hotel":
				Hotel nouvelHotel = new Hotel(nomBatiment, caseCoinHautGauche, this.carte, parcelleBatiment, niveau);
				nouvelHotel.setTailleStructure(taille);
				this.carte.construire(nouvelHotel);
				depense = nouvelHotel.getCoutConstruction();
				break;
				
			case "Police":
				int[] accesPolice = new int[0];
				Police nouvellePolice = new Police(caseCoinHautGauche, this.carte, parcelleBatiment, accesPolice, 0, niveau);
				nouvellePolice.setTailleStructure(taille);
				this.carte.construire(nouvellePolice);
				depense = nouvellePolice.getCoutConstruction();
				break;
			}
			
			this.finances.depenser(depense);
					
		} catch (CaseOccupeeException exception) {
			System.out.println("Vous ne pouvez pas placer de batiments ici, la case est occupée.");
		}
	}
	
	public void construireRoute(int niveau, int rotation, int coordX, int coordY) {
		
		Case caseRoute = this.carte.getCase(coordX, coordY);
		Cardinal cardinal = ConversionCardinal.convertirEntier(niveau, rotation+1);
		RouteTrottoir nouvelleRoute = new RouteTrottoir(caseRoute, cardinal);
		try {
			this.carte.construire(nouvelleRoute);
			nouvelleRoute.setImage();
		} catch (CaseOccupeeException exception) {
			System.out.println(exception.getMessage());
		}
	}
		
	@Override
	public void mouseClicked(MouseEvent e) {
		double mouseX = e.getX();
        double mouseY = e.getY();
		//System.out.println(mouseX + " " + mouseY + " xFond:" + this.xFond + " yFond" + this.yFond);
        
		int coordCaseX = (int) Math.ceil((mouseX - Structure.longueurCase - this.xFond)/Structure.longueurCase);
		int coordCaseY = (int) Math.ceil((mouseY - Structure.longueurCase - this.yFond)/Structure.longueurCase);
		//System.out.println(coordCaseX + " " + coordCaseY);
		
		if ((coordCaseX >= 1 && coordCaseX <= Carte.getLargeur()) && (coordCaseY >= 1 && coordCaseY <= Carte.getHauteur())) {
			if (SelectionAction.getDestruire()) {
				Structure structureADetruire = this.carte.selectionner(coordCaseX, coordCaseY);
				if (structureADetruire != null) {
					carte.detruire(structureADetruire);
				}
			} else {
				try {
					String nomStructureAConstruire = SelectionAction.getNomBatiment();

					if (nomStructureAConstruire.equalsIgnoreCase("routes")) {
						int niveauStructure = SelectionAction.getNiveau();
						int rotationStructure = SelectionAction.getRotation();
						construireRoute(niveauStructure, rotationStructure, coordCaseX, coordCaseY);
					} else {
						int tailleStructure = SelectionAction.getParcelles();
						int niveauStructure = SelectionAction.getNiveau();
						construireBatiment(nomStructureAConstruire, tailleStructure, niveauStructure, coordCaseX, coordCaseY);
					}
	
				} catch (ActionException exception) {
					System.out.println(exception.getMessage());
				}
			}
		}
	}

	@Override
	public void mouseEntered(MouseEvent arg0) {
	}

	@Override
	public void mouseExited(MouseEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void mousePressed(MouseEvent arg0) {

	}

	@Override
	public void mouseReleased(MouseEvent arg0) {
		
	}

	
}
