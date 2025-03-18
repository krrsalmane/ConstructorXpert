package DAO;

import Model.Project; // Adjusted to match earlier code
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

            // Get the generated ID
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // Return the new project's ID
            }
        } catch (SQLException e) {
            System.out.println("Error adding project: " + e.getMessage());
        }
        return -1; // Return -1 if insertion fails
    }





}