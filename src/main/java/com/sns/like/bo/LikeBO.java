package com.sns.like.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.like.domain.Like;
import com.sns.like.mapper.LikeMapper;

@Service
public class LikeBO {
	
	@Autowired
	private LikeMapper likeMapper;
	
	// input: postId, userId   output: X
	public void likeToggle(int postId, int userId) {
		
		int likeCount = likeMapper.selectLikeCountByPostIdUserId(postId, userId);
		
		if(likeCount > 0) {
			// like 있으면 삭제
			likeMapper.deleteLike(postId, userId);
		} else {
			// like 없으면 추가
			likeMapper.insertLike(postId, userId);
		}
	}
	
	public int getLikeCountByPostId(int postId) {
		return likeMapper.selectLikeCountByPostId(postId);
	}
	
	public int getLikeCountByPostIdUserId(int postId, int userId) {
		return likeMapper.selectLikeCountByPostIdUserId(postId, userId);
	}
	
}
