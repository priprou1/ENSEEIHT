import java.util.List;

import javax.swing.text.html.parser.Element;

/** Quelques outils (méthodes) sur les listes.  */
public class Outils {

	/** Retourne vrai ssi tous les éléments de la collection respectent le critère. */
	public static <F, E extends F> boolean tous(
			List<E> elements,
			Critere<F> critere)
	{
		boolean respecte = true;
		int i = 0;
		while (respecte && i < elements.size()) {
			if (! critere.satisfaitSur(elements.get(i))) {
				respecte = false;
			}
			i++;
		}
		return respecte;
	}


	/** Ajouter dans resultat tous les éléments de la source
	 * qui satisfont le critère aGarder.
	 */
	public static <E,F extends E,G extends F> void filtrer(
			List<G> source,
			Critere<F> aGarder,
			List<E> resultat)
	{
		int i = 0;
		while (i < source.size()) {
			if (aGarder.satisfaitSur(source.get(i))) {
				resultat.add(source.get(i));
			}
			i++;
		}
	}

}
