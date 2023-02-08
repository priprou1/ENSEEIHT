public class Sentence_chaine implements java.io.Serializable {
    String data;
    Sentence_itf suivant;

    public Sentence_chaine (String data, Sentence_itf suivant){
        this.data = data;
        this.suivant = suivant;
    }

    public Sentence_chaine() {
        data = new String("");
    }
	
	public void write(String text) {
		data = text;
	}
	public String read() {
		return data;	
	}

    public Sentence_itf getSuivant() {
        return this.suivant;
    }

}
