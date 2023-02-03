import java.awt.Color;
abstract public class ObjetGeometric {
	
	private Color couleur;
	
	ObjetGeometric(Color color) {
		this.couleur = color;
	}
	
//  Gestion de la couleur
	
	/** Obtenir la couleur de l'objet.
	 * @return la couleur de l'objet
	 */
	//@ pure
	public Color getCouleur() {
		return this.couleur;
	}
	
	/** Changer la couleur de l'objet.
	  * @param nouvelleCouleur nouvelle couleur
	  */
	public void setCouleur(Color nouvelleCouleur) {
		this.couleur = nouvelleCouleur;
	}
	
	
	
}
