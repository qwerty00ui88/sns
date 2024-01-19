package com.sns.comment.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.comment.domain.Comment;
import com.sns.comment.mapper.CommentMapper;

@Service
public class CommentBO {
	
	@Autowired
	private CommentMapper commentMapper;
	
	public void addComment(int postId, int userId, String content) {
		commentMapper.insertComment(postId, userId, content);
	}
	
	public List<Comment> getCommentList() {
		return commentMapper.selectCommentList();
	}
	
}
