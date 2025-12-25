package com.ksa.pfm.service;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.ksa.pfm.model.User;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletContext;

@Service
public class EmailService {
	
	@Autowired
	private JavaMailSender javaMailSender;
	
	public void sendEmail(String to, String subject, String htmlContent) {
		try {
	        MimeMessage message = javaMailSender.createMimeMessage();
	        MimeMessageHelper helper = new MimeMessageHelper(message, true);

	        helper.setTo(to);
	        helper.setSubject(subject);
	        helper.setText(htmlContent, true); // HTML content

	        javaMailSender.send(message);

	    } catch (MessagingException e) {
	        e.printStackTrace();
	    }
		
	}
	
	

    @Autowired
    private ServletContext servletContext;

    public void sendHtmlMail(String to, String subject, String name, String msg) throws Exception {

        // 1️⃣ Load from WEB-INF
        InputStream in = servletContext.getResourceAsStream("/WEB-INF/email/email-template.html");
        if (in == null) {
            throw new RuntimeException("Email template not found in WEB-INF");
        }

        // 2️⃣ Convert HTML to string
        String html = new String(in.readAllBytes(), StandardCharsets.UTF_8);

        // 3️⃣ Replace placeholders
        html = html.replace("{{name}}", name)
                   .replace("{{msg}}", msg);

        // 4️⃣ Create mail
        MimeMessage message = javaMailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

        helper.setTo(to);
        helper.setSubject(subject);
        helper.setText(html, true); // HTML enabled
        helper.setFrom("no-reply@mysite.com");

        // 5️⃣ Send
        javaMailSender.send(message);
    }
	
    public String loadOtpTemplate(String name, int otp) throws IOException {
        String path = "src/main/webapp/WEB-INF/email/otp-template.html";
        String html = Files.readString(Paths.get(path));

        html = html.replace("{{name}}", name);
        html = html.replace("{{otp}}", String.valueOf(otp));

        return html;
    }
    
    
    public void sendPasswordUpdatedEmail(User user) throws Exception {
        String path = "/WEB-INF/email/UpdatedPassword.html";
        InputStream in = servletContext.getResourceAsStream(path);
        if (in == null) throw new RuntimeException("Email template not found: " + path);

        String html = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        html = html.replace("{{name}}", user.getName());

        MimeMessage message = javaMailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
        helper.setTo(user.getEmail());
        helper.setSubject("Password Updated Successfully");
        helper.setText(html, true);
        helper.setFrom("no-reply@mysite.com");

        javaMailSender.send(message);
    }

}


