package com.swapkart.controller;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.swapkart.dao.ProductDao;
import com.swapkart.model.Product;
import com.swapkart.model.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.util.List;
import java.util.Map;

@Controller
public class ProductController {

    @Autowired private ProductDao productDao;
    @Autowired private JdbcTemplate jdbcTemplate;

    // --- CLOUDINARY CONFIGURATION (Bhai apni details yahan dalo) ---
 // ProductController.java ke andar yahan replace karein
    private Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
        "cloud_name", "dsnpryw3n", 
        "api_key", "374856288489461", 
        "api_secret", "qnzjjopY2VREihjvN3xiiLU8lRs" // 👁️ icon pe click karke copy karo
    ));

    // 1. Browse Products (Explore Page)
    @GetMapping("/products")
    public String browse(@RequestParam(value="keyword", required=false) String kw, 
                         @RequestParam(value="category", defaultValue="All") String cat, 
                         @RequestParam(value="sortBy", required=false) String sort, Model m) {
        m.addAttribute("list", productDao.searchAndFilter(kw, cat, sort));
        return "buy-products";
    }

    // 2. Show Sell Form
    @GetMapping("/sell")
    public String sell(HttpSession ses) {
        return (ses.getAttribute("user") == null) ? "redirect:/login" : "sell-product";
    }

    // 3. Handle Product Sale (Cloudinary Upload + Dynamic Specs)
    @PostMapping("/sellProduct")
    public String doSell(HttpServletRequest request, 
                         @RequestParam("title") String t, 
                         @RequestParam("category") String c, 
                         @RequestParam("price") double p, 
                         @RequestParam("description") String baseDesc, 
                         @RequestParam("image") MultipartFile img, 
                         HttpSession ses) {
        try {
            User u = (User) ses.getAttribute("user");
            if(u == null) return "redirect:/login";

            // A. DYNAMIC SPECIFICATIONS LOGIC
            StringBuilder specs = new StringBuilder();
            specs.append("--- TECHNICAL SPECIFICATIONS ---\n");
            String[] possibleParams = {"brand", "ram", "storage", "model", "year", "km", "fuel", "size"};
            boolean hasExtra = false;
            for(String param : possibleParams) {
                String val = request.getParameter(param);
                if(val != null && !val.trim().isEmpty()) {
                    specs.append("• ").append(param.toUpperCase()).append(": ").append(val).append("\n");
                    hasExtra = true;
                }
            }
            String finalDesc = hasExtra ? specs.toString() + "\n--- DESCRIPTION ---\n" + baseDesc : baseDesc;

            // B. CLOUDINARY IMAGE UPLOAD (No Local Folder Needed)
            Map uploadResult = cloudinary.uploader().upload(img.getBytes(), ObjectUtils.emptyMap());
            String imageUrl = (String) uploadResult.get("secure_url"); 

            // C. SAVE TO DATABASE
            Product pr = new Product(); 
            pr.setTitle(t); pr.setCategory(c); pr.setPrice(p); 
            pr.setDescription(finalDesc); 
            pr.setImage(imageUrl); // Saving Full Cloud URL
            pr.setSellerName(u.getFullName()); 
            pr.setSellerContact(u.getMobile());
            
            productDao.saveProduct(pr); 
            return "redirect:/products";

        } catch(Exception e) { 
            System.err.println("Cloudinary/Sell Error: " + e.getMessage());
            e.printStackTrace(); 
            return "error"; 
        }
    }

    // 4. Other Functional Mappings
    @GetMapping("/product/details")
    public String det(@RequestParam("id") int id, Model m) {
        m.addAttribute("p", productDao.getProductById(id));
        return "product-details";
    }

    @GetMapping("/my-orders")
    public String myOrders(HttpSession s, Model m) {
        User u = (User) s.getAttribute("user");
        if(u == null) return "redirect:/login";
        m.addAttribute("orders", productDao.getOrdersByUserId(u.getId()));
        return "my-orders";
    }

    @GetMapping("/my-ads")
    public String myAds(HttpSession s, Model m) {
        User u = (User) s.getAttribute("user");
        if(u == null) return "redirect:/login";
        m.addAttribute("list", productDao.getProductsBySeller(u.getFullName(), u.getMobile()));
        return "my-ads";
    }

    @GetMapping("/addToWishlist")
    public String addWish(@RequestParam("id") int pId, HttpSession s) {
        User u = (User) s.getAttribute("user");
        if(u != null) productDao.addToWishlist(u.getId(), pId);
        return "redirect:/products";
    }

    @GetMapping("/wishlist")
    public String viewWish(HttpSession s, Model m) {
        User u = (User) s.getAttribute("user");
        if(u == null) return "redirect:/login";
        m.addAttribute("list", productDao.getWishlist(u.getId()));
        return "wishlist";
    }

    @GetMapping("/becomeDriver")
    public String becomeDriver(HttpSession s) {
        User u = (User) s.getAttribute("user");
        if(u != null) {
            jdbcTemplate.update("UPDATE users SET role = 'DRIVER' WHERE id = ?", u.getId());
            u.setRole("DRIVER");
            s.setAttribute("user", u);
        }
        return "redirect:/driver/dashboard";
    }
    
    @GetMapping("/deleteProduct")
    public String del(@RequestParam("id") int id) {
        productDao.deleteProduct(id);
        return "redirect:/my-ads";
    }
}