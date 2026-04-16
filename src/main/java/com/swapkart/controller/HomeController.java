package com.swapkart.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home() {
        return "index";
    }

    /**
     * Yeh method poore project ki theme switch karega.
     * Ek baar click karne par session mein value save ho jayegi
     * aur har page par dark/light mode maintain rahega.
     */
    @GetMapping("/toggleTheme")
    public String toggleTheme(HttpSession session, HttpServletRequest request) {
        // Session se check karo abhi kaunsi theme chal rahi hai
        String currentTheme = (String) session.getAttribute("theme");
        
        // Agar pehle se dark hai to light kardo, warna dark kardo
        if ("dark".equals(currentTheme)) {
            session.setAttribute("theme", "light");
        } else {
            session.setAttribute("theme", "dark");
        }
        
        // Yeh logic user ko usi page par wapas bhej dega jahan se usne click kiya tha
        String referer = request.getHeader("Referer");
        
        // Agar referer null hai (direct link) to home par bhej do
        if (referer == null) {
            return "redirect:/";
        }
        
        return "redirect:" + referer;
    }
}