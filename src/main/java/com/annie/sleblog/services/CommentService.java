package com.annie.sleblog.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.annie.sleblog.models.Comment;
import com.annie.sleblog.repositories.CommentRepository;

@Service
public class CommentService {	
	@Autowired
	private CommentRepository commentRepository;
	
//-------Create ------------------------------------------
	public Comment createComment(Comment comment) {
		return commentRepository.save(comment);
	}

//-------Read One-----------------------------------------
	public Comment findComment(Long id) {
		Optional<Comment> optionalComment = commentRepository.findById(id);
			if(optionalComment.isPresent()) {
				return optionalComment.get();
			} else {
				return null;
			}
	}
//------Read All -----------------------------------------------
	public List<Comment> allComments(){
		return commentRepository.findAllByOrderByIdDesc();
	}

	

//----------Delete -------------------------------------------------
	public void deleteComment(Long id) {
		commentRepository.deleteById(id);
	}
	
	
	
}
