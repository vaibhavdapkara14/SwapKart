package com.swapkart.dao;

import com.swapkart.model.User;
import com.swapkart.model.Address;
import java.util.List;

public interface UserDao {
    // Authentication & Profile
    boolean register(User user);
    User login(String email, String password);
    boolean updateProfile(User user);
    
    // Wallet Logic
    boolean updateWallet(String sellerName, double amount);
    boolean updateWalletManual(int userId, double newAmount);
    
    // Forgot Password
    boolean setResetToken(String email, String token);
    boolean updatePasswordByToken(String token, String newPassword);
    
    // Saved Address Logic (NEW)
    boolean saveUserAddress(Address address);
    List<Address> getUserAddresses(int userId);
    boolean deleteAddress(int addressId);

    // Admin Stats
    List<User> getAllUsers();
    int getTotalUsers();
    double getTotalPlatformBalance();
}