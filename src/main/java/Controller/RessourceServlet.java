package Controller;

import DAO.RessourceDAO;
import Model.Ressource;
import Util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;

@WebServlet("/ressource")
public class RessourceServlet extends HttpServlet {
    private RessourceDAO ressourceDAO;

    @Override
    public void init() throws ServletException {
        ressourceDAO = new RessourceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String taskId = request.getParameter("taskId");

        if ("new".equals(action)) {
            request.getRequestDispatcher("/CreateResource.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            ressourceDAO.deleteRessource(id);
            response.sendRedirect("ressource?taskId=" + taskId);
        } else {
            // Fetch resources for the specific task
            List<Ressource> ressources = ressourceDAO.getRessourcesByTaskId(Integer.parseInt(taskId));
            request.setAttribute("ressources", ressources);
            request.setAttribute("taskId", taskId);
            // Fetch projetId for the "Back to Tasks" link (optional, if needed)
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement("SELECT projet_id FROM tache WHERE id = ?")) {
                stmt.setInt(1, Integer.parseInt(taskId));
                try (java.sql.ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        request.setAttribute("projetId", rs.getInt("projet_id"));
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            request.getRequestDispatcher("/ResourceList.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            String nom = request.getParameter("nom");
            String type = request.getParameter("type");
            int quantite = Integer.parseInt(request.getParameter("quantite"));
            String infoFournisseur = request.getParameter("infoFournisseur");
            int taskId = Integer.parseInt(request.getParameter("taskId"));
            int quantiteAssignee = Integer.parseInt(request.getParameter("quantiteAssignee"));

            // Add resource to ressource table
            Ressource ressource = new Ressource(0, nom, type, quantite, infoFournisseur);
            int newResourceId = ressourceDAO.addRessource(ressource);

            // Link resource to task in tache_ressource
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(
                         "INSERT INTO tache_ressource (tache_id, ressource_id, quantite_assignee) VALUES (?, ?, ?)")) {
                stmt.setInt(1, taskId);
                stmt.setInt(2, newResourceId);
                stmt.setInt(3, quantiteAssignee);
                stmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            }

            // Update available quantity
            ressourceDAO.updateQuantity(newResourceId, -quantiteAssignee);

            // Redirect back to Listresource.jsp
            response.sendRedirect("ressource?taskId=" + taskId + "&newResourceId=" + newResourceId);
        }
    }
}