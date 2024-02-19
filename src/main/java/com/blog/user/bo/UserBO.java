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
	public void updateUserEntityById(int userId, String userLoginId, String password, String email, String nickname, MultipartFile file) {
		// 프로필 이미지가 없을 경우, 등록한 이미지 업로드
		String imagePath = null;
		
		if (file != null) {
			// 업로드
			imagePath = fileManegerService.saveFile(userLoginId, file);
		}
		
		UserEntity user = userRepository.findById(userId).orElse(null);
		
		if (user != null) {
			user = user.toBuilder()
					.password(password == null ? user.getPassword() : password)
					.email(email == null ? user.getEmail() : email)
					.nickname(nickname == null ? user.getNickname() : nickname)
					.profileImagePath(imagePath == null ? user.getProfileImagePath() : imagePath)
					.build();
			
			user = userRepository.save(user);
		}
	}
	
} // public class UserBO