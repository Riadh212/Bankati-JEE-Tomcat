package ma.bankati.web.controllers.creditController;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ma.bankati.dao.creditDao.IDemandeCreditDao;
import ma.bankati.dao.creditDao.memoryDb.DemandeCreditDaoMemory;
import ma.bankati.model.credit.DemandeCredit;
import ma.bankati.model.users.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/credit")
public class DemandeCreditController extends HttpServlet {
    private IDemandeCreditDao creditDao;

    @Override
    public void init() {
        this.creditDao = new DemandeCreditDaoMemory(); // à remplacer par un Bean si besoin
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("connectedUser");


        // Vérifier si l'utilisateur est connecté
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login"); // Rediriger vers la page de login avec le contexte
            return;
        }
        List<DemandeCredit> demandes;
        if (user.isAdmin()) {
            demandes = creditDao.listerToutes();
        } else {
            demandes = creditDao.trouverParUtilisateur(user.getId());
        }

        // Utiliser la variable demandes déjà initialisée
        req.setAttribute("demandes", demandes);
        req.getRequestDispatcher("/public/credit.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Vérifier si l'utilisateur est connecté
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("connectedUser");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login"); // Ajouter le contexte de l'application
            return;
        }

        String action = req.getParameter("action");
        if (action == null) {
            resp.sendRedirect(req.getContextPath() + "/credit"); // Ajouter le contexte de l'application
            return;
        }


        Long id = null;
        if (req.getParameter("id") != null && !req.getParameter("id").isEmpty()) {
            try {
                id = Long.parseLong(req.getParameter("id"));
            } catch (NumberFormatException e) {
                // Gérer l'erreur de parsing
                resp.sendRedirect(req.getContextPath() + "/credit"); // Ajouter le contexte de l'application
                return;
            }
        }


        switch (action) {
            case "ajouter":
                try {
                    double montant = Double.parseDouble(req.getParameter("montant"));
                    creditDao.ajouter(new DemandeCredit(null, montant, user));
                } catch (NumberFormatException e) {
                    // Gérer l'erreur de parsing
                }
                break;
            case "supprimer":
                if (id != null) {
                    // Vérifier que l'utilisateur est autorisé à supprimer cette demande
                    DemandeCredit demande = creditDao.trouverParId(id);
                    if (demande != null && (user.isAdmin() ||
                            (demande.getUser() != null && demande.getUser().getId().equals(user.getId())))) {
                        creditDao.supprimer(id);
                    }
                }
                break;
            case "approuver":
                if (id != null && user.isAdmin()) {
                    creditDao.approuver(id);
                }
                break;
            case "refuser":
                if (id != null && user.isAdmin()) {
                    creditDao.refuser(id);
                }
                break;
            default:
                // Action non reconnue
                break;
        }
        resp.sendRedirect(req.getContextPath() + "/credit");
    }
}