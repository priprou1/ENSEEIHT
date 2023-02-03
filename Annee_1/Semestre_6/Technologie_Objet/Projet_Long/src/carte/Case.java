package src.carte;

import java.io.Serializable;

import src.Structure;

public class Case implements Comparable<Case>, Serializable {

	private static final long serialVersionUID = 6339578616139846650L;
	private boolean occupe;
	private Structure batimentOuRoute;
	private int x;
	private int y;

	public Case(int x, int y) {
		this.x = x;
		this.y = y;
		this.occupe = false;
	}

	public int getX() {
		return this.x;
	}

	public int getY() {
		return this.y;
	}

	public boolean getOccupe() {
		return this.occupe;
	}

	public Structure getStructure() throws CaseVideException {
		if (!this.occupe) {
			throw new CaseVideException();
		} else {
			return this.batimentOuRoute;
		}
	}

	public void ajouterStructure(Structure batimentOuRoute) {
		this.batimentOuRoute = batimentOuRoute;
		this.occupe = true;
	}

	public void viderCase() {
		this.occupe = false;
	}

	public boolean estEgale(Case kase) {
		return this.x == kase.getX() && this.y == kase.getY() && this.occupe == kase.getOccupe();
	}

	@Override
	public int compareTo(Case arg0) {
		return (this.y - arg0.getY()) * Carte.getLargeur() + (this.x - arg0.getX());
	}

}
