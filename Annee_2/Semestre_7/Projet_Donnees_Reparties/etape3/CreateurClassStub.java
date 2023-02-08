import java.io.*;

public class CreateurClassStub {

    /**
     * Méthode qui permet de générer un fichier de définition d'une classe stub java à partir du nom d'une classe
     * Elle étend SharedObject, implémente nomclass_itf et définit un constructeur, une méthode de lecture et une méthode d'écriture.
     * @param nomclass Nom de la classe pour laquelle on doit créer le stub.
     * @pre les fichiers définissant nomclass et la classe nomclass_itf ou ces classes existent déjà
     */
    public static void createclass(String nomclass) {
        try {
            File file = new File("./" + nomclass + "_stub.java");
            if (file.createNewFile()) {
                // Ecrire dans le fichier créé
                PrintWriter writer = new PrintWriter(file, "UTF-8");
                // Créer la classe
                writer.println("public class " + nomclass + "_stub extends SharedObject implements " + nomclass + "_itf, java.io.Serializable {");
                writer.println();
    
                // Créer le constructeur
                writer.println("    public " + nomclass + "_stub(Object obj, int id) {");
                writer.println("        super(obj, id);");
                writer.println("    }");
                writer.println();
    
                // Créer la méthode write
                writer.println("    public void write(String text) {");
                writer.println("        " + nomclass + " o = (" + nomclass + ") obj;");
                writer.println("        o.write(text);");
                writer.println("    }");
                writer.println();
    
                // Créer la méthode read
                writer.println("    public String read() {");
                writer.println("        " + nomclass + " o = (" + nomclass + ") obj;");
                writer.println("        return o.read();");
                writer.println("    }");
                writer.println();
    
                writer.println("}");
                
                writer.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

public static void main(String argv[]) {
    if (argv.length != 1) {
        System.out.println("java CreateurClassStub <name>");
        return;
    }
    String nomclass = argv[0];
    // Créer le fichier nomclass_stub.java
    createclass(nomclass);
}
}