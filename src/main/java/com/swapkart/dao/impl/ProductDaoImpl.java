package com.swapkart.dao.impl;

import com.swapkart.dao.ProductDao;
import com.swapkart.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.util.ArrayList;
import java.util.List;

@Repository
public class ProductDaoImpl implements ProductDao {

    @Autowired 
    private JdbcTemplate jdbcTemplate;

    // ==========================================
    // 1. PRODUCT CORE LOGIC
    // ==========================================

    @Override
    public boolean saveProduct(Product p) {
        String sql = "INSERT INTO products (title, category, price, description, image, sellerName, sellerContact, status) VALUES (?, ?, ?, ?, ?, ?, ?, 'Available')";
        return jdbcTemplate.update(sql, p.getTitle(), p.getCategory(), p.getPrice(), p.getDescription(), p.getImage(), p.getSellerName(), p.getSellerContact()) > 0;
    }

    @Override
    public Product getProductById(int id) {
        String sql = "SELECT * FROM products WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Product.class), id);
    }

    @Override
    public boolean deleteProduct(int id) {
        return jdbcTemplate.update("DELETE FROM products WHERE id = ?", id) > 0;
    }

    @Override
    public List<Product> searchAndFilter(String kw, String cat, String sort) {
        String sql = "SELECT * FROM products WHERE status = 'Available'";
        if (kw != null && !kw.isEmpty()) sql += " AND title LIKE '%" + kw + "%'";
        if (cat != null && !cat.equals("All")) sql += " AND category = '" + cat + "'";
        if ("lowToHigh".equals(sort)) sql += " ORDER BY price ASC";
        if ("highToLow".equals(sort)) sql += " ORDER BY price DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Product.class));
    }

    @Override
    public List<Product> getProductsBySeller(String name, String contact) {
        String sql = "SELECT * FROM products WHERE sellerName = ? AND sellerContact = ?";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Product.class), name, contact);
    }

    @Override
    public boolean updateStatus(int id, String s) {
        return jdbcTemplate.update("UPDATE products SET status = ? WHERE id = ?", s, id) > 0;
    }

    // ==========================================
    // 2. CART SYSTEM
    // ==========================================

    @Override
    public boolean addToCart(int userId, int productId) {
        return jdbcTemplate.update("INSERT INTO cart(user_id, product_id) VALUES(?,?)", userId, productId) > 0;
    }

    @Override
    public List<CartItem> getCartByUserId(int userId) {
        try {
            String sql = "SELECT c.id as cartId, p.* FROM cart c JOIN products p ON c.product_id = p.id WHERE c.user_id = ?";
            return jdbcTemplate.query(sql, (rs, rowNum) -> {
                CartItem item = new CartItem();
                item.setCartId(rs.getInt("cartId"));
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setTitle(rs.getString("title"));
                p.setPrice(rs.getDouble("price"));
                p.setImage(rs.getString("image"));
                p.setSellerName(rs.getString("sellerName"));
                item.setProduct(p);
                return item;
            }, userId);
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }

    @Override
    public boolean removeFromCart(int cartId) {
        return jdbcTemplate.update("DELETE FROM cart WHERE id = ?", cartId) > 0;
    }

    @Override
    public boolean clearCart(int userId) {
        return jdbcTemplate.update("DELETE FROM cart WHERE user_id = ?", userId) > 0;
    }

    // ==========================================
    // 3. WISHLIST SYSTEM
    // ==========================================

    @Override
    public boolean addToWishlist(int userId, int productId) {
        // Prevent Duplicates
        String check = "SELECT count(*) FROM wishlist WHERE user_id=? AND product_id=?";
        int count = jdbcTemplate.queryForObject(check, Integer.class, userId, productId);
        if (count > 0) return true;

        return jdbcTemplate.update("INSERT INTO wishlist(user_id, product_id) VALUES(?,?)", userId, productId) > 0;
    }

    @Override
    public List<Product> getWishlist(int userId) {
        String sql = "SELECT p.* FROM wishlist w JOIN products p ON w.product_id = p.id WHERE w.user_id = ?";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Product.class), userId);
    }

    @Override
    public boolean removeFromWishlist(int userId, int productId) {
        return jdbcTemplate.update("DELETE FROM wishlist WHERE user_id = ? AND product_id = ?", userId, productId) > 0;
    }

    // ==========================================
    // 4. ORDER & SHIPPING LOGIC (NO MORE "NA")
    // ==========================================

    @Override
    public boolean saveOrder(Order o) {
        String sql = "INSERT INTO orders(user_id, product_id, amount, status, transaction_id, " +
                     "shippingName, shippingMobile, shippingAddress, city, state, pincode) " +
                     "VALUES(?,?,?,'Processing',?,?,?,?,?,?,?)";
        return jdbcTemplate.update(sql, 
            o.getUserId(), o.getProductId(), o.getAmount(), o.getTransactionId(), 
            o.getShippingName(), o.getShippingMobile(), o.getShippingAddress(), 
            o.getCity(), o.getState(), o.getPincode()
        ) > 0;
    }

    @Override
    public List<Order> getOrdersByUserId(int userId) {
        String sql = "SELECT o.*, p.title as productTitle, p.image as productImage FROM orders o " +
                     "JOIN products p ON o.product_id = p.id WHERE o.user_id = ? ORDER BY o.id DESC";
        
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Order o = new Order();
            o.setId(rs.getInt("id"));
            o.setAmount(rs.getDouble("amount"));
            o.setStatus(rs.getString("status"));
            o.setTransactionId(rs.getString("transaction_id"));
            o.setOrderDate(rs.getTimestamp("order_date"));
            o.setDeliveryOtp(rs.getString("delivery_otp"));
            // Shipping Mapping
            o.setShippingName(rs.getString("shippingName"));
            o.setShippingMobile(rs.getString("shippingMobile"));
            o.setShippingAddress(rs.getString("shippingAddress"));
            o.setCity(rs.getString("city"));
            o.setState(rs.getString("state"));
            o.setPincode(rs.getString("pincode"));
            // Join Data
            o.setProductTitle(rs.getString("productTitle"));
            o.setProductImage(rs.getString("productImage"));
            return o;
        }, userId);
    }

    // ==========================================
    // 5. DRIVER & LOGISTICS SYSTEM
    // ==========================================

    @Override
    public List<Order> getAvailableOrdersForDrivers() {
        String sql = "SELECT o.*, p.title as productTitle FROM orders o JOIN products p ON o.product_id = p.id WHERE o.status = 'Processing' AND o.driver_id IS NULL";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Order o = new Order();
            o.setId(rs.getInt("id"));
            o.setAmount(rs.getDouble("amount"));
            o.setShippingName(rs.getString("shippingName"));
            o.setShippingAddress(rs.getString("shippingAddress"));
            o.setCity(rs.getString("city"));
            o.setProductTitle(rs.getString("productTitle"));
            return o;
        });
    }

    @Override
    public boolean acceptOrder(int orderId, int driverId, String otp) {
        String sql = "UPDATE orders SET driver_id = ?, delivery_otp = ?, status = 'Out for Delivery' WHERE id = ?";
        return jdbcTemplate.update(sql, driverId, otp, orderId) > 0;
    }

    @Override
    public boolean completeDelivery(int orderId, String otp) {
        String sql = "UPDATE orders SET status = 'Delivered', delivery_otp = NULL WHERE id = ? AND delivery_otp = ?";
        return jdbcTemplate.update(sql, orderId, otp) > 0;
    }

    // ==========================================
    // 6. ADMIN DASHBOARD STATS
    // ==========================================

    @Override
    public List<Product> getAllProducts() {
        String sql = "SELECT * FROM products ORDER BY id DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Product.class));
    }

    @Override
    public List<Product> getAllProductsAdmin() {
        return getAllProducts();
    }

    @Override
    public int getTotalProducts() {
        return jdbcTemplate.queryForObject("SELECT COUNT(*) FROM products", Integer.class);
    }
    
   
}