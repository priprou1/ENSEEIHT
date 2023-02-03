package src;

final class Horloge {
	
	public static final int UNJOUR = 480000;
	
	static String dayTime(long temps) {
		int[] anneeMoisJour = anneeMoisNombre(temps);
		return "" + anneeMoisJour[2] + " " + Mois.values()[anneeMoisJour[1]] + " " + anneeMoisJour[0];
	}
	
	static String timeTime(long temps) {
		int time = (int) (temps % UNJOUR);
		int heure = time / (UNJOUR / 24);
		int minute = (int) (60 * ((double) (time % (UNJOUR / 24)))/(UNJOUR / 24));
		return (heure<10 ? "0" : "") + heure + " : " + (minute<10 ? "0" : "") + minute;
	}
	
	@SuppressWarnings("fallthrough")
	private static int moisTime(Mois mois, int annee) {
		int nbrJour = 31;
		switch (mois) {
			case fevrier :
				nbrJour -= 1 + ((annee%4 == 0 & annee%25 != 0) | annee%16 == 0 ? 0 : 1);
			case avril : case juin : case septembre : case novembre :
				nbrJour--;
			default:
				
		}
		return nbrJour;
	}
	
	private static int[] anneeMoisNombre(long time) {
		long temps = time/UNJOUR;
		int ansPasses = 0;
		int nbrMois = -1;
		int jour = 0;
		do {
			nbrMois++;
			nbrMois%= 12;
			ansPasses += (nbrMois==0? 1 : 0);
			temps -= moisTime(Mois.values()[nbrMois], 1999 + ansPasses);
		} while (temps > 0);
		temps += moisTime(Mois.values()[nbrMois], 1999 + ansPasses);
		jour = (int) (temps%moisTime(Mois.values()[nbrMois], ansPasses + 1999)+1);
		int[] retour = {1999 + ansPasses, nbrMois, jour};
		return retour;
	}
	
	
	private static enum Mois {
		janvier, fevrier, mars, avril, mai, juin, juillet, août, septembre, octobre, novembre, décembre
	}
}
