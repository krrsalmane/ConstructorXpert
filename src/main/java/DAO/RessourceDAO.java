package DAO;

import Model.Ressource;
import Util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RessourceDAO {
    // Existing methods (addRessource, updateRessource, etc.) remain unchanged

    public List<Ressource> getRessourcesByTaskId(int taskId) {
        List<Ressource> ressources = new ArrayList<>();
        String sql = "SELECT r.* FROM ressource r " +
                "JOIN tache_ressource tr ON r.id = tr.ressource_id " +
                "WHERE tr.tache_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, taskId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Ressource ressource = new Ressource();
                    ressource.setId(rs.getInt("id"));
                    ressource.setNom(rs.getString("nom"));
                    ressource.setType(rs.getString("type"));
                    ressource.setQuantite(rs.getInt("quantite"));
                    ressource.setInfoFournisseur(rs.getString("info_fournisseur"));
                    ressources.add(ressource);
                }
            }
        } catch (Exception e) {
            System.out.println("Error getting resources by task ID: " + e.getMessage());
        }
        return ressources;
    }

    // Ensure these methods are present from earlier
    public int addRessource(Ressource ressource) {
        String sql = "INSERT INTO ressource (nom, type, quantite, info_fournisseur) VALUES (?, ?, ?, ?)";
        int generatedId = 0;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, ressource.getNom());
            stmt.setString(2, ressource.getType());
            stmt.setInt(3, ressource.getQuantite());
            stmt.setString(4, ressource.getInfoFournisseur());
            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        generatedId = generatedKeys.getInt(1);
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Error adding resource: " + e.getMessage());
        }
        return generatedId;
    }

    public boolean updateQuantity(int ressourceId, int amount) {
        String sql = "UPDATE ressource SET quantite = quantite + ? WHERE id = ? AND (quantite + ?) >= 0";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, amount);
            stmt.setInt(2, ressourceId);
            stmt.setInt(3, amount);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error updating quantity: " + e.getMessage());
            return false;
        }
    }

    public boolean deleteRessource(int id) {
        String sql = "DELETE FROM ressource WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error deleting resource: " + e.getMessage());
            return false;
        }
    }
}