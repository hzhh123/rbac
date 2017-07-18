package cn.edu.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import cn.edu.util.Source;
import cn.edu.util.page.PageResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	@RequestMapping
	public String menu(){
		return "common/menu/menu";
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
	@ResponseBody
	@RequestMapping("jstree")
	public List<cn.edu.util.jstree.TreeNode>jstree(){
		List<Menu>menus=menuService.findAll();
		List<cn.edu.util.jstree.TreeNode>nodes=new ArrayList<cn.edu.util.jstree.TreeNode>();
		for (int i = 0; i < menus.size(); i++) {
			cn.edu.util.jstree.TreeNode node=new cn.edu.util.jstree.TreeNode();
			node.setId(menus.get(i).getId().toString());
			node.setParent(menus.get(i).getParentid()==null||menus.get(i).getParentid()==0?"#":menus.get(i).getParentid().toString());
			node.setIcon("fa fa-folder");
			node.setText(menus.get(i).getName()==null?"":menus.get(i).getName());
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("url",menus.get(i).getUrl()==null?"":menus.get(i).getUrl());
			node.setA_attr(map);
			nodes.add(node);
		}
		return nodes;
	}
	@ResponseBody
	@RequestMapping("all")
	public PageResult<Menu> list(Integer pageNumber, Integer pageSize){
		return menuService.find(pageSize,pageNumber);
	}

	@ResponseBody
	@RequestMapping("selectParentmenu")
	public List<Source>selectParentmenu(){
		List<Source>sources=new ArrayList<Source>();
		List<Menu>menus=menuService.findParentMenu();
		sources.add(new Source(0,""));
		for (Menu menu:menus){
			Source source=new Source();
			source.setValue(menu.getId());
			source.setText(menu.getName());
			sources.add(source);
		}
		return sources;

	}
	@ResponseBody
	@RequestMapping("update")
	public String update(Menu menu){
		try{
		  menuService.update(menu);
		  return "1";
		}catch (Exception e){
			e.printStackTrace();
		}
		return "0";
	}
	@ResponseBody
	@RequestMapping("save")
	public String save(Menu menu){
		try{
			menuService.save(menu);
			return "1";
		}catch (Exception e){
			e.printStackTrace();
		}
		return "0";
	}
	@ResponseBody
	@RequestMapping("delete")
	public String delete(@RequestParam("id[]") Integer[] ids){
		try{
			for(Integer id:ids){
				menuService.delete(id);
			}
			return "1";
		}catch (Exception e){
			e.printStackTrace();
		}
		return "0";
	}
	@ResponseBody
	@RequestMapping("selectMenuById")
	public Menu selectMenuById(Integer id){
		return menuService.selectById(id);
	}
}
