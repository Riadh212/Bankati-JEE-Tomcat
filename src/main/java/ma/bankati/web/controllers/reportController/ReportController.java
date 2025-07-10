package ma.bankati.web.controllers.reportController;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class ReportController {

    public void showDashboard(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Tu peux ajouter ici des statistiques à passer à la vue :
        // req.setAttribute("totalUsers", 250);
        // req.setAttribute("pendingCredits", 12);

        req.getRequestDispatcher("/admin/rapport.jsp").forward(req, resp);
    }
}
