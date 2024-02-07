package com.blog.post.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PostMapper {

	// input : X / output : List<Map> - 테스트용
	public List<Map<String, Object>> selectPostList();
	
} // public interface PostMapper 