package src.carte;

import java.awt.Graphics;
import java.io.Serializable;
import java.util.*;
import src.Structure;

/**
 * Composant du jeu sur lequel on peut déposer, déplacer et détruire des structures (batiments ou routes).
 */
public class Carte implements Serializable{

	private static final long serialVersionUID = 4963324264468110678L;
	private List<Case> listeCases; /* liste des cases contenues dans la carte */
	private Map<Case, Structure> listeBatimentRoute; /* liste des batiments associés aux cases, 
			permet d'avoir accès plus rapidement aux batiments (surtout pour les grandes cartes) */
	private static int hauteur; /* Hauteur de la carte */
	private static int largeur; /* Largeur de la carte */

	public Carte(int largeur, int hauteur) {
		Carte.largeur = largeur;
		Carte.hauteur = hauteur;
		this.listeCases = new ArrayList<Case>();
		for (int i = 0; i < largeur; i++) {
			for (int j = 0; j < hauteur; j++) {
				this.listeCases.add(new Case(i, j));
			}
		}
		this.listeBatimentRoute = new TreeMap<Case, Structure>();
	}

	/**
	 * Accéder à la largeur de la carte.
	 * @return Largeur de la carte
	 */
	public static int getLargeur() {
		return Carte.largeur;
	}

	/**
	 * Accéder à la hauteur de la carte.
	 * @return hauteur de la carte
	 */
	public static int getHauteur() {
		return Carte.hauteur;
	}

	/**
	 * Permet de contruire une structure donnée en paramètre sur la carte.
	 * @param structure Structure à placer sur la carte
	 * @throws CaseOccupeeException Prévient que la case sur laquelle on veut construire est déjà occupée par une autre structure
	 */
	public void construire(Structure structure) throws CaseOccupeeException {
		Case[] casesOccupee = structure.getCases();
		// Vérifier que l'on peut construire la structure
		for (int i = 0; i < casesOccupee.length; i++) {
			if (casesOccupee[i].getOccupe()) {
				throw new CaseOccupeeException();
			}
		}
		// Construire la structure
		for (int i = 0; i < casesOccupee.length; i++) {
			casesOccupee[i].ajouterStructure(structure);
		}
		this.listeBatimentRoute.put(structure.getCoin(), structure);
	}

	/**
	 * Permet de détruire une structure donnée en paramètre sur la carte (ne fait rien si les cases sont vides).
	 * @param structure Structure à détruire
	 */
	public void detruire(Structure structure) {
		Case[] casesOccupee = structure.getCases();
		for (int i = 0; i < casesOccupee.length; i++) {
			casesOccupee[i].viderCase();
		}
		this.listeBatimentRoute.remove(structure.getCoin());
	}

	/**
	 * Selectionner une structure présente sur la carte.
	 * @param x position en abscisse de la structure
	 * @param y position en ordonnée de la structure
	 * @return structure située sur la case selectionnée, sinon si la case est vide : null
	 */
	public Structure selectionner(int x, int y) {
		Case kase = this.getCase(x, y);
		try {
			return kase.getStructure();
		} catch (CaseVideException e) {
			return null;
		}
	}

	/**
	 * Déplacer une structure présente sur la carte.
	 * @param structure Structure à déplacer
	 * @param nouveauCoin nouvelle case située en haut à gauche de la structure
	 * @throws CaseOccupeeException Prévient que la case sur laquelle on veut construire est déjà occupée par une autre structure
	 */
	public void deplacer(Structure structure, Case nouveauCoin) throws CaseOccupeeException {
		Case[] casesOccupeeAnciennes = structure.getCases();
		Case ancienCoin = structure.getCoin();
		structure.setCoin(nouveauCoin);
		Case[] casesOccupeeNouvelles = structure.getCases();
		// Vérifier que l'on peut déplacer
		for (int i = 0; i < casesOccupeeNouvelles.length; i++) {
			if (casesOccupeeNouvelles[i].getOccupe() && !estDedans(casesOccupeeAnciennes, casesOccupeeNouvelles[i])) {
				structure.setCoin(ancienCoin);
				throw new CaseOccupeeException();
			}
		}
		// Déplacer la structure
		this.listeBatimentRoute.remove(ancienCoin);
		this.listeBatimentRoute.put(ancienCoin, structure);
		for (int i = 0; i < casesOccupeeAnciennes.length; i++) {
			casesOccupeeAnciennes[i].viderCase();
		}
		for (int i = 0; i < casesOccupeeNouvelles.length; i++) {
			casesOccupeeNouvelles[i].ajouterStructure(structure);
		}
	}

	/**
	 * Renvoie si une case est dans un tableau de Case.
	 * @param tableauCase tableau de case
	 * @param kase case dont on veut savoir si elle est dans le tableau
	 * @return si la case est dans le tableau ou non
	 */
	private boolean estDedans(Case[] tableauCase, Case kase) {
		for (int i = 0; i < tableauCase.length; i++) {
			if (kase.estEgale(tableauCase[i])) {
				return true;
			}
		}
		return false;
	}

	/**
	 * Afficher la carte
	 * @param g ?
	 * @param xFond abscisse de fond
	 * @param yFond ordonnée de fond
	 */
	public void afficher(Graphics g, int xFond, int yFond) {
		Set<Case> cases = listeBatimentRoute.keySet();
		for (Case kase : cases) {
			listeBatimentRoute.get(kase).afficher(g, xFond, yFond);
		}
	}

	/**
	 * Accéder à la case d'abscisse et d'ordonnée en parametre
	 * @param x abscisse de la case à trouver
	 * @param y ordonnée de la case à trouver
	 * @return case d'abscisse et d'ordonnée données en parametre
	 */
	public Case getCase(int x, int y) {
		return listeCases.get((x) * Carte.hauteur + y);
	}

	public Map<Case, Structure> getListeStructure() {
		return this.listeBatimentRoute;
	}

	public void updateDimensions() {
		int largeur = 0;
		int hauteur = 0;
		int taille = this.listeCases.size();
		for (int i = 0; i < taille; i++) {
			int x = this.listeCases.get(i).getX();
			int y = this.listeCases.get(i).getY();
			if (x > largeur) {
				largeur = x;
			}
			if (y > hauteur) {
				hauteur = y;
			}
		}
		Carte.largeur = largeur + 1;
		Carte.hauteur = hauteur + 1;
	}
}
