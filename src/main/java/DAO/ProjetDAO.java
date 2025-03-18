package DAO;

import Model.Project; // Adjusted to match your package
import Util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ProjetDAO {

    // Add a new project and return its generated ID
    public int addProjet(Project projet) {
        String sql = "INSERT INTO projet (nom, description, date_debut, date_fin, budget) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, projet.getNom());
            stmt.setString(2, projet.getDescription());
            stmt.setDate(3, new java.sql.Date(projet.getDateDebut().getTime()));
            stmt.setDate(4, new java.sql.Date(projet.getDateFin().getTime()));
            stmt.setDouble(5, projet.getBudget());
            stmt.executeUpdate();
            System.out.println("Project added: " + projet.getNom());

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error adding project: " + e.getMessage());
        }
        return -1;
    }

    // Get all projects
    public List<Project> getAllProjets() {
        List<Project> projets = new ArrayList<>();
        String sql = "SELECT * FROM projet";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Project projet = new Project();
                projet.setId(rs.getInt("id"));
                projet.setNom(rs.getString("nom"));
                projet.setDescription(rs.getString("description"));
                projet.setDateDebut(rs.getDate("date_debut"));
                projet.setDateFin(rs.getDate("date_fin"));
                projet.setBudget(rs.getDouble("budget"));
                projets.add(projet);
            }
        } catch (SQLException e) {
            System.out.println("Error getting projects: " + e.getMessage());
        }
        return projets;
    }

    // Update a project
    public void updateProjet(Project projet) {
        String sql = "UPDATE projet SET nom = ?, description = ?, date_debut = ?, date_fin = ?, budget = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, projet.getNom());
            stmt.setString(2, projet.getDescription());
            stmt.setDate(3, new java.sql.Date(projet.getDateDebut().getTime()));
            stmt.setDate(4, new java.sql.Date(projet.getDateFin().getTime()));
            stmt.setDouble(5, projet.getBudget());
            stmt.setInt(6, projet.getId());
            stmt.executeUpdate();
            System.out.println("Project updated: " + projet.getNom());
        } catch (SQLException e) {
            System.out.println("Error updating project: " + e.getMessage());
        }
    }


    }
}