/** Construre le schema de la fiicgure 1.
 * @author Priscilia Gonthier
 * @version 1.0
 */
 public class ExempleSchema1 {
        public static void main(String[] args) {
                // Créer les points du schéma
                Point p1 = new Point(3, 2);
                Point p2 = new Point(6, 9);
                Point p3 = new Point(11, 4);
                
                // Créer les segments du schéma
                Segment s12 = new Segment(p1, p2);
                Segment s23 = new Segment(p2, p3);
                Segment s31 = new Segment(p3, p1);
                
                // Créer le barycentre de ces trois points
                double xB = (p1.getX() + p2.getX() + p3.getX()) / 3;
                double yB = (p1.getY() + p2.getY() + p3.getY()) / 3;
                Point B = new Point(xB, yB);

                //Afficher le barycentre
                System.out.print("Barycentre:");
                B.afficher();
                System.out.println();

                }
}

