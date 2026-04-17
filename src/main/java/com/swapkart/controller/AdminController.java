package com.swapkart.controller;

import com.swapkart.dao.*;
import com.swapkart.model.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired private UserDao userDao;
    @Autowired private ProductDao productDao;
    @Autowired private JdbcTemplate jdbcTemplate;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model m) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) return "redirect:/login";

        // 1. DASHBOARD STATS
        m.addAttribute("totalUsers", userDao.getTotalUsers());
        m.addAttribute("totalProducts", productDao.getTotalProducts());
        m.addAttribute("platformBalance", userDao.getTotalPlatformBalance());

        // 2. USERS LIST
        m.addAttribute("allUsers", userDao.getAllUsers());

        // 3. INVENTORY LIST (All Products)
        m.addAttribute("allProducts", productDao.getAllProductsAdmin());
        String sql = "SELECT o.id, u.fullName, p.title as productTitle, p.image as productImage, " +
                "o.amount, o.status, o.shippingAddress, o.city " +
                "FROM orders o JOIN users u ON o.user_id = u.id JOIN products p ON o.product_id = p.id";
   
   List<Order> orders = jdbcTemplate.query(sql, (rs, rowNum) -> {
       Order o = new Order();
       o.setId(rs.getInt("id"));
       o.setShippingName(rs.getString("fullName")); 
       o.setProductTitle(rs.getString("productTitle"));     
       o.setProductImage(rs.getString("productImage")); 
       o.setAmount(rs.getDouble("amount"));
       o.setStatus(rs.getString("status"));
       o.setShippingAddress(rs.getString("shippingAddress"));
       o.setCity(rs.getString("city"));
       return o;
   }); // <-- Yeh parenthesis aur semicolon dhyan se check karo
   
   m.addAttribute("allOrders", orders); // Ab yahan red line nahi aayegi
   return "admin-dashboard";
}

    @GetMapping("/updateOrderStatus")
    public String updateStatus(@RequestParam("id") int id, @RequestParam("status") String status) {
        jdbcTemplate.update("UPDATE orders SET status = ? WHERE id = ?", status, id);
        return "redirect:/admin/dashboard";
    }

    @GetMapping("/deleteUser")
    public String deleteUser(@RequestParam("id") int id) {
        jdbcTemplate.update("DELETE FROM users WHERE id = ?", id);
        return "redirect:/admin/dashboard";
    }
}