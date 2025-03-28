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


    public List<Tache> getTachesByProjetId(int projetId) {
        List<Tache> taches = new ArrayList<>();
        String sql = "SELECT * FROM tache WHERE projet_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, projetId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Tache tache = new Tache();
                tache.setId(rs.getInt("id"));
                tache.setProjetId(rs.getInt("projet_id"));
                tache.setDescription(rs.getString("description"));
                tache.setDateDebut(rs.getDate("date_debut"));
                tache.setDateFin(rs.getDate("date_fin"));
                taches.add(tache);
            }
        } catch (Exception e) {
            System.out.println("Error getting tasks: " + e.getMessage());
        }
        return taches;
    }


    public void updateTache(Tache tache) {
        String sql = "UPDATE tache SET projet_id = ?, description = ?, date_debut = ?, date_fin = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, tache.getProjetId());
            stmt.setString(2, tache.getDescription());
            stmt.setDate(3, new java.sql.Date(tache.getDateDebut().getTime()));
            stmt.setDate(4, new java.sql.Date(tache.getDateFin().getTime()));
            stmt.setInt(5, tache.getId());
            stmt.executeUpdate();
            System.out.println("Task updated: " + tache.getDescription());
        } catch (Exception e) {
            System.out.println("Error updating task: " + e.getMessage());
        }
    }


    public void deleteTache(int id) {
        String sql = "DELETE FROM tache WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
            System.out.println("Task deleted with ID: " + id);
        } catch (Exception e) {
            System.out.println("Error deleting task: " + e.getMessage());
        }
    }

    public void addResourceToTask(int taskId, int resourceId, int quantity) {
        String sql = "INSERT INTO tache_ressource (taCHE_id, ressource_id, quantite_assignee) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, taskId);
            stmt.setInt(2, resourceId);
            stmt.setInt(3, quantity);
            stmt.executeUpdate();
            System.out.println("Resource " + resourceId + " added to task " + taskId);
        } catch (Exception e) {
            System.out.println("Error adding resource to task: " + e.getMessage());
        }
    }
}
