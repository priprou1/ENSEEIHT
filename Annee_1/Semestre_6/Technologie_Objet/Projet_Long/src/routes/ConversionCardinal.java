package src.routes;

/**
 * Classe permettant de converti les cardinals en numéro d'affichage des routes.
 */
public class ConversionCardinal {

    /** Retourne l'orientation du croisement de la route à partir de son numéro et sa rotation.
     * @param numRoute numéro de la route
     * @param numRotation numéro de la rotation
     * @return croisement de la route
     * @requires 1 <= numRoute <= 5
     * @requires 1 <= numRotation <= 4
     */
    public static Cardinal convertirEntier(int numRoute,int numRotation) {
        Cardinal cardinal;
        switch (numRoute) {
            case 1:
                switch (numRotation) {
                    case 2:
                        cardinal = Cardinal.E;
                        break;
                    case 3:
                        cardinal = Cardinal.S;
                        break;
                    case 4:
                        cardinal = Cardinal.O;
                        break;
                    case 1:
                    default:
                        cardinal = Cardinal.N;
                        break;
                }
                break;
            case 2:
                switch (numRotation) {
                    case 2:
                    case 4:
                        cardinal = Cardinal.EO;
                        break;
                    case 1:
                    case 3:
                    default:
                        cardinal = Cardinal.NS;
                        break;
                }
                break;
            case 3:
                switch (numRotation) {
                    case 2:
                        cardinal = Cardinal.SEO;
                        break;
                    case 3:
                        cardinal = Cardinal.NSO;
                        break;
                    case 4:
                        cardinal = Cardinal.NEO;
                        break;
                    case 1:
                    default:
                        cardinal = Cardinal.NSE;
                        break;
                }
                break;
            case 4:
                cardinal = Cardinal.NSEO;
                break;
            case 5:
                switch (numRotation) {
                    case 2:
                        cardinal = Cardinal.SE;
                        break;
                    case 3:
                        cardinal = Cardinal.SO;
                        break;
                    case 4:
                        cardinal = Cardinal.NO;
                        break;
                    case 1:
                    default:
                        cardinal = Cardinal.NE;
                        break;
                }
                break;
            default:
                cardinal = Cardinal.NS;
                break;
        }
        return cardinal;
    }
    /** Retourne le numéro et la rotation de la route à partir de son orientation.
     * @param cardinal croisement de la route
     * @return tableau contenant en position 0 le numéro de route et en 1 le numéro de rotation
     * @ensures 1 <= numRoute <= 5
     * @ensures 1 <= numRotation <= 4
     */
    public static int[] convertirCardinal(Cardinal cardinal) {
        int[] routeRotation = new int[2];
        switch (cardinal) {
            case N:
                routeRotation[0] = 1;
                routeRotation[1] = 1;
                break;
            case E:
            routeRotation[0] = 1;
            routeRotation[1] = 2;
                break;
            case S:
            routeRotation[0] = 1;
            routeRotation[1] = 3;
                break;
            case O:
            routeRotation[0] = 1;
            routeRotation[1] = 4;
                break;
            case EO:
            routeRotation[0] = 2;
            routeRotation[1] = 2;
                break;
            case NSE:
            routeRotation[0] = 3;
            routeRotation[1] = 1;
                break;
            case SEO:
            routeRotation[0] = 3;
            routeRotation[1] = 2;
                break;
            case NSO:
            routeRotation[0] = 3;
            routeRotation[1] = 3;
                break;
            case NEO:
            routeRotation[0] = 3;
            routeRotation[1] = 4;
                break;
            case NSEO:
            routeRotation[0] = 4;
            routeRotation[1] = 1;
                break;
            case NE:
            routeRotation[0] = 5;
            routeRotation[1] = 1;
                break;
            case SE:
            routeRotation[0] = 5;
            routeRotation[1] = 2;
                break;
            case SO:
            routeRotation[0] = 5;
            routeRotation[1] = 3;
                break;
            case NO:
            routeRotation[0] = 5;
            routeRotation[1] = 4;
                break;
            case NS:
            default:
            routeRotation[0] = 2;
            routeRotation[1] = 1;
                break;
        }
        return routeRotation;
    }
}
