package cn.edu.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.edu.model.Menu;
import cn.edu.model.User;
import cn.edu.service.MenuService;
import cn.edu.service.UserRoleService;
import cn.edu.util.Const;
import cn.edu.util.TreeNode;
import cn.edu.util.TreeNodeUtil;

@Controller
@RequestMapping("menu")
public class MenuController {
	@Autowired
	private MenuService menuService;
	@Autowired
	private UserRoleService userRoleService;
	@RequestMapping("home")
	public String index(){
		return "home";
	}
	@ResponseBody
	@RequestMapping("list")
	public List<TreeNode>getMenu(HttpServletRequest req){
		User user=(User)req.getSession().getAttribute(Const.SESSION_USER);
		Integer[] _roleids=userRoleService.getRoleids(user.getId());
		List<Menu>menus=menuService.findByRoleids(_roleids);
		List<TreeNode>nodes=TreeNodeUtil.toListNode(menus);
		return TreeNodeUtil.tree(nodes, 0);
	}
}
