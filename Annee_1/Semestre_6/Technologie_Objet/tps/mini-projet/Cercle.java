import java.awt.Color;

/** Classe Cercle.
 * @author	Priscilia Gonthier
 */
public class Cercle implements Mesurable2D {
	// Représentation interne d'un cercle
	/** Centre du cercle.
	 */
	private Point centre;

	/** Rayon du cercle.
	 */
	private double rayon;

	/** Couleur de la circonférence du cercle.
	 */
	private Color couleur;

	/** Valeur de la constante pi.
	 */
	public static final double PI = Math.PI;

	/** Construire un cercle de couleur bleu à partir de son centre et de son rayon.
	 * @param centre centre du cercle
	 * @param rayon rayon du cercle
	 */
	public Cercle(Point centre, double rayon) {
		assert centre != null;
		assert rayon > 0;
		this.centre = new Point(centre.getX(), centre.getY());
		this.rayon = rayon;
		this.couleur = Color.blue;
	}

	/** Construire un cercle de couleur bleu à partir de 2 points diamétralement opposés.
	 * @param pointDiametre1 premier point pour la construction du cercle
	 * @param pointDiametre2 second point diamétralement opposé à p1
	 */
	public Cercle(Point pointDiametre1, Point pointDiametre2) {
		assert pointDiametre1 != null && pointDiametre2 != null;
		assert pointDiametre1.getX() != pointDiametre2.getX()
				|| pointDiametre1.getY() != pointDiametre2.getY();
		double xc = (pointDiametre1.getX() + pointDiametre2.getX()) / 2;
		double yc = (pointDiametre1.getY() + pointDiametre2.getY()) / 2;
		this.centre = new Point(xc, yc);
		this.rayon = pointDiametre1.distance(pointDiametre2) / 2;
		this.couleur = Color.blue;
	}

	/** Construire un cercle à partir de 2 points diamétralement opposés et de sa couleur.
	 * @param pointDiametre1 premier point pour la construction du cercle
	 * @param pointDiametre2 second point diamétralement opposé à p1
	 * @param couleur couleur du cercle
	 */
	public Cercle(Point pointDiametre1, Point pointDiametre2, Color couleur) {
		this(pointDiametre1, pointDiametre2);
		assert couleur !=  null;
		this.couleur = couleur;
	}

	/** Créer un cercle bleu à partir de 2 points.
	 * Le premier sera sur le centre du cercle et l'autre sur sa circonférence.
	 * @param centre point situé au centre du cercle
	 * @param pointCirconference point situé à la circonférence du cercle
	 * @return cercle
	 */
	public static Cercle creerCercle(Point centre, Point pointCirconference) {
		assert centre != null && pointCirconference != null;
		double rayon = centre.distance(pointCirconference);
		return new Cercle(centre, rayon);
	}

	/** Translater le cercle.
	 * @param dx déplacement suivant l'axe des X
	 * @param dy déplacement suivant l'axe des Y
	 */
	public void translater(double dx, double dy) {
		this.centre.translater(dx, dy);
	}

	/** Obtenir le centre du cercle.
	 * @return point au centre du cercle
	 */
	public Point getCentre() {
		return new Point(this.centre.getX(), this.centre.getY());
	}

	/** Obtenir le rayon du cercle.
	 * @return rayon du cercle
	 */
	public double getRayon() {
		return this.rayon;
	}

	/** Obtenir la couleur d'un cercle.
	 * @return couleur de la circonférence du cercle
	 */
	public Color getCouleur() {
		return this.couleur;
	}

	/** Obtenir le diamètre du cercle.
	 * @return diamètre du cercle
	 */
	public double getDiametre() {
		return this.rayon * 2;
	}

	/** Changer la couleur du cercle.
	 * @param couleur nouvelle couleur
	 */
	public void setCouleur(Color couleur) {
		assert couleur != null;
		this.couleur = couleur;
	}

	/** Changer le rayon du cercle.
	 * @param rayon nouveau rayon
	 */
	public void setRayon(double rayon) {
		assert rayon > 0;
		this.rayon = rayon;
	}

	/** Changer le diamètre du cercle.
	 * @param diametre nouveau diamètre
	 */
	public void setDiametre(double diametre) {
		assert diametre > 0;
		this.rayon = diametre / 2;
	}

	/** Déterminer si un point est à l'interrieur du cercle.
	 * @param point point dont on veut déterminer s'il est à l'interieur du cercle
	 * @return booléen indiquant si le point est à l'interieur du cercle ou non
	 */
	public boolean contient(Point point) {
		assert point != null;
		return this.centre.distance(point) <= this.rayon;
	}

	/** Obtenir le périmètre du cercle.
	 * @return périmètre du cercle
	 */
	public double perimetre() {
		return 2 * PI * this.rayon;
	}

	/** Obtenir l'aire du cercle.
	 * @return aire du cercle
	 */
	public double aire() {
		return PI * Math.pow(this.rayon, 2);
	}

	/** Obtenir le cercle sous la forme d'une chaine de caractère.
	 * @return cercle sous la forme Cr@(a, b)
	 */
	public String toString() {
		return "C" + rayon + "@" + this.centre;
	}

}
