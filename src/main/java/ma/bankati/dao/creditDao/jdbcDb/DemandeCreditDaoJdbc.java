package ma.bankati.dao.creditDao.jdbcDb;

import ma.bankati.config.DatabaseConnection;
import ma.bankati.dao.creditDao.IDemandeCreditDao;
import ma.bankati.model.credit.DemandeCredit;
import ma.bankati.model.credit.EtatDemande;
import ma.bankati.model.users.User;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class DemandeCreditDaoJdbc implements IDemandeCreditDao {

    @Override
    public void ajouter(DemandeCredit demande) {
        String sql = "INSERT INTO demande_credit (montant, date_demande, etat, user_id) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setDouble(1, demande.getMontant());
            stmt.setDate(2, Date.valueOf(demande.getDateDemande()));
            stmt.setString(3, demande.getEtat().toString());
            stmt.setLong(4, demande.getUser().getId());

            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                demande.setId(rs.getLong(1));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void supprimer(Long id) {
        String sql = "DELETE FROM demande_credit WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void approuver(Long id) {
        updateEtat(id, EtatDemande.APPROUVEE);
    }

    @Override
    public void refuser(Long id) {
        updateEtat(id, EtatDemande.REFUSEE);
    }

    private void updateEtat(Long id, EtatDemande etat) {
        String sql = "UPDATE demande_credit SET etat = ? WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, etat.toString());
            stmt.setLong(2, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public DemandeCredit trouverParId(Long id) {
        String sql = "SELECT * FROM demande_credit WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return map(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<DemandeCredit> trouverParUtilisateur(Long userId) {
        List<DemandeCredit> demandes = new ArrayList<>();
        String sql = "SELECT * FROM demande_credit WHERE user_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                demandes.add(map(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return demandes;
    }

    @Override
    public List<DemandeCredit> listerToutes() {
        List<DemandeCredit> demandes = new ArrayList<>();
        String sql = "SELECT * FROM demande_credit";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                demandes.add(map(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return demandes;
    }

    // Mapper un ResultSet vers un objet DemandeCredit
    private DemandeCredit map(ResultSet rs) throws SQLException {
        DemandeCredit d = new DemandeCredit();
        d.setId(rs.getLong("id"));
        d.setMontant(rs.getDouble("montant"));
        d.setDateDemande(rs.getDate("date_demande").toLocalDate());
        d.setEtat(EtatDemande.valueOf(rs.getString("etat")));

        User user = new User();
        user.setId(rs.getLong("user_id"));
        d.setUser(user);

        return d;
    }
}