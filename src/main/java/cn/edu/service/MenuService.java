package cn.edu.service;

import cn.edu.model.Menu;
import cn.edu.util.page.PageResult;

import java.util.List;

public interface MenuService {
	List<Menu>findByRoleid(Integer roleid);
	List<Menu>findByRoleids(Integer[] roleids);
	List<Menu>findAll();
	List<Menu>findParentMenu();
	public PageResult<Menu> find(Integer pageSize, Integer pageNo);
	int update(Menu menu);
	int save(Menu menu);
	int delete(Integer id);
	Menu selectById(Integer id);
}
