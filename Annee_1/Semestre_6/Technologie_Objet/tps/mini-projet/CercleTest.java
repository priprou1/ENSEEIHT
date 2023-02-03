import java.awt.Color;
import org.junit.*;
import static org.junit.Assert.*;

/**
  * Classe de test (qui complète SujetCercleTest) de la classe Cercle.
  * @author	Priscilia Gonthier
  * @version	1.0
  */
public class CercleTest {

	// précision pour les comparaisons réelle
	public final static double EPSILON = 0.001;

	// Les points du sujet
	private Point A, B, C, D, E, F, G, H;

	// Les cercles du sujet
	private Cercle C1, C1bis, C2, C2bis, C3, C3bis;

	@Before public void setUp() {
		// Construire les points
		A = new Point(1, 2);
		B = new Point(2, 2);
		C = new Point(3, 2);
		D = new Point(8, 1);
		E = new Point(7, 1);
		F = new Point(-2, -2);
		G = new Point(-2, 0);
		H = new Point(-2, -1);
		

		// Construire les cercles
		C1 = new Cercle(A, C);
		C1bis = new Cercle(new Point(-2, -2), G);
		C2 = new Cercle(new Point(6, 1), D, Color.red);
		C2bis = new Cercle(F, G, Color.green);
		C3 = Cercle.creerCercle(B, C);
		C3bis = Cercle.creerCercle(H, F);
	}

	/** Vérifier si deux points ont mêmes coordonnées.
	  * @param p1 le premier point
	  * @param p2 le deuxième point
	  */
	static void memesCoordonnees(String message, Point p1, Point p2) {
		assertEquals(message + " (x)", p1.getX(), p2.getX(), EPSILON);
		assertEquals(message + " (y)", p1.getY(), p2.getY(), EPSILON);
	}

	@Test public void testerE12() {
		memesCoordonnees("E12 : Centre de C1 incorrect", B, C1.getCentre());
		assertEquals("E12 : Diamètre de C1 incorrect", A.distance(C), C1.getDiametre(), EPSILON);
		assertEquals(Color.blue, C1.getCouleur());
		memesCoordonnees("E12 : Centre de C1bis incorrect", H, C1bis.getCentre());
		assertEquals("E12 : Diamètre de C1bis incorrect", F.distance(G), C1bis.getDiametre(), EPSILON);
		assertEquals(Color.blue, C1.getCouleur());
	}

	@Test public void testerE13() {
		memesCoordonnees("E13 : Centre de C2 incorrect", E, C2.getCentre());
		assertEquals("E13 : Diamètre de C2 incorrect", D.distance(new Point(6,1)), C2.getDiametre(), EPSILON);
		assertEquals(Color.red, C2.getCouleur());
		memesCoordonnees("E13 : Centre de C2bis incorrect", H, C2bis.getCentre());
		assertEquals("E13 : Diamètre de C2 incorrect", F.distance(G), C2bis.getDiametre(), EPSILON);
		assertEquals(Color.green, C2bis.getCouleur());
	}
	
	@Test public void testerE14() {
		memesCoordonnees("E14 : Centre de C3 incorrect", B, C3.getCentre());
		assertEquals("E14 : Rayon de C3 incorrect",	B.distance(C), C3.getRayon(), EPSILON);
		assertEquals(Color.blue, C3.getCouleur());
		memesCoordonnees("E14 : Centre de C3bis incorrect", H, C3bis.getCentre());
		assertEquals("E14 : Rayon de C3bis incorrect",	H.distance(F), C3bis.getRayon(), EPSILON);
		assertEquals(Color.blue, C3bis.getCouleur());
	}

}
