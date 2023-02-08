// Time-stamp: <08 Apr 2008 11:35 queinnec@enseeiht.fr>

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import Synchro.Assert;

/** Lecteurs/rédacteurs
 * stratégie d'ordonnancement: priorité aux rédacteurs,
 * implantation: avec un moniteur. */
public class LectRed_PrioRedacteur implements LectRed
{
    // Protection des variables partagées
    private Lock moniteur;

    // Pour bloquer un rédacteur
    private Condition lecturePossible;

    // Pour bloquer un lecteur
    private Condition ecriturePossible;

    private int nbLecteur;
    private int nbRedacteur;
    private int nbRedAtt;

    public LectRed_PrioRedacteur()
    {
        this.moniteur = new ReentrantLock();
        this.lecturePossible = moniteur.newCondition();
        this.ecriturePossible = moniteur.newCondition();
        this.nbLecteur = 0;
        this.nbRedacteur = 0;
        this.nbRedAtt = 0;
    }

    public void demanderLecture() throws InterruptedException
    {
        moniteur.lock();
        while (!(nbRedacteur == 0 && nbRedAtt == 0)) {
            lecturePossible.await();
        }
        nbLecteur++;
        lecturePossible.signal(); // Réveil en chaîne
        moniteur.unlock();
    }

    public void terminerLecture() throws InterruptedException
    {
        moniteur.lock();
        nbLecteur--;
        if (nbLecteur == 0) {
            ecriturePossible.signal();
        }
        moniteur.unlock();
    }

    public void demanderEcriture() throws InterruptedException
    {
        moniteur.lock();
        while (!(nbLecteur == 0 && nbRedacteur == 0)) {
            nbRedAtt++;
            ecriturePossible.await();
            nbRedAtt--;
        }
        nbRedacteur++;
        moniteur.unlock();
    }

    public void terminerEcriture() throws InterruptedException
    {
        moniteur.lock();
        nbRedacteur--;
        if (nbRedAtt > 0) {
            ecriturePossible.signal();
        } else {
            lecturePossible.signal();
        }
        moniteur.unlock();
    }

    public String nomStrategie()
    {
        return "Stratégie: Priorité Rédacteurs.";
    }
}
