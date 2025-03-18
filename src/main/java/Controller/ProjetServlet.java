package Controller;

import DAO.ProjetDAO;
import Model.Project;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
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
        List<Project> projets = projetDAO.getAllProjets();
        request.setAttribute("projets", projets);
        request.getRequestDispatcher("projectList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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

            Project projet = new Project(0, nom, description, dateDebut, dateFin, budget);
            int newProjectId = projetDAO.addProjet(projet); // Get the newly inserted ID
            if (newProjectId != -1) {
                response.sendRedirect("tache?projetId=" + newProjectId); // Redirect to task list with new ID
            } else {
                response.sendRedirect("projet"); // Fallback if insertion fails
            }
        } catch (Exception e) {
            System.out.println("Error adding project: " + e.getMessage());
            response.sendRedirect("projet");
        }
    }
}