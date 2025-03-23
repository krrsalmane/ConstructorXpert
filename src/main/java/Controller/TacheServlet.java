package Controller;

import DAO.TacheDAO;
import DAO.ProjetDAO;
import DAO.RessourceDAO;
import Model.Tache;
import Model.Project;
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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/tache")
public class TacheServlet extends HttpServlet {
    private TacheDAO tacheDAO;
    private ProjetDAO projetDAO;
    private RessourceDAO ressourceDAO;

    @Override
    public void init() throws ServletException {
        tacheDAO = new TacheDAO();
        projetDAO = new ProjetDAO();
        ressourceDAO = new RessourceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String projetIdStr = request.getParameter("projetId");
        int projetId = 0;

        if ("new".equals(action)) {
            List<Project> projets = projetDAO.getAllProjets();
            request.setAttribute("projets", projets);
            request.getRequestDispatcher("CreateTask.jsp").forward(request, response);
            return;
        }

        try {
            projetId = Integer.parseInt(projetIdStr);
            String idStr = request.getParameter("id");

            if ("edit".equals(action) && idStr != null) {
                int id = Integer.parseInt(idStr);
                Tache tacheToEdit = getTacheById(id);
                request.setAttribute("tacheToEdit", tacheToEdit);
                request.setAttribute("projetId", projetId);
                request.getRequestDispatcher("EditTask.jsp").forward(request, response);
                return;
            } else if ("delete".equals(action) && idStr != null) {
                int id = Integer.parseInt(idStr);
                tacheDAO.deleteTache(id);
            }

            List<Tache> taches = tacheDAO.getTachesByProjetId(projetId);
            List<Project> projets = projetDAO.getAllProjets();
            request.setAttribute("taches", taches);
            request.setAttribute("projetId", projetId);
            request.setAttribute("projets", projets);
            request.getRequestDispatcher("TaskList.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            List<Project> projets = projetDAO.getAllProjets();
            request.setAttribute("projets", projets);
            request.setAttribute("taches", new ArrayList<Tache>());
            request.setAttribute("projetId", null);
            request.getRequestDispatcher("TaskList.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("addResourceForProject".equals(action)) {
            try {
                String nom = request.getParameter("nom");
                String type = request.getParameter("type");
                int quantite = Integer.parseInt(request.getParameter("quantite"));
                String infoFournisseur = request.getParameter("infoFournisseur");
                int taskId = Integer.parseInt(request.getParameter("taskId")); // Changed from projetId
                int quantiteAssignee = Integer.parseInt(request.getParameter("quantiteAssignee")); // Add this if needed

                Ressource ressource = new Ressource(0, nom, type, quantite, infoFournisseur);
                int resourceId = ressourceDAO.addRessource(ressource);
                try (Connection conn = DBConnection.getConnection();
                     PreparedStatement stmt = conn.prepareStatement(
                             "INSERT INTO tache_ressource (tache_id, ressource_id, quantite_assignee) VALUES (?, ?, ?)")) {
                    stmt.setInt(1, taskId);
                    stmt.setInt(2, resourceId);
                    stmt.setInt(3, quantiteAssignee);
                    stmt.executeUpdate();
                } catch (Exception e) {
                    System.out.println("Error linking resource to task: " + e.getMessage());
                }
                ressourceDAO.updateQuantity(resourceId, -quantiteAssignee);

                response.sendRedirect("ressource?taskId=" + taskId + "&newResourceId=" + resourceId);
            } catch (Exception e) {
                System.out.println("Error adding resource for task: " + e.getMessage());
                response.sendRedirect("ressource?taskId=" + request.getParameter("taskId"));
            }
            return;
        }

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