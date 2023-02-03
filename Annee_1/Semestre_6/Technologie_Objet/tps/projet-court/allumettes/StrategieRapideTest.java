package allumettes;

import static org.junit.Assert.assertEquals;
import org.junit.Before;
import org.junit.Test;

/** 
 * Classe de test de la classe StratégieRapide
 * @author Priscilia Gonthier
 */
public class StrategieRapideTest {

	private Jeu jeu;
	private Strategie strategieRapide;

	@Before public void setUp() {
		strategieRapide = new StrategieRapide();
	}

	/** Teste si la stratégie rapide prend bien le nombre maximum d'allumettes,
	 ** lorsque il reste plus d'allumettes que la prise maximum.
	 */
	@Test public void testerPriseSupMax() {
		jeu = new JeuAllumettes(13);
		assertEquals("Rapide ne prend pas le maximum d'allumettes", Jeu.PRISE_MAX, strategieRapide.getPrise(jeu, "Rapide"));
		jeu = new JeuAllumettes(3);
		assertEquals("Rapide ne prend pas le maximum d'allumettes", Jeu.PRISE_MAX, strategieRapide.getPrise(jeu, "Rapide"));
	}

	/** Teste si la stratégie rapide prend bien le nombre maximum d'allumettes,
	 ** lorsque il reste moins d'allumettes que la prise maximum.
	 */
	@Test public void testerPriseInfMax() {
		jeu = new JeuAllumettes(2);
		assertEquals("Rapide ne prend pas le maximum d'allumettes", jeu.getNombreAllumettes(), strategieRapide.getPrise(jeu, "Rapide"));
		jeu = new JeuAllumettes(1);
		assertEquals("Rapide ne prend pas le maximum d'allumettes", jeu.getNombreAllumettes(), strategieRapide.getPrise(jeu, "Rapide"));
	}
}
