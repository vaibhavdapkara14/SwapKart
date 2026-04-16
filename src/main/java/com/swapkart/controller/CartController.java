package com.swapkart.controller;

import com.swapkart.dao.*;
import com.swapkart.model.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@Controller
public class CartController {

    @Autowired private ProductDao productDao;
    @Autowired private UserDao userDao;

    // 1. Add to Cart
    @GetMapping("/addToCart")
    public String add(@RequestParam("id") int productId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";
        productDao.addToCart(user.getId(), productId);
        return "redirect:/cart";
    }

    // 2. View Cart Page
    @GetMapping("/cart")
    public String viewCart(HttpSession session, Model m) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";
        List<CartItem> list = productDao.getCartByUserId(user.getId());
        m.addAttribute("cartList", list);
        m.addAttribute("totalPrice", (list != null && !list.isEmpty()) ? list.stream().mapToDouble(i -> i.getProduct().getPrice()).sum() : 0);
        return "cart";
    }

    // 3. REMOVE FROM CART (Yeh missing tha, isliye 404 aa raha tha)
    @GetMapping("/removeFromCart")
    public String remove(@RequestParam("id") int cartId) {
        productDao.removeFromCart(cartId);
        return "redirect:/cart";
    }

    // 4. Checkout (Address Page)
    @GetMapping("/checkout")
    public String checkout(HttpSession session, Model m) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";
        List<CartItem> list = productDao.getCartByUserId(user.getId());
        if(list == null || list.isEmpty()) return "redirect:/products";
        m.addAttribute("totalPrice", list.stream().mapToDouble(i -> i.getProduct().getPrice()).sum());
        return "checkout";
    }

    // 5. Payment Success Handler
    @GetMapping("/paymentSuccess")
    public String success(
            @RequestParam("pay_id") String payId, 
            @RequestParam(value="name", defaultValue="Customer") String name,
            @RequestParam(value="mobile", defaultValue="NA") String mobile,
            @RequestParam(value="address", defaultValue="Home") String address,
            @RequestParam(value="city", defaultValue="") String city,
            @RequestParam(value="state", defaultValue="") String state,
            @RequestParam(value="pincode", defaultValue="") String pincode,
            HttpSession session) {
        
        User buyer = (User) session.getAttribute("user");
        if (buyer == null) return "redirect:/login"; // Deployment par session out handle karne ke liye

        List<CartItem> items = productDao.getCartByUserId(buyer.getId());
        if(items == null || items.isEmpty()) return "redirect:/"; // Safety check

        for (CartItem ci : items) {
            Product p = productDao.getProductById(ci.getProduct().getId());
            userDao.updateWallet(p.getSellerName(), p.getPrice());
            productDao.updateStatus(p.getId(), "Sold");

            Order o = new Order();
            o.setUserId(buyer.getId()); 
            o.setProductId(p.getId()); 
            o.setAmount(p.getPrice());
            o.setTransactionId(payId); 
            o.setShippingName(name); 
            o.setShippingMobile(mobile);
            o.setShippingAddress(address); 
            o.setCity(city);
            o.setState(state); 
            o.setPincode(pincode);
            productDao.saveOrder(o);
        }
        productDao.clearCart(buyer.getId());
        return "order-success";
    }
}