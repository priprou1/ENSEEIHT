public class IntClassTransport implements java.io.Serializable {
    
    private int id;
    private Class<?> classe;

    public IntClassTransport(int i, Class<?> classe) {
        this.classe = classe;
        this.id = i;
    }

    public int getId() {
        return id;
    }

    public Class<?> getClasse() {
        return classe;
    }

}
