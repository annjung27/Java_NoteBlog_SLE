package com.annie.sleblog.services;





import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.annie.sleblog.models.Note;
import com.annie.sleblog.repositories.NoteRepository;
import com.annie.sleblog.repositories.UserRepository;

@Service
public class NoteService {
	@Autowired
	private NoteRepository noteRepository;
	@Autowired
	private UserRepository userRepository;
	
	//--------READ ALL --------------------------------------
	public List<Note> allNotes(){
		return noteRepository.findAllByOrderByIdDesc();
	}
	
	//-------CREATE ----------------------------------------
	public Note createNote(Note note){		
		

		
		return noteRepository.save(note);
	}
	
	//----------READ ONE-----------------------------------
	public Note findNote(Long id) {
		Optional<Note> optionalNote = noteRepository.findById(id);
			if(optionalNote.isPresent()) {
				return optionalNote.get();
			} else {
				return null;
			}
	}
	
	//-----------UPDATE -------------------------------------
	
	public Note updateNote(Note note) {
		return noteRepository.save(note);
	}	
	
	//----------DELETE ----------------------------------
	public void deleteNote(Long id) {
		noteRepository.deleteById(id);
	}
	
}
