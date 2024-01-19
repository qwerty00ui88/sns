package com.sns.timeline.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.post.bo.PostBO;
import com.sns.post.entity.PostEntity;
import com.sns.timeline.domain.CardView;
import com.sns.user.bo.UserBO;
import com.sns.user.entity.UserEntity;

@Service
public class TimelineBO {

	@Autowired
	private PostBO postBO;
	
	@Autowired
	private UserBO userBO;
	
	// input: X   output: List<CardView>
	public List<CardView> generateCardViewList() {
		List<CardView> cardViewList = new ArrayList<>();
		
		// 글 목록을 가져온다. List<PostEntity>
		List<PostEntity> postList = postBO.getPostEntityList();
		
		// 글 목록 반복문 순회
		// post => cardView     => cardViewList에 넣기
		for(PostEntity post : postList) {
			CardView card = new CardView();
			card.setPost(post);
			UserEntity user = userBO.getUserEntityByUserId(post.getUserId());
			card.setUser(user);
		}
		
		return cardViewList;
	}
	
}
