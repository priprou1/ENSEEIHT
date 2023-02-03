package src.routes;

import src.carte.Case;

/**
 * Route qui est affichée avec un trottoir.
 */
public class RouteTrottoir extends RouteGenerale {

	private static final long serialVersionUID = 4166868520767458811L;

	public RouteTrottoir(Case kase, Cardinal cardinal) {
		super(kase, cardinal);
	}

	/**
	 * Permet de récupérer l'image à afficher sur la carte.
	 */
	public void setImage() {
		int[] typeEtRotation = ConversionCardinal.convertirCardinal(super.getCardinal());
		String typeString = String.valueOf(typeEtRotation[0]);
		String rotationString = String.valueOf(typeEtRotation[1]);
		String chemin = "src/Images/Routes/Route_trottoir" + typeString + rotationString + ".png";
		super.setImageRoute(chemin);
	}

}
