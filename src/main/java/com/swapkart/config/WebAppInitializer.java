package com.swapkart.config;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;
import jakarta.servlet.MultipartConfigElement;
import jakarta.servlet.ServletRegistration;

public class WebAppInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

    @Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class[]{AppConfig.class};
    }

    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class[]{WebMvcConfig.class};
    }

    @Override
    protected String[] getServletMappings() {
        // This ensures Spring handles all requests starting from the root
        return new String[]{"/"}; 
    }

    @Override
    protected void customizeRegistration(ServletRegistration.Dynamic registration) {
        // Location for temporary file uploads
        registration.setMultipartConfig(new MultipartConfigElement(""));
    }
}