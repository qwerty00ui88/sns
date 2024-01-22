package com.sns.comment.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sns.comment.domain.Comment;

@Mapper
public interface CommentMapper {
	
	public void insertComment(
			@Param("postId") int postId, 
			@Param("userId") int userId, 
			@Param("content") String content);
	
	public List<Comment> selectCommentList();
	
	public List<Comment> selectCommentListByPostId(int postId);
	
	public void deleteCommentById(int commentId);
	
}
