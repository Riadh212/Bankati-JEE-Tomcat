package ma.bankati.web.controllers.reportController;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(value = "/reports/*", loadOnStartup = 3)
public class ReportServlet extends HttpServlet {

    private ReportController reportController;

    @Override
    public void init() throws ServletException {
        System.out.println("✅ ReportController initialisé");
        reportController = new ReportController();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();

        if (path == null || "/".equals(path)) {
            reportController.showDashboard(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    public void destroy() {
        System.out.println("🛑 ReportController détruit");
    }
}