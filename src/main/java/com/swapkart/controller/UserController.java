package com.swapkart.controller;

import com.swapkart.dao.UserDao;
import com.swapkart.model.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.UUID;

@Controller
public class UserController {

    @Autowired private UserDao userDao;
    @Autowired private JavaMailSender mailSender;

    @GetMapping("/register") public String reg() { return "register"; }
    
    @PostMapping("/doRegister") 
    public String doReg(@RequestParam("fullName") String n, @RequestParam("email") String e, 
                        @RequestParam("mobile") String m, @RequestParam("password") String p, HttpSession session) {
        try {
            userDao.register(new User(n, e, m, p));
            return "redirect:/login?msg=Registration Successful!";
        } catch (Exception ex) {
            session.setAttribute("msg", "Error: Email might already exist!");
            return "redirect:/register";
        }
    }

    @GetMapping("/login") public String log() { return "login"; }
    
    @PostMapping("/doLogin") 
    public String doLog(@RequestParam("email") String e, @RequestParam("password") String p, HttpSession ses) {
        User u = userDao.login(e, p);
        if (u != null) { ses.setAttribute("user", u); return "redirect:/"; }
        ses.setAttribute("msg", "Invalid Credentials!"); return "redirect:/login";
    }

    @GetMapping("/profile") 
    public String prof(HttpSession ses, Model m) {
        User u = (User) ses.getAttribute("user");
        if(u == null) return "redirect:/login";
        
        // Fetch Saved Addresses for the profile page
        m.addAttribute("userAddresses", userDao.getUserAddresses(u.getId()));
        return "profile";
    }

    @PostMapping("/updateProfile") 
    public String upProf(@RequestParam("fullName") String n, @RequestParam("mobile") String m, HttpSession ses) {
        User u = (User) ses.getAttribute("user");
        if(u == null) return "redirect:/login";
        u.setFullName(n); u.setMobile(m);
        userDao.updateProfile(u);
        ses.setAttribute("user", u); 
        return "redirect:/profile?success=true";
    }

    @GetMapping("/logout") public String out(HttpSession ses) { ses.invalidate(); return "redirect:/login"; }

    // --- NEW: ADDRESS MANAGEMENT ---
    @PostMapping("/saveAddress")
    public String saveAddr(@ModelAttribute Address addr, HttpSession session) {
        User u = (User) session.getAttribute("user");
        if(u != null) {
            addr.setUserId(u.getId());
            userDao.saveUserAddress(addr);
        }
        return "redirect:/profile?msg=AddressSaved";
    }

    @GetMapping("/deleteAddress")
    public String deleteAddr(@RequestParam("id") int id) {
        userDao.deleteAddress(id);
        return "redirect:/profile";
    }

    // --- WALLET ---
    @GetMapping("/addToWallet")
    public String addMoney(@RequestParam("amount") double amount, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            double newBalance = user.getWalletBalance() + amount;
            userDao.updateWalletManual(user.getId(), newBalance);
            user.setWalletBalance(newBalance);
            session.setAttribute("user", user); 
        }
        return "redirect:/profile";
    }

    @GetMapping("/withdrawFromWallet")
    public String withdraw(@RequestParam("amount") double amount, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null && user.getWalletBalance() >= amount) {
            double newBalance = user.getWalletBalance() - amount;
            userDao.updateWalletManual(user.getId(), newBalance);
            user.setWalletBalance(newBalance);
            session.setAttribute("user", user);
        }
        return "redirect:/profile";
    }

    // --- FORGOT PASSWORD ---
    @GetMapping("/forgotPassword") public String showForgot() { return "forgot-password"; }

    @PostMapping("/forgotPassword")
    public String forgot(@RequestParam("email") String email) {
        String token = UUID.randomUUID().toString();
        if (userDao.setResetToken(email, token)) {
            String resetLink = "http://localhost:8080/Spring_cart/resetPassword?token=" + token;
            sendEmail(email, "Reset Password", "Click here: " + resetLink);
            return "redirect:/login?msg=Reset link sent!";
        }
        return "redirect:/login?msg=Email not found!";
    }

    @GetMapping("/resetPassword")
    public String resetPage(@RequestParam("token") String token, Model m) {
        m.addAttribute("token", token);
        return "reset-password";
    }

    @PostMapping("/resetPassword")
    public String handleReset(@RequestParam("token") String token, @RequestParam("password") String pass) {
        return userDao.updatePasswordByToken(token, pass) ? "redirect:/login?msg=Updated!" : "error";
    }

    private void sendEmail(String to, String sub, String msg) {
        try {
            SimpleMailMessage m = new SimpleMailMessage();
            m.setTo(to); m.setSubject(sub); m.setText(msg);
            mailSender.send(m);
        } catch(Exception e) { e.printStackTrace(); }
    }
}