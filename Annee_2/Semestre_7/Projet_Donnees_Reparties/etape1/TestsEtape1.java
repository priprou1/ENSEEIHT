//import java.util.Random;
import java.util.Scanner;

public class TestsEtape1 {

    SharedObject []		sentence;
	static int		    numeroTest;
    static TestsEtape1  app;
    

    public TestsEtape1(SharedObject[] s) {
        this.sentence = s;
    }

    public static void main(String argv[]) {
        if (argv.length != 1) {
			System.out.println("java TestsEtape1 <num Terminal>");
			return;
		}


		numeroTest = Integer.parseInt(argv[0]);
	
		// initialize the system
		Client.init();

        // On travaille sur un seul objet que l'on appelle ObjetTest
        SharedObject[] sentences = new SharedObject[10];
        for (int i = 1; i <= 10; i++) {
            SharedObject s = (SharedObject) Client.lookup("ObjetTest" + i);// + Integer.toString(i));
            if (s == null) {
                s = (SharedObject) Client.create(new Sentence());
                Client.register("ObjetTest" + i, s);
            }
            sentences[i-1] = s;
        }

        TestsEtape1 test = new TestsEtape1(sentences);

        Scanner sc = new Scanner(System.in);

        System.out.print("\nAppuyez sur [ENTER] pour commencer les tests.");
        sc.nextLine();

        
        String lockAvant;
        String lockApres;
        int ident;

        // Test numéro 2 :
        ident = 1;
        System.out.println("======================================");
        System.out.println("      Test numéro 2 : NL -> RLT       ");
        System.out.println("======================================");
        lockAvant = test.printEtatActuel("avant", ident);
        test.sentence[ident].lock_read();
        lockApres = test.printEtatActuel("après", ident);

        if (!test.verification(lockAvant, "NL", lockApres, "RLT")) {
            sc.close();
            return;
        }

        test.sentence[ident].unlock();

        // Test numéro 1 :
        ident = 0;
        test.sentence[ident].lock_read();
        test.sentence[ident].unlock();

        System.out.println("======================================");
        System.out.println("      Test numéro 1 : RLC -> RLT      ");
        System.out.println("======================================");
        lockAvant = test.printEtatActuel("avant", ident);
        test.sentence[ident].lock_read();
        lockApres = test.printEtatActuel("après", ident);

        if (!test.verification(lockAvant, "RLC", lockApres, "RLT")) {
            sc.close();
            return;
        }

        // Test numéro 3 :
        ident = 2;
        if (numeroTest == 1) {

            System.out.println("======================================");
            System.out.println("      Test numéro 3 : NL -> RLT       ");
            System.out.println("======================================");

            System.out.println("\nAppuyez sur [ENTER] lorsque le test 2 sera prêt.");
            sc.nextLine();

            lockAvant = test.printEtatActuel("avant", ident);
            test.sentence[ident].lock_read();
            lockApres = test.printEtatActuel("après", ident);

            if (!test.verification(lockAvant, "NL", lockApres, "RLT")) {
                sc.close();
                return;
            }

            System.out.println("Vous pouvez Maintenant appuyer sur [ENTER] dans test 2.");


        } else {
            test.sentence[ident].lock_read();

            System.out.println("======================================");
            System.out.println("      Test numéro 3 : RLT -> RLT      ");
            System.out.println("======================================");

            lockAvant = test.printEtatActuel("avant", ident);

            System.out.println("Test 2 prêt.");
            System.out.println("\nAppuyez sur [ENTER] lorsque vous l'aurez fait sur test 1");
            sc.nextLine();

            lockApres = test.printEtatActuel("après", ident);

            if (!test.verification(lockAvant, "RLT", lockApres, "RLT")) {
                sc.close();
                return;
            }
        }
        
        // Test numéro 4
        ident = 3;
        if(numeroTest == 1) {

            System.out.println("======================================");
            System.out.println("      Test numéro 4 : NL -> RLT       ");
            System.out.println("======================================");

            System.out.println("\nAppuyez sur [ENTER] lorsque le test 2 sera prêt.");
            sc.nextLine();

            lockAvant = test.printEtatActuel("avant", ident);
            test.sentence[ident].lock_read();
            lockApres = test.printEtatActuel("après", ident);

            if (!test.verification(lockAvant, "NL", lockApres, "RLT")) {
                sc.close();
                return;
            }

        } else {
            // Mise en place :
            test.sentence[ident].lock_write();
            test.sentence[ident].unlock();

            System.out.println("======================================");
            System.out.println("      Test numéro 4 : WLC -> RLC      ");
            System.out.println("======================================");

            lockAvant = test.printEtatActuel("avant", ident);

            System.out.println("Test 2 prêt.");
            System.out.println("\nAppuyez sur [ENTER] lorsque le test 1 sera prêt.");
            sc.nextLine();

            lockApres = test.printEtatActuel("après", ident);

            if (!test.verification(lockAvant, "WLC", lockApres, "RLC")) {
                sc.close();
                return;
            }
        }

        ident = 4;
        if (numeroTest == 1) {
            test.sentence[ident].lock_write();
            test.sentence[ident].unlock();

            System.out.println("======================================");
            System.out.println("    Test numéro 5 : WLC -> RLT_WLC    ");
            System.out.println("======================================");

            System.out.println("\nAppuyez sur [ENTER] pour lancer le test.");
            sc.nextLine();

            test.sentence[ident].unlock();
            test.sentence[ident].lock_write();
            test.sentence[ident].unlock();

            lockAvant = test.printEtatActuel("avant", ident);
            test.sentence[ident].lock_read();
            lockApres = test.printEtatActuel("après", ident);

            if (!test.verification(lockAvant, "WLC", lockApres, "RLT_WLC")) {
                sc.close();
                return;
            }
        }

        ident = 5;
        if (numeroTest == 1) {
            test.sentence[ident].lock_write();
            test.sentence[ident].unlock();
            test.sentence[ident].lock_read();

            System.out.println("======================================");
            System.out.println("    Test numéro 6 : RLT_WLC -> RLT    ");
            System.out.println("======================================");

            lockAvant = test.printEtatActuel("avant", ident);

            System.out.println("\nAppuyez sur [ENTER] lorsque le test 2 sera prêt.");
            sc.nextLine();

            lockApres = test.printEtatActuel("après", ident);

            if (!test.verification(lockAvant, "RLT_WLC", lockApres, "RLT")) {
                sc.close();
                return;
            }
        } else {

            System.out.println("======================================");
            System.out.println("       Test numéro 6 : NL -> RLT      ");
            System.out.println("======================================");

            System.out.println("\nAppuyez sur [ENTER] pour démarrer le test.");
            sc.nextLine();

            lockAvant = test.printEtatActuel("avant", ident);
            test.sentence[ident].lock_read();
            lockApres = test.printEtatActuel("après", ident);

            if (!test.verification(lockAvant, "NL", lockApres, "RLT")) {
                sc.close();
                return;
            }

            System.out.println("Test 2 est prêt.");
            sc.nextLine();
        }

        ident  = 6;
        if (numeroTest == 1) {

            System.out.println("======================================");
            System.out.println("    Test numéro 7 : NL -> WLT    ");
            System.out.println("======================================");


            System.out.println("\nAppuyez sur [ENTER] lorsque le test 2 sera prêt.");
            sc.nextLine();

            lockAvant = test.printEtatActuel("avant", ident);
            test.sentence[ident].lock_write();
            lockApres = test.printEtatActuel("après", ident);

            if (!test.verification(lockAvant, "NL", lockApres, "WLT")) {
                sc.close();
                return;
            }
        } else {
            test.sentence[ident].lock_read();
            test.sentence[ident].unlock();

            System.out.println("======================================");
            System.out.println("       Test numéro 7 : RLC -> NL      ");
            System.out.println("======================================");

            

            lockAvant = test.printEtatActuel("avant", ident);

            System.out.println("\nLe test 2 est prêt.");
            System.out.println("Appuyez sur [ENTER] lorsque le test 1 est prêt.");
            sc.nextLine();

            lockApres = test.printEtatActuel("après", ident);

            if (!test.verification(lockAvant, "RLC", lockApres, "NL")) {
                sc.close();
                return;
            }
        }

        ident = 7;
        if (numeroTest == 1) {

            System.out.println("======================================");
            System.out.println("    Test numéro 8 : NL -> WLT    ");
            System.out.println("======================================");


            System.out.println("\nAppuyez sur [ENTER] lorsque le test 2 sera prêt.");
            sc.nextLine();

            lockAvant = test.printEtatActuel("avant", ident);
            test.sentence[ident].lock_write();
            lockApres = test.printEtatActuel("après", ident);

            if (!test.verification(lockAvant, "NL", lockApres, "WLT")) {
                sc.close();
                return;
            }
        } else {
            test.sentence[ident].lock_write();
            test.sentence[ident].unlock();

            System.out.println("======================================");
            System.out.println("       Test numéro 8 : WLC -> NL      ");
            System.out.println("======================================");

            

            lockAvant = test.printEtatActuel("avant", ident);

            System.out.println("\nLe test 2 est prêt.");
            System.out.println("Appuyez sur [ENTER] lorsque le test 1 est prêt.");
            sc.nextLine();

            lockApres = test.printEtatActuel("après", ident);

            if (!test.verification(lockAvant, "WLC", lockApres, "NL")) {
                sc.close();
                return;
            }
        }

        ident = 8;
        if (numeroTest == 1) {
            test.sentence[ident].lock_read();
            test.sentence[ident].unlock();

            System.out.println("======================================");
            System.out.println("    Test numéro 9 : RLC -> WLT        ");
            System.out.println("======================================");


            System.out.println("\nAppuyez sur [ENTER] lorsque le test 2 sera prêt.");
            sc.nextLine();

            lockAvant = test.printEtatActuel("avant", ident);
            test.sentence[ident].lock_write();
            lockApres = test.printEtatActuel("après", ident);

            if (!test.verification(lockAvant, "RLC", lockApres, "WLT")) {
                sc.close();
                return;
            }
        } else {
            test.sentence[ident].lock_read();
            test.sentence[ident].unlock();

            System.out.println("======================================");
            System.out.println("       Test numéro 9 : RLC -> NL      ");
            System.out.println("======================================");

            

            lockAvant = test.printEtatActuel("avant", ident);

            System.out.println("\nLe test 2 est prêt.");
            System.out.println("Appuyez sur [ENTER] lorsque le test 1 est prêt.");
            sc.nextLine();

            lockApres = test.printEtatActuel("après", ident);

            if (!test.verification(lockAvant, "RLC", lockApres, "NL")) {
                sc.close();
                return;
            }
        }

        ident = 9;
        if (numeroTest == 1) {
            test.sentence[ident].lock_read();
            test.sentence[ident].unlock();

            System.out.println("======================================");
            System.out.println("    Test numéro 10 : RLC -> WLT       ");
            System.out.println("======================================");


            System.out.println("\nAppuyez sur [ENTER] lorsque le test 2 sera prêt.");
            sc.nextLine();

            lockAvant = test.printEtatActuel("avant", ident);
            test.sentence[ident].lock_write();
            lockApres = test.printEtatActuel("après", ident);

            if (!test.verification(lockAvant, "RLC", lockApres, "WLT")) {
                sc.close();
                return;
            }

        } else {
            // Remise en contexte :
            test.sentence[ident].lock_read();

            System.out.println("======================================");
            System.out.println("       Test numéro 10 : RLT -> NL      ");
            System.out.println("======================================");

            

            lockAvant = test.printEtatActuel("avant", ident);

            System.out.println("\nLe test 2 est prêt.");
            System.out.println("Appuyez sur [ENTER] lorsque le test 1 est prêt.");
            sc.nextLine();

            lockApres = test.printEtatActuel("après", ident);

            if (!test.verification(lockAvant, "RLT", lockApres, "RLT")) {
                sc.close();
                return;
            }

            System.out.println("Appuyez sur [ENTER] Ppour continuer le test.");
            sc.nextLine();

            lockAvant = lockApres;
            test.sentence[ident].unlock();
            lockApres = test.printEtatActuel("après", ident);

            if (!test.verification(lockAvant, "RLT", lockApres, "NL")) {
                sc.close();
                return;
            }
        }


        sc.close();

        
    }

    public String printEtatActuel(String str, int i) {
        System.out.print("Etat " + str + " : ");
        String lock = this.sentence[i].getLock().toString();
        System.out.println(lock);
        return lock;
    }

    public boolean verification(String avant, String avantAttendu, String apres, String apresAttendu) {
        if (avantAttendu.equals(avant) && apresAttendu.equals(apres)) {
            System.out.println("\n Le test est réussi ! \n");
            return true;
        } else {
            System.out.println("\n Problème de Lock, le test ne passe pas. \n");
            return false;
        }
    }
}
