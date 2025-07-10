package ma.bankati.model.credit;

import ma.bankati.model.users.User;

import java.time.LocalDate;

public class DemandeCredit {
    private Long id;
    private double montant;
    private LocalDate dateDemande;
    private EtatDemande etat;
    private User user;

    public DemandeCredit() {
        this.dateDemande = LocalDate.now();
        this.etat = EtatDemande.EN_ATTENTE;
    }

    public DemandeCredit(Long id, double montant, User user) {
        this.id = id;
        this.montant = montant;
        this.dateDemande = LocalDate.now();
        this.etat = EtatDemande.EN_ATTENTE;
        this.user = user;
    }

    public void setDateDemande(LocalDate dateDemande) {
        this.dateDemande = dateDemande;
    }

    public void setEtat(EtatDemande etat) {
        this.etat = etat;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Long getId() {
        return id;
    }

    public double getMontant() {
        return montant;
    }

    public LocalDate getDateDemande() {
        return dateDemande;
    }

    public EtatDemande getEtat() {
        return etat;
    }

    public User getUser() {
        return user;
    }
}