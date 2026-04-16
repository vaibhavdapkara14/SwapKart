package com.swapkart.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import javax.sql.DataSource;
import java.util.Properties;

@Configuration
@ComponentScan(basePackages = "com.swapkart")
public class AppConfig {

	@Bean
	public DataSource dataSource() {
	    DriverManagerDataSource dataSource = new DriverManagerDataSource();
	    dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
	    
	    // Aiven ki details yahan set karein
	    dataSource.setUrl("jdbc:mysql://swapkart-dapkaravaibhav-fa41.d.aivencloud.com:17738/defaultdb?ssl-mode=REQUIRED");
	    dataSource.setUsername("avnadmin");
	    dataSource.setPassword("AVNS_57It5_dn7wIqYEQP-Mh"); // Reveal karke yahan dalo
	    
	    return dataSource;
	}

    @Bean
    public JdbcTemplate jdbcTemplate(DataSource dataSource) {
        return new JdbcTemplate(dataSource);
    }

 
    @Bean
    public JavaMailSender javaMailSender() {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost("smtp.gmail.com");
        mailSender.setPort(587);
        
       
        mailSender.setUsername("dapkaravaibhav901@gmail.com"); 
        
        // APNA GMAIL "APP PASSWORD" DAALEIN (Normal password nahi chalega)
        mailSender.setPassword("vtrt evxq twss wnwb"); 

        Properties props = mailSender.getJavaMailProperties();
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.debug", "true");

        return mailSender;
    }
}