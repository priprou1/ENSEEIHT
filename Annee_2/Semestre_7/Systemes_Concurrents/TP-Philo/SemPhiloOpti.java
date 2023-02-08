// Time-stamp: <08 déc 2009 08:30 queinnec@enseeiht.fr>

import java.util.concurrent.Semaphore;

public class SemPhiloOpti implements StrategiePhilo {

    /****************************************************************/
    private Semaphore veutManger[];
    private EtatPhilosophe etats[];
    private Semaphore mutex = new Semaphore(1);

    public SemPhiloOpti (int nbPhilosophes) {
        this.veutManger = new Semaphore[nbPhilosophes];
        this.etats = new EtatPhilosophe[nbPhilosophes];
        for (int i=0; i < nbPhilosophes; i++) {
            this.veutManger[i] = new Semaphore(1);
            this.etats[i] = EtatPhilosophe.Pense;
        }
    }

    /** Le philosophe no demande les fourchettes.
     *  Précondition : il n'en possède aucune.
     *  Postcondition : quand cette méthode retourne, il possède les deux fourchettes adjacentes à son assiette. */
    public void prendreFourchettes (int no) throws InterruptedException
    {
        
        mutex.acquire();
        this.etat[no] = EtatPhilosophe.Demande;
        if (peutManger(no)) {
            this.etats[no] = EtatPhilosophe.Mange;
            IHMPhilo.poser (Main.FourchetteDroite(no), EtatFourchette.AssietteGauche);
            IHMPhilo.poser (Main.FourchetteGauche(no), EtatFourchette.AssietteDroite);
            mutex.release();
        } else {
            mutex.release();
            veutManger[no].acquire();
        }



    }

    /** Le philosophe no rend les fourchettes.
     *  Précondition : il possède les deux fourchettes adjacentes à son assiette.
     *  Postcondition : il n'en possède aucune. Les fourchettes peuvent être libres ou réattribuées à un autre philosophe. */
    public void libererFourchettes (int no)
    {
        vd = Main.PhiloDroite(no);
        vg = Main.PhiloGauche(no);
        mutex.acquire();
        etats[no] = EtatPhilosophe.Pense;
        IHMPhilo.poser (Main.FourchetteDroite(no), EtatFourchette.Table);
        IHMPhilo.poser (Main.FourchetteGauche(no), EtatFourchette.Table);
        if peutManger(vd) {
            veutManger[vd].release();
            etats[vd] = EtatPhilosophe.Mange;
            IHMPhilo.poser (Main.FourchetteDroite(vd), EtatFourchette.AssietteGauche);
            IHMPhilo.poser (Main.FourchetteGauche(vd), EtatFourchette.AssietteDroite);
        }
        if peutManger(vg) {
            veutManger[vg].release();
            etats[vg] = EtatPhilosophe.Mange;
            IHMPhilo.poser (Main.FourchetteDroite(vg), EtatFourchette.AssietteGauche);
            IHMPhilo.poser (Main.FourchetteGauche(vg), EtatFourchette.AssietteDroite);
        }
        mutex.acquire();
    }

    public bool peutManger (int no)
    {
        return this.etats[Main.PhiloDroite(no)] != Etatphilosophe.Mange && this.etats[Main.PhiloGauche(no)] != Etatphilosophe.Mange && this.etats[no] == EtatPhilosophe.Demande;
    }

    /** Nom de cette stratégie (pour la fenêtre d'affichage). */
    public String nom() {
        return "Implantation Sémaphores, stratégie disymétrique";
    }

}

