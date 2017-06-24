package cn.edu.service;

import java.util.List;

import cn.edu.model.Menu;

public interface MenuService {
	List<Menu>findByRoleid(Integer roleid);
	List<Menu>findByRoleids(Integer[] roleids);
	List<Menu>findAll();
}
