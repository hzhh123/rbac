package cn.edu.controller;

import cn.edu.model.Menu;
import cn.edu.model.Role;
import cn.edu.model.RoleMenu;
import cn.edu.service.MenuService;
import cn.edu.service.RoleMenuService;
import cn.edu.service.RoleService;
import cn.edu.util.StringUtil;
import cn.edu.util.jstree.TreeNode;
import cn.edu.util.page.PageResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("role")
@Controller
public class RoleController {
    @Autowired
	private RoleService roleService;
	@Autowired
    private RoleMenuService roleMenuService;
	@Autowired
	private MenuService menuService;
	@RequestMapping
	public String index(){
		return "common/role/role";
	}
	@ResponseBody
	@RequestMapping("saveOrUpdate")
	public Map<String,Object> saveOrUpdate(Role role){
		Map<String,Object>map=new HashMap<String,Object>();
		int b;
		if(role.getId()!=null){
			b=roleService.update(role);
		}else{
			b=roleService.save(role);
			System.out.println(role.getId());
		}
		if(b==1){
			map.put("role",role);
			map.put("msg","1");
		}else {
			map.put("msg","2");
		}
		return map;
	}


	@ResponseBody
	@RequestMapping("delete")
	public String delete(@RequestParam("ids[]")String ids){
		Integer[] _ids=StringUtil.parse(ids);
		int f=roleService.deleteBatch(_ids);
		if(f>0){
			return "1";
		}
		return "0";
	}

	@ResponseBody
	@RequestMapping("prepareEdit")
	public Role prepareEdit(Integer id){
		Role role=roleService.selectByPrimary(id);
		return role;
	}




	@ResponseBody
	@RequestMapping("list")
	public PageResult<Role> searchlist(Integer pageNumber, Integer pageSize,
									   Role role){
		if(!role.getRolename().equals("") || !role.getStatue().equals("")){
			return roleService.find(pageSize,pageNumber,role);
		}
		return roleService.find(pageSize,pageNumber);

	}
	@ResponseBody
	@RequestMapping("validateRolename")
	public Map<String,Object>validateRolename(String rolename){
		Map<String,Object>map=new HashMap<String,Object>();
		Role role=roleService.getRoleByRolename(rolename);
		if (role==null){
			map.put("valid",true);
		}else {
			map.put("valid",false);
		}
		return map;
	}

	@ResponseBody
	@RequestMapping("update")
	public String update( Role role){
		try{
			roleService.update(role);
			return "1";

		}catch (Exception e){
			e.printStackTrace();
		}
		return "0";
	}
	@ResponseBody
	@RequestMapping("ajax_nodes")
	public List<TreeNode>jstreeMenu(Integer roleid){
		List<Menu>mList=menuService.findByRoleid(roleid);
		List<Menu>menus=menuService.findAll();
		List<TreeNode>nodes=new ArrayList<TreeNode>();
		for (int i = 0; i < menus.size(); i++) {
			TreeNode node=new TreeNode();
			node.setId(menus.get(i).getId().toString());
			node.setParent(menus.get(i).getParentid()==null||menus.get(i).getParentid()==0?"#":menus.get(i).getParentid().toString());
			node.setIcon(menus.get(i).getIcon()==null?"":menus.get(i).getIcon());
			node.setText(menus.get(i).getName()==null?"":menus.get(i).getName());
			Map<String,Object>map=new HashMap<String,Object>();
			map.put("url",menus.get(i).getUrl()==null?"":menus.get(i).getUrl());
			node.setA_attr(map);
			Map<String,Object>map1=new HashMap<String,Object>();
			boolean opened=false;
			boolean selected=false;
			for (int j = 0; j <mList.size() ; j++) {
				if (menus.get(i).equals(mList.get(j))){
					opened=true;
					selected=true;
				}
			}
			map1.put("opened",opened);
			map1.put("selected",selected);
			node.setState(map1);
			nodes.add(node);
		}
		return nodes;
	}
	@ResponseBody
	@RequestMapping("association")
	public String association(Integer roleid,@RequestParam("ids[]")String ids){
		try{
			roleMenuService.delete(roleid);
			if(!ids.equals("")) {
				Integer[] _ids = StringUtil.parse(ids);
				for (Integer menuid : _ids) {
					RoleMenu rm = new RoleMenu();
					rm.setRoleid(roleid);
					rm.setMenuid(menuid);
					roleMenuService.insert(rm);
				}
			}
			return "1";
		}catch (Exception e){
			e.printStackTrace();
		}
		return "0";
	}
}