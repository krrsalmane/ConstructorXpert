package DAO;
import Model.Tache;
import Util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TacheDAO {

    public void addTache(Tache tache) {
        String sql = "INSERT INTO tache (projet_id, description, date_debut, date_fin) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, tache.getProjetId());
            stmt.setString(2, tache.getDescription());
            stmt.setDate(3, new java.sql.Date(tache.getDateDebut().getTime()));
            stmt.setDate(4, new java.sql.Date(tache.getDateFin().getTime()));
            stmt.executeUpdate();
            System.out.println("Task added: " + tache.getDescription());
        } catch (Exception e) {
            System.out.println("Error adding task: " + e.getMessage());
        }
    }



}
