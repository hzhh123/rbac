package cn.edu.controller;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import cn.edu.model.Role;
import cn.edu.service.RoleService;
import cn.edu.util.Source;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.edu.model.User;
import cn.edu.model.UserRole;
import cn.edu.service.UserRoleService;
import cn.edu.service.UserService;
import cn.edu.util.StringUtil;
import cn.edu.util.page.PageResult;

@RequestMapping("user")
@Controller
public class UserController {
	@Autowired
	private UserService userService;
	@Autowired
	private UserRoleService userRoleService;
	@Autowired
	private RoleService roleService;
	@RequestMapping
	public String index(){
		return "common/user/user";
	}
	@ResponseBody
	@RequestMapping("saveOrUpdate")
	public String saveOrUpdate(User user,@RequestParam(name = "roleids") Integer[] roleids){
		int b;
		if(user.getId()!=null){
			b=userService.update(user);
			userRoleService.deleteByUserid(user.getId());
			if(roleids!=null) {
				for (int i = 0; i < roleids.length; i++) {
					if(roleids[i]!=null) {
						UserRole ur = new UserRole();
						ur.setUserid(user.getId());
						ur.setRoleid(roleids[i]);
						userRoleService.insert(ur);
					}
				}
			}

		}else{
			User u=userService.getUserByUsername(user.getUsername());
			if(u!=null){
				return "0";
			}
			b=userService.save(user);
			u=userService.getUserByUsername(user.getUsername());
			if(roleids!=null) {
				for (int i = 0; i < roleids.length; i++) {
					if(roleids[i]!=null) {
						UserRole ur = new UserRole();
						ur.setUserid(u.getId());
						ur.setRoleid(roleids[i]);
						userRoleService.insert(ur);
					}
				}
			}
		}

		if(b==1){
			return "1";
		}
		return "2";
	}
//	@RequestMapping("saveOrUpdate")
//	public String saveOrUpdate(User user){
//		int b;
//		if(user.getId()!=null){
//			b=userService.update(user);
//		}else{
//			b=userService.save(user);
//		}
//		if(b==1){
//			return "user";
//		}
//		return "redirect:/user/prepare";
//	}
	@RequestMapping("prepareAdd")
	public String prepareAdd(Map<String,Object>map){
		List<Role>roles=roleService.selectAll();
		map.put("roles", roles);
		return "common/user/adduser";
	}
	@ResponseBody
	@RequestMapping("delete")
	public String delete(@RequestParam("ids[]")String ids){
		Integer[] _ids=StringUtil.parse(ids);
		int f=userService.deleteBatch(_ids);
		if(f>0){
			return "1";
		}
		return "0";
	}
	@RequestMapping("prepareEdit")
	public String prepareEdit(Integer id, Map<String,Object>map){
		User user=userService.selectByPrimary(id);
		List<Role>rList=roleService.selectByUserid(id);
		List<Role>roles=roleService.selectAll();
		for(Role role:roles){
			for (Role r:rList){
				if (r.getId()==role.getId()){
					role.setIscheck(true);
				}
			}
		}
		map.put("user", user);
		map.put("roles", roles);
		return "common/user/adduser";
	}

	@RequestMapping("association")
	public String association(Integer id, Map<String,Object>map){
		User user=userService.selectByPrimary(id);
		List<Role>rList=roleService.selectByUserid(id);
		List<Role>roles=roleService.selectAll();
		for(Role role:roles){
			for (Role r:rList){
				if (r.getId()==role.getId()){
					role.setIscheck(true);
				}
			}
		}
		map.put("user", user);
		map.put("roles", roles);
		return "common/user/associationRole";
	}
    @ResponseBody
	@RequestMapping("prepareEdit2")
	public Map<String,Object> prepareEdit2(Integer id){
		Map<String,Object>map=new HashMap<String,Object>();
		User user=userService.selectByPrimary(id);
		List<Role>rList=roleService.selectByUserid(id);
		List<Role>roles=roleService.selectAll();
		for(Role role:roles){
			for (Role r:rList){
				if (r.getId()==role.getId()){
					role.setIscheck(true);
				}
			}
		}
		map.put("user", user);
		map.put("roles", roles);
		return map;
	}
	
	@ResponseBody
	@RequestMapping("addRole")
	public String addRole(@RequestParam("userid")Integer userid,@RequestParam(name = "roleids",required = false)Integer[] roleids){
		try{
			userRoleService.deleteByUserid(userid);
			System.out.println(roleids);
			if(roleids!=null) {
				for (int i = 0; i < roleids.length; i++) {
					if(roleids[i]!=null) {
						UserRole ur = new UserRole();
						ur.setUserid(userid);
						ur.setRoleid(roleids[i]);
						userRoleService.insert(ur);
					}
				}
			}
			return "1";
		}catch(Exception e){
			e.printStackTrace();
		}
		return "0";
	}
	
	@ResponseBody
	@RequestMapping("editRole")
	public Map<String,Object> editRole(@RequestParam("userid")Integer userid){
		Map<String,Object>map=new HashMap<String,Object>();
		List<Integer>rids=new ArrayList<Integer>();
		List<UserRole>urList=userRoleService.selectByUserid(userid);
		for(UserRole ur:urList){
			rids.add(ur.getRoleid());
		}
		map.put("rids", rids);
		return map;
	}
	@ResponseBody
	@RequestMapping("list")
	public PageResult<User>searchlist(Integer pageNumber,Integer pageSize,
			User user){
		if(!user.getUsername().equals("") || !user.getStatue().equals("")){
			return userService.find(pageSize,pageNumber,user);
		}
		return userService.find(pageSize,pageNumber);
		
	}
	@ResponseBody
	@RequestMapping("validateUsername")
	public Map<String,Object>validateUsername(String username){
		Map<String,Object>map=new HashMap<String,Object>();
		User user=userService.getUserByUsername(username);
		if (user==null){
			map.put("valid",true);
		}else {
			map.put("valid",false);
		}
		return map;
	}
	@ResponseBody
	@RequestMapping("update")
	public String update(User user){
		try{
			userService.update(user);
			System.out.println(user.getUsername());
			return "1";

		}catch (Exception e){
			e.printStackTrace();
		}
		return "0";
	}
	@ResponseBody
	@RequestMapping("statue")
	public List<Source> getStatue(){
		List<Source>sources=new ArrayList<Source>();
		sources.add(new Source(1,"有效"));
		sources.add(new Source(0,"无效"));
		return sources;
	}
}
