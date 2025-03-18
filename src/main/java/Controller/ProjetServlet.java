package Controller;

import DAO.ProjetDAO;
import Model.Project;
import Model.Project;
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
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/projet")
public class ProjetServlet extends HttpServlet {
    private ProjetDAO projetDAO;

    @Override
    public void init() throws ServletException {
        projetDAO = new ProjetDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        if ("edit".equals(action) && idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                Project projetToEdit = getProjetById(id); // Fetch project to edit
                request.setAttribute("projetToEdit", projetToEdit);
            } catch (NumberFormatException e) {
                System.out.println("Invalid project ID for edit: " + idStr);
            }
        } else if ("delete".equals(action) && idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                projetDAO.deleteProjet(id);
            } catch (NumberFormatException e) {
                System.out.println("Invalid project ID for delete: " + idStr);
            }
        }

        List<Project> projets = projetDAO.getAllProjets();
        request.setAttribute("projets", projets);
        request.getRequestDispatcher("projectList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String nom = request.getParameter("nom");
        String description = request.getParameter("description");
        String dateDebutStr = request.getParameter("dateDebut");
        String dateFinStr = request.getParameter("dateFin");
        String budgetStr = request.getParameter("budget");

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date dateDebut = sdf.parse(dateDebutStr);
            Date dateFin = sdf.parse(dateFinStr);
            double budget = Double.parseDouble(budgetStr);

            if ("add".equals(action)) {
                Project projet = new Project(0, nom, description, dateDebut, dateFin, budget);
                projetDAO.addProjet(projet);
            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Project projet = new Project(id, nom, description, dateDebut, dateFin, budget);
                projetDAO.updateProjet(projet);
            }

            response.sendRedirect("projet");
        } catch (Exception e) {
            System.out.println("Error processing project: " + e.getMessage());
            response.sendRedirect("projet");
        }
    }

    // Helper method to get a project by ID
    private Project getProjetById(int id) {
        String sql = "SELECT * FROM projet WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Project projet = new Project();
                projet.setId(rs.getInt("id"));
                projet.setNom(rs.getString("nom"));
                projet.setDescription(rs.getString("description"));
                projet.setDateDebut(rs.getDate("date_debut"));
                projet.setDateFin(rs.getDate("date_fin"));
                projet.setBudget(rs.getDouble("budget"));
                return projet;
            }
        } catch (SQLException e) {
            System.out.println("Error fetching project by ID: " + e.getMessage());
        }
        return null;
    }
}