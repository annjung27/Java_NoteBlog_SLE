package com.annie.sleblog.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.annie.sleblog.models.LoginUser;
import com.annie.sleblog.models.User;
import com.annie.sleblog.services.UserService;

@Controller
public class LoginController {
	
	@Autowired
	private UserService userService;
	
	


	//Display: Render Login Page and Register page
	
	@GetMapping("/login")
	public String loginPage(Model model) {
		
		// Bind empty User and loginUser objects to the JSP to capture the form input		
		model.addAttribute("newLogin", new LoginUser()); //passing empty object
		return "login.jsp";
	}
	
	@GetMapping("/register")
	public String registerPage(Model model) {
		
		// Bind empty User and loginUser objects to the JSP to capture the form input
		model.addAttribute("newUser", new User());  // passing empty object
		
		return "register.jsp";
	}
	
	// Action: Register new user
	@PostMapping("/register")
	public String register(@Valid @ModelAttribute("newUser") User newUser,
							BindingResult result, Model model, HttpSession session) {

		// execute the Service to Register FIRST!
		userService.register(newUser, result);
		
		// then check for errors
		if(result.hasErrors()) {
			
			model.addAttribute("newLogin", new LoginUser());
			return "register.jsp";
		} else {
			session.setAttribute("user_id", newUser.getId());
			return "redirect:/mynotes";		}	
		
		
	}
	
	// Action: Login User
	@PostMapping("/login")
	public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin,
							BindingResult result, Model model, HttpSession session) {
		User user = userService.login(newLogin, result);
		
		
		if(result.hasErrors()) {
			model.addAttribute("newUser", new User());
			return "login.jsp";
		} else {
			session.setAttribute("user_id", user.getId());
			return "redirect:/main";
		}
				
		
	}	
	
	@GetMapping("/logout")
	public String logout(HttpSession s) {
		s.invalidate();
		return "redirect:/main";
	}
	

}
