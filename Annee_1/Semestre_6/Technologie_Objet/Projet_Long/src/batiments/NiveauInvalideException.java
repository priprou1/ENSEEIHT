package src.batiments;

@SuppressWarnings("serial")
public class NiveauInvalideException extends RuntimeException {

    private int niveau;

    public NiveauInvalideException(String message, int niveau) {
        super(message);
        this.niveau = niveau;  
    }

    public int getNiveau() {
        return this.niveau;
    }

}