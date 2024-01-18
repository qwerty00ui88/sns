package com.sns.post.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sns.common.FileManagerService;
import com.sns.post.entity.PostEntity;
import com.sns.post.repository.PostRepository;

@Service
public class PostBO {
	
	@Autowired
	private PostRepository postRepository;
	
	@Autowired
	private FileManagerService fileManagerService;
	
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

}
