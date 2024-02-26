package com.blog.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.blog.common.EncryptUtils;
import com.blog.user.bo.UserBO;
import com.blog.user.entity.UserEntity;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@RequestMapping("/user")
@RestController
public class UserRestController {
	
	@Autowired
	private UserBO userBO;
	
	/**
	 * 아이디 중복 확인 API
	 * @param loginId
	 * @return
	 */
	@GetMapping("/is-duplicated-id")
	public Map<String, Object> isDuplicatedId(
			@RequestParam("loginId") String loginId) {
		// DB 조회 - loginId
		UserEntity user = userBO.getUserEntityByLoginId(loginId);
		
		Map<String, Object> result = new HashMap<>();
		
		if (user != null) {
			result.put("code", 200);
			result.put("is_duplicated_id", true);
		} else {
			result.put("code", 200);
			result.put("is_duplicated_id", false);
		}
		
		return result;
	}
	
	/**
	 * 닉네임 중복 확인 API
	 * @param nickname
	 * @return
	 */
	@GetMapping("/is-duplicated-nickname")
	public Map<String, Object> isDuplicatedNickname(
			@RequestParam("nickname") String nickname) {
		// DB 조회 - nickname
		UserEntity user = userBO.getUserEntityByNickname(nickname);
		
		Map<String, Object> result = new HashMap<>();
		
		if (user != null) {
			result.put("code", 200);
			result.put("is_duplicated_nickname", true);
		} else {
			result.put("code", 200);
			result.put("is_duplicated_nickname", false);
		}
		
		return result;
	}
	
	/**
	 * 회원가입 API
	 * @param loginId
	 * @param password
	 * @param name
	 * @param email
	 * @param nickname
	 * @param file
	 * @return
	 */
	@PostMapping("/sign-up")
	public Map<String, Object> signUp(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			@RequestParam("name") String name,
			@RequestParam("email") String email,
			@RequestParam("nickname") String nickname,
			@RequestParam(value = "file", required = false) MultipartFile file) {
		// md5 알고리즘 -> password hashing
		String hashedPassword = EncryptUtils.md5(password);
		
		// DB insert
		Integer userId = userBO.addUser(loginId, hashedPassword, name, email, nickname, file);
		
		// 응답값
		Map<String, Object> result = new HashMap<>();
		
		if (userId != null) {
			result.put("code", 200);
			result.put("result", "성공");
		} else {
			result.put("code", 500);
			result.put("error_message", "회원가입에 실패했습니다.");
		}
		
		return result;
	}
	
	/**
	 * 로그인 API
	 * @param loginId
	 * @param password
	 * @param request
	 * @return
	 */
	@PostMapping("/sign-in")
	public Map<String, Object> signIn(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			HttpServletRequest request) {
		// password hashing
		String hashedPassword = EncryptUtils.md5(password);
		
		// DB 조회(loginId, hashedPassword)
		UserEntity user = userBO.getUserEntityByLoginIdPassword(loginId, hashedPassword);
		
		// 응답값
		Map<String, Object> result = new HashMap<>();
		
		if (user != null) { // 로그인 성공
			// 로그인 처리 - 로그인 정보를 세션에 담는다.
			HttpSession session = request.getSession();
			session.setAttribute("userId", user.getId());
			session.setAttribute("userLoginId", user.getLoginId());
			session.setAttribute("userName", user.getName());
			session.setAttribute("userEmail", user.getEmail());
			session.setAttribute("userNickname", user.getNickname());
			session.setAttribute("userProfileImagePath", user.getProfileImagePath());
			
			result.put("code", 200);
			result.put("result", "성공");
		} else {
			result.put("code", 500);
			result.put("error_message", "존재하지 않는 사용자입니다.");
		}
		
		return result;
	}
	
	@PutMapping("/data-modify")
	public Map<String, Object> dataModify(
			@RequestParam(value = "password", required = false) String password,
			@RequestParam(value = "email", required = false) String email,
			@RequestParam(value = "nickname", required = false) String nickname,
			@RequestParam(value = "file", required = false) MultipartFile file,
			HttpSession session) {
		// 세션에서 필요한 데이터 꺼내기
		int userId = (int)session.getAttribute("userId");
		String userLoginId = (String)session.getAttribute("userLoginId");
		
		// md5 알고리즘 -> password hashing
		String hashedPassword = EncryptUtils.md5(password);
		
		// DB update
		userBO.updateUserEntityById(userId, userLoginId, hashedPassword, email, nickname, file);
		
		Map<String, Object> result = new HashMap<>();
		result.put("code", 200);
		result.put("result", "성공");
		
		return result;
	}
	
} // public class UserRestController