import java.util.List;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;

public class AfficherListe {

	/** Afficher les éléments de liste, un par ligne... */
	public static <T> void afficher(List<T> liste) {
		for (T o : liste) {
			System.out.println("  - " + o);
		}
	}
	
	/** Afficher les éléments de liste, un par ligne... */
	public static void afficherJoker(List<?> liste) {
		for (Object o : liste) {
			System.out.println("  - " + o);
		}
		
	}

	public static void main(String[] args) {
		List<Object> lo = new ArrayList<>();
		Collections.addAll(lo, "un", "deux", 3);
		afficher(lo);
		System.out.println("Joker");
		afficherJoker(lo);

		List<String> ls = new ArrayList<>();
		Collections.addAll(ls, "un", "deux", "trois");
		afficher(ls);
		System.out.println("Joker");
		afficherJoker(ls);
	}
}
