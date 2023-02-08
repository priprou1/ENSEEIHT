import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class LectRed_FIFO implements LectRed
{
    private Lock moniteur;
    private int nbLec;
    private int nbRed;
    private int nbAtt;
    private int nbSas;
    private Condition acces;
    private Condition sas;

    public LectRed_FIFO() {
        this.moniteur = new ReentrantLock();
        this.nbLec = 0;
        this.nbRed = 0;
        this.acces =  moniteur.newCondition();
        this.sas =  moniteur.newCondition();
        this.nbAtt = 0;
        this.nbSas = 0;
    }

    public void demanderLecture() throws InterruptedException {
        moniteur.lock();
        while (!(nbRed == 0 && nbAtt == 0)) {
            nbAtt++;
            acces.await();
            nbAtt--;
        }
        nbLec++;
        acces.signal();
        moniteur.unlock();
    }

    public void demanderEcriture() throws InterruptedException {
        moniteur.lock();
        while (!(nbRed == 0 && nbLec == 0)) {
            nbAtt++;
            acces.await();
            if (nbLec > 0) {
                nbSas++;
                sas.await();
                nbSas--;
            }
            nbAtt--;
        }
        nbRed++;
        moniteur.unlock();
    }

    public void terminerLecture() throws InterruptedException {
        moniteur.lock();
        nbLec--;
        if (nbLec == 0) {
            if (!(nbSas == 0)) {
                sas.signal();
            } else {
                acces.signal();
            }
        }
        moniteur.unlock();
    }

    public void terminerEcriture() throws InterruptedException {
        moniteur.lock();
        nbRed--;
        acces.signal();
        moniteur.unlock();
    }

    public String nomStrategie() {
        return "Stratégie: Equitable.";
    }
    
}
