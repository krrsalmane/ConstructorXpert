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
import java.sql.ResultSet;
import java.util.List;

@WebServlet("/ressource")
public class RessourceServlet extends HttpServlet {
    private RessourceDAO ressourceDAO;

    @Override
    public void init() throws ServletException {
        ressourceDAO = new RessourceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        if ("edit".equals(action) && idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                Ressource ressourceToEdit = getRessourceById(id); // Helper method
                request.setAttribute("ressourceToEdit", ressourceToEdit);
            } catch (NumberFormatException e) {
                System.out.println("Invalid resource ID for edit: " + idStr);
            }
        } else if ("delete".equals(action) && idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                ressourceDAO.deleteRessource(id);
            } catch (NumberFormatException e) {
                System.out.println("Invalid resource ID for delete: " + idStr);
            }
        }

        List<Ressource> ressources = ressourceDAO.getAllRessources();
        request.setAttribute("ressources", ressources);
        request.getRequestDispatcher("resourceList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String nom = request.getParameter("nom");
        String type = request.getParameter("type");
        String quantiteStr = request.getParameter("quantite");
        String infoFournisseur = request.getParameter("infoFournisseur");
        String idStr = request.getParameter("id");

        try {
            int quantite = Integer.parseInt(quantiteStr);
            if ("add".equals(action)) {
                Ressource ressource = new Ressource(0, nom, type, quantite, infoFournisseur);
                ressourceDAO.addRessource(ressource);
            } else if ("update".equals(action) && idStr != null) {
                int id = Integer.parseInt(idStr);
                Ressource ressource = new Ressource(id, nom, type, quantite, infoFournisseur);
                ressourceDAO.updateRessource(ressource);
            }
            response.sendRedirect("ressource");
        } catch (Exception e) {
            System.out.println("Error processing resource: " + e.getMessage());
            response.sendRedirect("ressource");
        }
    }

    // Helper method to get a resource by ID
    private Ressource getRessourceById(int id) {
        String sql = "SELECT * FROM ressource WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Ressource ressource = new Ressource();
                ressource.setId(rs.getInt("id"));
                ressource.setNom(rs.getString("nom"));
                ressource.setType(rs.getString("type"));
                ressource.setQuantite(rs.getInt("quantite"));
                ressource.setInfoFournisseur(rs.getString("info_fournisseur"));
                return ressource;
            }
        } catch (Exception e) {
            System.out.println("Error fetching resource by ID: " + e.getMessage());
        }
        return null;
    }
}