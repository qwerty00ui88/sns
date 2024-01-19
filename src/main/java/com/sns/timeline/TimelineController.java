package com.sns.timeline;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sns.timeline.bo.TimelineBO;
import com.sns.timeline.domain.CardView;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/timeline")
@Controller
public class TimelineController {

//	@Autowired
//	private PostBO postBO;
//	
//	@Autowired 
//	private CommentBO commentBO;
	
	@Autowired
	private TimelineBO timelineBO;
	
	// http://localhost/timeline/timeline-view
	@GetMapping("/timeline-view")
	public String timelineView(Model model, HttpSession session) {
//		// select
//		List<PostEntity> postList= postBO.getPostEntityList();
//		List<Comment> commentList = commentBO.getCommentList();
//		
//		// model
//		model.addAttribute("postList", postList);
//		model.addAttribute("commentList", commentList);
		
		List<CardView> cardList = timelineBO.generateCardViewList();
		model.addAttribute("cardList", cardList);
		model.addAttribute("viewName", "timeline/timeline");
		
		return "template/layout";
	}
	
}
