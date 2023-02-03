
public class EnsembleOrdonneChaine implements EnsembleOrdonne{

	private Cellule premiere;
	
	EnsembleOrdonneChaine(){
		this.premiere = null;
	}

	public int cardinal() {
		Cellule poignee = this.premiere;
		int taille = 0;
		while (poignee != null) {
			taille ++;
			poignee = poignee.suivante;
		}
		return taille;
	}

	public boolean estVide() {
		return this.premiere == null;
	}

	public boolean contient(int x) {
		Cellule poignee = this.premiere;
		boolean trouve = false;
		while (poignee.element <=x && poignee != null) {
			if (poignee.element == x) {
				trouve = true;
			}
			poignee = poignee.suivante;
		}
		return trouve;
	}

	public void ajouter(int x) {
		if (this.premiere == null) {
			this.premiere = new Cellule(x);
		} else if (! this.contient(x)){
			Cellule poignee = this.premiere;
			while (poignee.suivante != null) {
				poignee = poignee.suivante;
			}
			poignee.suivante = new Cellule(x);
		}
	}

	public void supprimer(int x) {
		if (this.contient(x) && this.premiere.element == x) {
			this.premiere = this.premiere.suivante;
		} else if (this.contient(x)){
			Cellule poignee = this.premiere;
			while (poignee.suivante.element != x) {
				poignee = poignee.suivante;
			}
			poignee.suivante = poignee.suivante.suivante;
		}
	}

	public int plusPetitElement() {
		// TODO Auto-generated method stub
		return 0;
	}
}
