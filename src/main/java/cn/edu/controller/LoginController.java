package cn.edu.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.edu.model.User;
import cn.edu.service.UserService;
import cn.edu.util.Const;

@Controller
public class LoginController {
	@Autowired
	private UserService userService;
	@RequestMapping("/initLogin")
	public String initLogin(){
		return "login";
	}
	@ResponseBody
	@RequestMapping("login")
	public String login(User user,HttpServletRequest request){
		User loginUser=userService.getUserByUsernameAndPassword(user.getUsername(),user.getPassword());
		if(loginUser!=null){
			request.getSession().setAttribute(Const.SESSION_USER, loginUser);
			return "1";
		}
		return "0";
	}
	@RequestMapping("logout")
	public String logout(HttpServletRequest request){
		request.getSession().removeAttribute(Const.SESSION_USER);
		return "login";
	}
	@ResponseBody
	@RequestMapping("validateUsername")
	public String validateUsername(String username){
		User user=userService.getUserByUsername(username);
		if(user!=null){
			return "1";
		}
		return "0";
	}
	@RequestMapping("index")
	public String index(){
		return "index";
	}

}
