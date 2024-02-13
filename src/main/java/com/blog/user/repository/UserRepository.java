package com.blog.user.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.blog.user.entity.UserEntity;

public interface UserRepository extends JpaRepository<UserEntity, Integer> {

	// 아이디 중복 조회
	public UserEntity findByLoginId(String loginId);
	
	// 닉네임 중복 조회
	public UserEntity findByNickname(String nickname);
	
	// 로그인
	public UserEntity findByLoginIdAndPassword(String loginId, String password);
	
} // public interface UserRepository