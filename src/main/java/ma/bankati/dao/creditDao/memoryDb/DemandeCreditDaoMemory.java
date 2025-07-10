package ma.bankati.dao.creditDao.memoryDb;

import ma.bankati.dao.creditDao.IDemandeCreditDao;
import ma.bankati.model.credit.DemandeCredit;
import ma.bankati.model.credit.EtatDemande;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class DemandeCreditDaoMemory implements IDemandeCreditDao {
    private Map<Long, DemandeCredit> demandes = new HashMap<>();
    private Long currentId = 1L;

    @Override
    public void ajouter(DemandeCredit demande) {
        demande.setId(currentId++);
        demandes.put(demande.getId(), demande);
    }

    @Override
    public void supprimer(Long id) {
        demandes.remove(id);
    }

    @Override
    public void approuver(Long id) {
        DemandeCredit d = demandes.get(id);
        if (d != null) d.setEtat(EtatDemande.APPROUVEE);
    }

    @Override
    public void refuser(Long id) {
        DemandeCredit d = demandes.get(id);
        if (d != null) d.setEtat(EtatDemande.REFUSEE);
    }

    @Override
    public DemandeCredit trouverParId(Long id) {
        return demandes.get(id);
    }

    @Override
    public List<DemandeCredit> trouverParUtilisateur(Long userId) {
        return demandes.values().stream()
                .filter(d -> d.getUser() != null && d.getUser().getId().equals(userId))
                .collect(Collectors.toList());
    }

    @Override
    public List<DemandeCredit> listerToutes() {
        return new ArrayList<>(demandes.values());
    }
}