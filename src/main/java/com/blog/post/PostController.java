package com.blog.post;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/post")
@Controller
public class PostController {

	@GetMapping("/post-list-view")
	public String postListView(Model model) {
		model.addAttribute("viewName", "post/postList");
		return "template/layout";
	}
	
} // public class PostController