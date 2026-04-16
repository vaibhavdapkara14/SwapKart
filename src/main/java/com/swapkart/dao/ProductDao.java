package com.swapkart.dao;

import com.swapkart.model.*;
import java.util.List;

public interface ProductDao {
    // 1. Basic Product Logic
    boolean saveProduct(Product p);
    Product getProductById(int id);
    boolean deleteProduct(int id);
    List<Product> searchAndFilter(String kw, String cat, String sort);
    List<Product> getProductsBySeller(String name, String contact);
    boolean updateStatus(int id, String s);

    // 2. Cart System
    boolean addToCart(int userId, int productId);
    List<CartItem> getCartByUserId(int userId);
    boolean removeFromCart(int cartId);
    boolean clearCart(int userId);

    // 3. Wishlist System
    boolean addToWishlist(int userId, int productId);
    List<Product> getWishlist(int userId);
    boolean removeFromWishlist(int userId, int productId);

    // 4. Order & Shipping
    boolean saveOrder(Order o);
    List<Order> getOrdersByUserId(int userId);
    
    // 5. Driver & Logistics
    List<Order> getAvailableOrdersForDrivers();
    boolean acceptOrder(int orderId, int driverId, String otp);
    boolean completeDelivery(int orderId, String otp);

    // 6. Admin Panel (YAHAN PEHLE METHOD MISSING THA)
    List<Product> getAllProducts(); 
    List<Product> getAllProductsAdmin();
    int getTotalProducts();
}