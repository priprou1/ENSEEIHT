/** Classe regroupant les tests unitaires de la classe Monnaie.  */
public class MonnaieTest {

	protected Monnaie m1;
	protected Monnaie m2;
	protected Monnaie m3;

	@Avant
	public void preparer() {
		this.m1 = new Monnaie(5, "euro");
		this.m2 = new Monnaie(7, "euro");
	}

	@UnTest (enabled = true)
	public void testerAjouter() throws DeviseInvalideException {
		m1.ajouter(m2);
		Assert.assertTrue(m1.getValeur() == 12);
	}

	@UnTest (expected = DeviseInvalideException.class)
	public void testerRetrancher() throws DeviseInvalideException {
		m1.retrancher(m2);
		this.m3 = new Monnaie(5, "coucou");
		m1.retrancher(m3);
		Assert.assertTrue(m1.getValeur() == -2);
	}

	@UnTest (enabled = true)
	public void testerRetrancher2() throws DeviseInvalideException {
		m1.retrancher(m2);
		Assert.assertTrue(m1.getValeur() == -2);
	}

}
