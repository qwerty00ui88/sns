package com.sns.timeline;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sns.post.bo.PostBO;
import com.sns.post.entity.PostEntity;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/timeline")
@Controller
public class TimelineController {

	@Autowired
	private PostBO postBO;
	
	// http://localhost/timeline/timeline-view
	@GetMapping("/timeline-view")
	public String timelineView(Model model, HttpSession session) {
		// 로그인 -> 글쓰기 가능, 비로그인 -> 글쓰기 불가
		Integer userId = (Integer)session.getAttribute("userId");
		
		// select
		List<PostEntity> postList= postBO.getPostEntityList();
		
		// model
		model.addAttribute("userId", userId);
		model.addAttribute("postList", postList);
		model.addAttribute("viewName", "timeline/timeline");
		
		return "template/layout";
	}
	
}
