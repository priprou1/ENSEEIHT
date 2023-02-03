package src.batiments;
import src.carte.Carte;
import src.carte.Case;

class test {

	public static void main(String[] args) {
		Carte carte = new Carte(100, 100);
		//int[] accesRoute = {0, 0};
		Case coin1 = carte.getCase(0, 0);
		Case coin2 = carte.getCase(1, 1);
		Parcelle[] parcelles = {new Parcelle(coin1, coin2, carte)};
		Habitation hab = new Habitation(carte, coin1, parcelles, 1);
		Case[] listeCases = hab.getCases();
		System.out.println(listeCases.length);
		System.out.println(listeCases[0].getX());
		System.out.println(listeCases[0].getY());
	}
}
