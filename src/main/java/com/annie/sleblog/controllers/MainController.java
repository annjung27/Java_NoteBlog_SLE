package com.annie.sleblog.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.annie.sleblog.models.Comment;
import com.annie.sleblog.models.Note;
import com.annie.sleblog.models.User;
import com.annie.sleblog.services.CommentService;
import com.annie.sleblog.services.NoteService;
import com.annie.sleblog.services.UserService;

@Controller
public class MainController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private NoteService noteService;
	@Autowired
	private CommentService commentService;

//--------------Redirect to Main --------------------------------------
	
	@RequestMapping("/")
	public String redirectToMain() {
		return "redirect:/main";
	}
	
// ------------------------Display: Main Page / Read All-------------------------------
	@GetMapping("/main")
	public String main(HttpSession session, Model model) {
		
		//find the user from session
//		Long userId = (Long) session.getAttribute("user_id");
		
		List<Note> allNotes = noteService.allNotes();
		
		model.addAttribute("allNotes", allNotes);		
		
		return "main.jsp";
	}
	

//----------------------- Display: My Note Page-----------------------------
	@GetMapping("/mynotes")
	public String myNotes(HttpSession s, Model m) {
		// retrieve the user from session
		Long userId = (Long) s.getAttribute("user_id");
		// check if userId is null (Route guard)
		if(userId == null) {
			return "redirect:/login";		
		} else {
			// go to the DB to retrieve the user using the id from session
			User thisUser = userService.findOne(userId);
//			List<Note> allNotes = noteService.allNotes();
			m.addAttribute("thisUser", thisUser);
//			m.addAttribute("allNotes", allNotes);		
	
			
			return "myNote.jsp";
		}
	}
	
//------------------Display: Show Detail view for one note---------------------------
	@GetMapping("/notes/{id}")
	public String showOneNote(@PathVariable("id") Long id, HttpSession session, Model model) {
		// retrieve the user from session
		Long userId = (Long) session.getAttribute("user_id");		
	
		
		Note thisNote = noteService.findNote(id);
//		List<Comment> allComments = commentService.allComments();
		model.addAttribute("thisNote", thisNote);
		model.addAttribute("comment", new Comment());
//		model.addAttribute("allComments", allComments);
		
		
		return "viewNote.jsp";
		
	}

//-------------------Display: Render New Note Form -----------------------------------
	@GetMapping("/mynotes/new")
	public String newNote(HttpSession s, Model m) {
		// retrieve the user from session
		Long userId = (Long) s.getAttribute("user_id");
		// check if userId is null (Route guard)
		if(userId == null) {
			return "redirect:/login";		
		} else {
			// go to the DB to retrieve the user using the id from session
			User thisUser = userService.findOne(userId);

			m.addAttribute("thisUser", thisUser);
			m.addAttribute("note", new Note());
			
			return "newNote.jsp";
		}				
		
	}		
//-----------------Action: Create New Note -------------------------------------
	@PostMapping("/mynotes/create")
	public String createNote(@Valid @ModelAttribute("note") Note note,
								BindingResult result, Model model,  HttpSession session){
		// grab the user again to send over again if there are errors
		Long userId=(Long) session.getAttribute("user_id");
		if(userId == null) {
			return "redirect:/login";
		}else {
			User thisLoggedInUser = userService.findOne(userId);
			model.addAttribute("thisLoggedInUser", thisLoggedInUser);
			if(result.hasErrors()) {
				
				return "newNote.jsp";
			} else {
				// put loggedInUser into the newNote
				note.setUser(thisLoggedInUser);
				noteService.createNote(note);
				// add note to user
				thisLoggedInUser.getNotes().add(note);					
				userService.saveUser(thisLoggedInUser);
				return "redirect:/mynotes";
			}
			
	}
	}

// -------------Action: Create New Comment -------------------------------------
	@PostMapping("/notes/{noteId}/comment")
	public String createComment(@Valid @ModelAttribute("comment") Comment comment,
								BindingResult result,  Model model, @PathVariable("noteId") Long noteId, HttpSession session) {
		// grab the user from session.
		Long userId=(Long) session.getAttribute("user_id");
		if(userId == null) {
			return "redirect:/login";
		} else {
			User thisLoggedInUser = userService.findOne(userId);			
			model.addAttribute("thisLoggedInUser", thisLoggedInUser);
			
			
			
			if(result.hasErrors()) {
				return "viewNote.jsp";
			} else {
				
				Note thisOneNote = noteService.findNote(noteId);
				comment.setUser(thisLoggedInUser);
				comment.setNote(thisOneNote);		
				Comment thisComment = commentService.createComment(comment);
//				commentService.createComment(comment);
//				List<Comment> allDaComments = commentService.allComments();
				// add comment to note
				thisOneNote.getComment().add(thisComment);					
				noteService.createNote(thisOneNote);
				// add comment to user
//				thisLoggedInUser.getComments().add(thisComment);
//				userService.saveUser(thisLoggedInUser);
				
				return "redirect:/notes/{noteId}";				
			}
		}
	}
	


//----------------Display: Render Edit note form --------------------------------
	@GetMapping("/edit/{id}")
	public String editNote(@PathVariable("id") Long id, Model model) {
		Note note = noteService.findNote(id);
		model.addAttribute("note", note);
		return "editNote.jsp";
	}
	
//----------------Action: Update Note --------------------------------------------
	@PutMapping("/update/{id}")
	public String updateNote(@Valid @ModelAttribute("note")Note note,
								BindingResult result, HttpSession session){
		
		if(result.hasErrors()) {
			return "editNote.jsp";
		} else {
			// retrieve the user from session
			Long userId = (Long) session.getAttribute("user_id");
			if(userId == null) {
				return "redirect:/login";
			} else {
			Note n = noteService.findNote(note.getId());
			note.setUser(n.getUser());
			noteService.updateNote(note);
			return "redirect:/notes/{id}";
			}
		}
	}

	
//----------------Action: Delete Note --------------------------------------------
	@DeleteMapping("/mynotes/delete/{id}")
	public String deleteNote(@PathVariable("id") Long id) {	
		
		noteService.deleteNote(id);
		return "redirect:/mynotes";
	}


//---------------Action: Delete Comment -----------------------
	@DeleteMapping("/notes/delete/{noteId}/{commentId}")
	public String deleteComment(@PathVariable("noteId") Long noteId, 
									@PathVariable("commentId") Long commentId) {				
		
		commentService.deleteComment(commentId);	
		noteService.findNote(noteId);
		
		return "redirect:/notes/{noteId}";
	}
	
	
	

	
	
	
	
	
	
	
	
}
