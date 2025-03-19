package Controller;

import DAO.TacheDAO;
import DAO.ProjetDAO;
import Model.Tache;
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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/tache")
public class TacheServlet extends HttpServlet {
    private TacheDAO tacheDAO;
    private ProjetDAO projetDAO;

    @Override
    public void init() throws ServletException {
        tacheDAO = new TacheDAO();
        projetDAO = new ProjetDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String projetIdStr = request.getParameter("projetId");
        String idStr = request.getParameter("id");
        int projetId = 0;

        try {
            projetId = Integer.parseInt(projetIdStr);

            if ("edit".equals(action) && idStr != null) {
                int id = Integer.parseInt(idStr);
                Tache tacheToEdit = getTacheById(id); // Helper method to fetch a single task
                request.setAttribute("tacheToEdit", tacheToEdit);
            } else if ("delete".equals(action) && idStr != null) {
                int id = Integer.parseInt(idStr);
                tacheDAO.deleteTache(id);
            }

            List<Tache> taches = tacheDAO.getTachesByProjetId(projetId);
            List<Project> projets = projetDAO.getAllProjets();
            request.setAttribute("taches", taches);
            request.setAttribute("projetId", projetId);
            request.setAttribute("projets", projets);
            request.getRequestDispatcher("taskList.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            List<Project> projets = projetDAO.getAllProjets();
            request.setAttribute("projets", projets);
            request.setAttribute("taches", new ArrayList<Tache>());
            request.setAttribute("projetId", null);
            request.getRequestDispatcher("taskList.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String projectIdStr = request.getParameter("project_id");
        String description = request.getParameter("description");
        String dateDebutStr = request.getParameter("dateDebut");
        String dateFinStr = request.getParameter("dateFin");
        String idStr = request.getParameter("id");

        try {
            int projectId = Integer.parseInt(projectIdStr);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date dateDebut = sdf.parse(dateDebutStr);
            Date dateFin = sdf.parse(dateFinStr);

            if ("add".equals(action)) {
                Tache tache = new Tache(0, projectId, description, dateDebut, dateFin);
                tacheDAO.addTache(tache);
            } else if ("update".equals(action) && idStr != null) {
                int id = Integer.parseInt(idStr);
                Tache tache = new Tache(id, projectId, description, dateDebut, dateFin);
                tacheDAO.updateTache(tache);
            }

            response.sendRedirect("tache?projetId=" + projectId);
        } catch (Exception e) {
            System.out.println("Error processing task: " + e.getMessage());
            response.sendRedirect("tache?projetId=" + projectIdStr);
        }
    }

    // Helper method to get a task by ID
    private Tache getTacheById(int id) {
        String sql = "SELECT * FROM tache WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Tache tache = new Tache();
                tache.setId(rs.getInt("id"));
                tache.setProjetId(rs.getInt("projet_id"));
                tache.setDescription(rs.getString("description"));
                tache.setDateDebut(rs.getDate("date_debut"));
                tache.setDateFin(rs.getDate("date_fin"));
                return tache;
            }
        } catch (Exception e) {
            System.out.println("Error fetching task by ID: " + e.getMessage());
        }
        return null;
    }
}