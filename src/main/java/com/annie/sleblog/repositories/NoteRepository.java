package com.annie.sleblog.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.annie.sleblog.models.Note;

@Repository
public interface NoteRepository extends CrudRepository<Note, Long> {

	List<Note> findAll();
	
	List<Note> findAllByOrderByIdDesc();
}
