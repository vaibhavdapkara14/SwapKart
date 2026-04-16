package com.swapkart.dao.impl;

import com.swapkart.dao.UserDao;
import com.swapkart.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class UserDaoImpl implements UserDao {

    @Autowired 
    private JdbcTemplate jdbcTemplate;

    @Override
    public boolean register(User u) {
        String sql = "INSERT INTO users(fullName, email, mobile, password, role, walletBalance) VALUES(?,?,?,?,'USER',0.0)";
        try {
            return jdbcTemplate.update(sql, u.getFullName(), u.getEmail(), u.getMobile(), u.getPassword()) > 0;
        } catch (Exception e) { return false; }
    }

    @Override
    public User login(String email, String password) {
        String sql = "SELECT * FROM users WHERE email=? AND password=?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(User.class), email, password);
        } catch (Exception e) { return null; }
    }

    @Override
    public boolean updateProfile(User u) {
        String sql = "UPDATE users SET fullName=?, mobile=? WHERE id=?";
        return jdbcTemplate.update(sql, u.getFullName(), u.getMobile(), u.getId()) > 0;
    }

    @Override
    public boolean updateWallet(String name, double amount) {
        String sql = "UPDATE users SET walletBalance = walletBalance + ? WHERE fullName=?";
        return jdbcTemplate.update(sql, amount, name) > 0;
    }

    @Override
    public boolean updateWalletManual(int userId, double newAmount) {
        String sql = "UPDATE users SET walletBalance = ? WHERE id = ?";
        return jdbcTemplate.update(sql, newAmount, userId) > 0;
    }

    @Override
    public boolean setResetToken(String email, String token) {
        String sql = "UPDATE users SET resetToken = ? WHERE email = ?";
        return jdbcTemplate.update(sql, token, email) > 0;
    }

    @Override
    public boolean updatePasswordByToken(String token, String newPassword) {
        String sql = "UPDATE users SET password = ?, resetToken = NULL WHERE resetToken = ?";
        return jdbcTemplate.update(sql, newPassword, token) > 0;
    }

    // --- SAVED ADDRESS METHODS (NEW) ---
    @Override
    public boolean saveUserAddress(Address a) {
        String sql = "INSERT INTO user_addresses(user_id, receiverName, receiverMobile, address, city, state, pincode) VALUES(?,?,?,?,?,?,?)";
        return jdbcTemplate.update(sql, a.getUserId(), a.getReceiverName(), a.getReceiverMobile(), a.getAddress(), a.getCity(), a.getState(), a.getPincode()) > 0;
    }

    @Override
    public List<Address> getUserAddresses(int userId) {
        String sql = "SELECT * FROM user_addresses WHERE user_id = ?";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Address.class), userId);
    }

    @Override
    public boolean deleteAddress(int addressId) {
        return jdbcTemplate.update("DELETE FROM user_addresses WHERE id = ?", addressId) > 0;
    }

    // --- ADMIN METHODS ---
    @Override
    public List<User> getAllUsers() {
        return jdbcTemplate.query("SELECT * FROM users", new BeanPropertyRowMapper<>(User.class));
    }

    @Override
    public int getTotalUsers() {
        return jdbcTemplate.queryForObject("SELECT COUNT(*) FROM users", Integer.class);
    }

    @Override
    public double getTotalPlatformBalance() {
        Double total = jdbcTemplate.queryForObject("SELECT SUM(walletBalance) FROM users", Double.class);
        return (total != null) ? total : 0.0;
    }
}