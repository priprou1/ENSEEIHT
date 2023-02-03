package src.routes;

import java.io.Serializable;

import src.Structure;
import src.carte.Case;

/**
 * Classe qui contient toutes fonctions utiles dans les différentes routes.
 */
public class RouteGenerale extends Structure implements Serializable {

	
	private static final long serialVersionUID = 5461935806402443191L;
	private Case kase; /* Case sur laquelle la route est posée */
	private Cardinal cardinal; /* Orientation du croisement de la route */

	public RouteGenerale(Case kase, Cardinal cardinal) {
		this.kase = kase;
		this.cardinal = cardinal;
	}

	/**
	 * Permet d'avoir l'orientation de la route.
	 * @return L'orientation du croisement de la route
	 */
	public Cardinal getCardinal() {
		return this.cardinal;
	}

	/**
	 * Permet de définir l'orientation de la route.
	 * @param cardinal Nouvelle orientation de la route
	 */
	public void setCardinal(Cardinal cardinal) {
		this.cardinal = cardinal;
	}

	/**
	 * Permet de récupérer l'image de la route à afficher.
	 */
	public void setImage(String chemin) {
		super.setImageRoute(chemin);
	}
	@Override
	public Case[] getCases() {
		Case[] ret = new Case[1];
		ret[0] = this.kase;
		return ret;
	}

	@Override
	public Case getCoin() {
		return this.kase;
	}

	@Override
	public void setCoin(Case coin) {
		this.kase = coin;
	}
	
}
