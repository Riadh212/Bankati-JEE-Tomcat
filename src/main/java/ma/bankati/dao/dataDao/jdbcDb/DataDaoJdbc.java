package ma.bankati.dao.dataDao.jdbcDb;

import ma.bankati.config.DatabaseConnection;
import ma.bankati.dao.dataDao.IDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DataDaoJdbc implements IDao {

    @Override
    public double fetchData() {
        String sql = "SELECT SUM(amount) AS total FROM money_data";
        double total = 0;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                total = rs.getDouble("total");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return total;
    }
}