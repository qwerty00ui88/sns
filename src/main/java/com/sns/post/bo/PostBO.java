package com.sns.post.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sns.comment.bo.CommentBO;
import com.sns.common.FileManagerService;
import com.sns.like.bo.LikeBO;
import com.sns.post.entity.PostEntity;
import com.sns.post.repository.PostRepository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PostBO {
	
	@Autowired
	private PostRepository postRepository;
	
	@Autowired
	private FileManagerService fileManagerService;
	
	@Autowired
	private CommentBO commentBO;
	
	@Autowired
	private LikeBO likeBO;
	
	public List<PostEntity> getPostEntityList() {
		return postRepository.findAllByOrderByIdDesc();
	}
	
	public PostEntity addPost(
			int userId,
			String userLoginId,
			String content,
			MultipartFile file) {
		// imagePath 초기화
		String imagePath = null;
		
		// file이 있으면 경로 할당
		if(file != null) {
			imagePath = fileManagerService.saveFile(userLoginId, file);
		}
		
		// Mapper 요청
		return postRepository.save(PostEntity.builder()
				.userId(userId)
				.content(content)
				.imagePath(imagePath)
				.build());
	}
	
	public void deletePostByPostId(int postId) {
		// 기존 글 가져오기
		PostEntity post = postRepository.findById(postId).orElse(null);
		if(post == null) {
			log.info("[글 삭제] post is null. postId:{}", postId);
			return;
		}
		
		// 글 삭제
		postRepository.deleteById(postId);
		
		// 이미지 있으면 삭제
		if(post.getImagePath() != null) {
			fileManagerService.deleteFile(post.getImagePath());
		}
		
		// 댓글들 삭제
		commentBO.deleteCommentByPostId(postId);
		
		// 좋아요들 삭제
		likeBO.deleteLikeByPostId(postId);
	}

}
