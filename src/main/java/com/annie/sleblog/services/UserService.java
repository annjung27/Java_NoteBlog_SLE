package com.annie.sleblog.services;

import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.annie.sleblog.models.LoginUser;
import com.annie.sleblog.models.Note;
import com.annie.sleblog.models.User;
import com.annie.sleblog.repositories.UserRepository;

@Service
public class UserService {
	@Autowired
	private UserRepository userRepository;
	
	public User register(User newUser, BindingResult result) {
		// Reject if the email is taken (present in the DB)
		Optional<User> potentialUser = userRepository.findByEmail(newUser.getEmail());
		if (potentialUser.isPresent()) {
			result.rejectValue("email", "registerErrors", "Email error");
		}
		
		// Reject if passwords don't match with confirm
		if(!newUser.getPassword().equals(newUser.getConfirm())) {
			result.rejectValue("confirm","registerErrors" , "this confirm pass must match the password");
		}
		
		// return null if result has errors
		if(result.hasErrors()) {
			return null;
		} else {
			//Hash and set Password, save user to the DB!
			String hashed = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
			newUser.setPassword(hashed);
			// Save User to the DB!!!!
			return userRepository.save(newUser);
		}
	
	}
	
	
	public User login(LoginUser newLoginObject, BindingResult result) {
		
		// Find the user in the DB
		Optional<User> potentialUser = userRepository.findByEmail(newLoginObject.getEmail());
		if(!potentialUser.isPresent()) {
			result.rejectValue("email","loginError", "login error!");
		} else {
			User user = potentialUser.get();
			// Reject if BCrypt PW match fails
			if(!BCrypt.checkpw(newLoginObject.getPassword(), user.getPassword())) {
				//reject
				result.rejectValue("password", "loginError", "login error");
			}
			
			// Return null if result has errors
			if(result.hasErrors()) {
				return null;
			} else {
				// otherwise, return the user object
				return user;
			}
		}
		return null;		
	}
	
	
	// Find One
	public User findOne(Long id) {
		Optional<User> potentialUser = userRepository.findById(id);
		if(potentialUser.isPresent()) {
			return potentialUser.get();
		} else {
			return null;
		}
	}
	
	// add note to user
	public User saveUser(User user){						
		return userRepository.save(user);
	}
}
