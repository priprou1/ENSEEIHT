package src.carte;

/**
 * Exception qui indique que la case est occupée.
 */
@SuppressWarnings("serial")
public class CaseOccupeeException extends Exception {

	/**
	 * Initaliser une ConfigurationException avec le message précisé.
	 */
	public CaseOccupeeException() {
		super();
	}
}
