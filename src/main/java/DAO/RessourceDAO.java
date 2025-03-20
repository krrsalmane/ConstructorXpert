package DAO;
import Model.Ressource;
import Util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class RessourceDAO {

    // Add a new resource
    public void addRessource(Ressource ressource) {
        String sql = "INSERT INTO ressource (nom, type, quantite, info_fournisseur) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, ressource.getNom());
            stmt.setString(2, ressource.getType());
            stmt.setInt(3, ressource.getQuantite());
            stmt.setString(4, ressource.getInfoFournisseur());
            stmt.executeUpdate();
            System.out.println("Resource added: " + ressource.getNom());
        } catch (Exception e) {
            System.out.println("Error adding resource: " + e.getMessage());
        }
    }

    // Get all resources

}
