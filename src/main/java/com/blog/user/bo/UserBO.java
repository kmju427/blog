package com.blog.user.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.blog.common.FileManagerService;
import com.blog.user.entity.UserEntity;
import com.blog.user.repository.UserRepository;

@Service
public class UserBO {
	
	@Autowired
	private FileManagerService fileManegerService;
	
	@Autowired
	private UserRepository userRepository;
	
	// 아이디 중복 조회
	// input : loginId / output : UserEntity(존재하거나 없거나)
	public UserEntity getUserEntityByLoginId(String loginId) {
		return userRepository.findByLoginId(loginId);
	}
	
	// 닉네임 중복 조회
	// input : nickname / output : UserEntity(존재하거나 없거나)
	public UserEntity getUserEntityByNickname(String nickname) {
		return userRepository.findByNickname(nickname);
	}

	// 회원가입
	// input : loginId, password, name, email, nickname, file / output : Integer id(pk)
	public Integer addUser(String loginId, String password, String name, String email, String nickname, MultipartFile file) {
		String profileImagePath = null;
		
		// 이미지가 있으면 업로드 후 profileImagePath 받아온다.
		if (file != null) {
			profileImagePath = fileManegerService.saveFile(loginId, file);
		}
		
		UserEntity userEntity = userRepository.save(
					UserEntity.builder()
						.loginId(loginId)
						.password(password)
						.name(name)
						.email(email)
						.nickname(nickname)
						.profileImagePath(profileImagePath)
						.build());
		
		return userEntity == null ? null : userEntity.getId();
	}
	
	// 로그인
	// input : loginId, password / output : UserEntity
	public UserEntity getUserEntityByLoginIdPassword(String loginId, String password) {
		return userRepository.findByLoginIdAndPassword(loginId, password);
	}
	
	// 회원정보 수정
	// input : password, email, nickname, file / output : X
	public void updateUserById(int userId, String userLoginId, String password, String email, String nickname, MultipartFile file) {
		// 파일이 있을 경우
		// 새 이미지를 업로드하고, 기존 이미지 제거(기존 이미지가 있다면)
		String imagePath = null;
		
		if (file != null) {
			// 업로드
			imagePath = fileManegerService.saveFile(userLoginId, file);
			
			// 업로드 성공 시 기존 이미지가 있으면 제거
//			if (imagePath != null && ) {
//				
//			}
		}
	}
	
} // public class UserBO