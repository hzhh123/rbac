package cn.edu.service.impl;

import cn.edu.dao.MenuMapper;
import cn.edu.model.Menu;
import cn.edu.service.MenuService;
import cn.edu.util.CollectionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
@Service("menuService")
public class MenuServiceImpl implements MenuService {
	@Autowired
   private MenuMapper menuMapper;
	@Override
	public List<Menu> findByRoleid(Integer roleid) {
		// TODO Auto-generated method stub
		return menuMapper.findByRoleid(roleid);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Menu> findByRoleids(Integer[] roleids) {
		List<Menu>menus=new ArrayList<Menu>();
		for(Integer roleid:roleids){
			List<Menu>mList=findByRoleid(roleid);
			menus.addAll(mList);
		}
		menus=(List<Menu>) CollectionUtil.removeDuplicate(menus);
		return menus;
	}

	@Override
	public List<Menu> findAll() {
		return menuMapper.findAll();
	}
}
